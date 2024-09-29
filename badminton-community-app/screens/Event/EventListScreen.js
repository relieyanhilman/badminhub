// Event/EventListScreen.js

import React, {useState, useEffect, useCallback, useContext} from 'react';
import { View, Text, FlatList, Button, TouchableOpacity, StyleSheet, Alert, ActivityIndicator, TextInput } from 'react-native';
import { useFocusEffect } from '@react-navigation/native';
import { EventContext } from '../../EventContext';

import * as SecureStore from 'expo-secure-store';

const EventListScreen = ({ navigation, route }) => {
  const [events, setEvents] = useState([]);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [error, setError] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [searchQuery, setSearchQuery] = useState(''); // State untuk query pencarian

  const {updateEvent} = useContext(EventContext)

  const handleLogout = async () => {
    await SecureStore.deleteItemAsync('userToken'); // Hapus token dari SecureStore
    navigation.replace('Login'); // Arahkan ke halaman Login
  };

  const fetchEvents = async (page = 1, perPage = 10, search = '') => {
    if (page > totalPages && page !== 1) return;

    if (page === 1) {
      setLoading(true);
      setEvents([]);  // Reset events when starting a new search
    } else {
      setLoadingMore(true);
    }

    setError(null);

    try {
      const token = await SecureStore.getItemAsync('userToken');
      if (!token) {
        throw new Error('User token not found');
      }
      const response = await fetch('https://apiv2.pbbedahulu.my.id/mabar', {
        method: 'POST',
        headers: {
          'Authorization': `${token}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ page, perPage, search })
      });

      const data = await response.json();
      if (response.ok) {
        const dataRender = data["data"];

        // Pastikan tidak ada duplikasi data dengan melakukan filter terhadap ID yang sama
        const mergedEvents = page === 1
          ? dataRender
          : [...events, ...dataRender].filter((v, i, a) => a.findIndex(t => (t.id === v.id)) === i);

        setEvents(mergedEvents);
        setTotalPages(data.pagination.totalPages);
        setCurrentPage(data.pagination.currentPage);
      } else if (response.status === 401) { // Jika status 401, token tidak valid
        Alert.alert('Session Expired', 'Your session has expired. Please login again.');
        handleLogout(); // Hapus token dan arahkan ke Login
      } else {
        setError(data.message || 'Failed to fetch events');
      }
    } catch (err) {
      console.log(err);
      setError(err.message || 'An error occurred while fetching data');
    } finally {
      setLoading(false);
      setLoadingMore(false);
    }
  };

  useFocusEffect(
    useCallback(() => {
      if (route.params?.refresh) {
        fetchEvents();  // Fetch data again if refresh is true

        // menghapus refresh param setelah fetching
        navigation.setParams({ refresh: false });

      }
    }, [route.params?.refresh])
  );

  useEffect(() => {
    fetchEvents();
  }, []);

  const handleEventPress = (eventId, eventName, eventHallId, eventHtmMember) => {
    updateEvent(eventId, eventName, eventHallId, eventHtmMember)
    navigation.navigate('EventDay');
  };

  const handleAddEvent = () => {
    navigation.navigate('AddEvent');
  };

  const handleEditEvent = (event) => {
    navigation.navigate('EditEvent', { event });
  };

  const handleUpdateEvent = (updatedEvent) => {
    setEvents((prevEvents) =>
      prevEvents.map((event) =>
        event.id === updatedEvent.id ? updatedEvent : event
      )
    );
  };

  const handleDeleteEvent = async (eventId) => {
    Alert.alert(
      "Delete Event",
      "Are you sure you want to delete this event?",
      [
        {
          text: "Cancel",
          style: "cancel"
        },
        {
          text: "Delete",
          onPress: async () => {
            try {
              const token = await SecureStore.getItemAsync('userToken');
              if (!token) {
                throw new Error('User token not found');
              }

              const response = await fetch(`https://apiv2.pbbedahulu.my.id/mabar/${eventId}`, {
                method: 'DELETE',
                headers: {
                  'Authorization': `${token}`,
                  'Content-Type': 'application/json',
                },
              });

              if (response.ok) {
                fetchEvents()
                Alert.alert('Success', 'Event deleted successfully');
              } else {
                let errorMessage = 'Failed to delete event';
                if (response.status === 401) {
                  errorMessage = 'Unauthorized access';
                  await SecureStore.deleteItemAsync('userToken');
                  navigation.replace('Login');
                }
                Alert.alert('Error', errorMessage);
              }
            } catch (err) {
              console.log(err);
              Alert.alert('Error', 'Something went wrong. Please try again later.');
            }
          },
          style: "destructive"
        }
      ]
    );
  };

  const handleSearchSubmit = () => {
    setCurrentPage(1);  // Reset page number
    fetchEvents(1, 10, searchQuery);  // Start fetching from page 1 with the search query
  };

  const renderItem = ({ item }) => (
    <TouchableOpacity onPress={() => handleEventPress(item.id, item.name, item.hall_id, item.htm_member)}>
      <View style={styles.card}>
        <View style={styles.cardHeader}>
          <Text style={styles.eventName} numberOfLines={2} ellipsizeMode="tail" minimumFontScale={0.8}>{item.name}</Text>
          <View style={styles.itemButtons}>
            <Button title="Edit" onPress={() => handleEditEvent(item)} />
            <Button title="Delete" onPress={() => handleDeleteEvent(item.id)} color="red" />
          </View>
        </View>
        <View style={styles.cardContent}>
          <View style={styles.row}>
            <Text style={styles.label}>Hall:</Text>
            <Text style={styles.value}>{item.hall.name}</Text>
          </View>
          <View style={styles.row}>
            <Text style={styles.label}>Hari & Waktu Bermain:</Text>
            <Text style={styles.value}>{item.day}, {item.time}</Text>
          </View>
          <View style={styles.row}>
            <Text style={styles.label}>Court:</Text>
            <Text style={styles.value}>{item.court_count_used}</Text>
          </View>
          <View style={styles.row}>
            <Text style={styles.label}>Slot Pemain:</Text>
            <Text style={styles.value}>{item.max_slot}</Text>
          </View>
          <View style={styles.row}>
            <Text style={styles.label}>HTM Member:</Text>
            <Text style={styles.value}>Rp{item.htm_member.toLocaleString()}</Text>
          </View>
          <View style={styles.row}>
            <Text style={styles.label}>HTM Nonmember:</Text>
            <Text style={styles.value}>Rp{item.htm_nonmember.toLocaleString()}</Text>
          </View>
          <View style={styles.row}>
            <Text style={styles.label}>Note:</Text>
            <Text style={styles.value}>{item.note}</Text>
          </View>
        </View>
      </View>
    </TouchableOpacity>
  );

  if (loading && currentPage === 1) {
    return (
      <View style={styles.loadingContainer}>
        <ActivityIndicator size="large" color="#0000ff" />
      </View>
    );
  }

  if (error) {
    return (
      <View style={styles.errorContainer}>
        <Text style={styles.errorText}>{error}</Text>
        <Button title="Try Again" onPress={() => fetchEvents()} />
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <TextInput
        style={styles.searchInput}
        placeholder="Search events..."
        value={searchQuery}
        onChangeText={setSearchQuery}
        onSubmitEditing={handleSearchSubmit} // Memulai pencarian saat pengguna menekan "enter"
      />
      <Button title="Add Event" onPress={handleAddEvent} />
      <FlatList
        data={events}
        renderItem={renderItem}
        keyExtractor={(item) => item.id.toString()}
        onEndReached={() => fetchEvents(currentPage + 1, 10, searchQuery)}
        onEndReachedThreshold={0.5}
        ListFooterComponent={loadingMore ? <ActivityIndicator size="small" color="#0000ff" /> : null}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
    backgroundColor: '#f5f5f5',
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  errorContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  errorText: {
    fontSize: 18,
    color: 'red',
    marginBottom: 16,
  },
  searchInput: {
    height: 40,
    borderColor: 'gray',
    borderWidth: 1,
    borderRadius: 5,
    paddingHorizontal: 8,
    marginBottom: 16,
  },
  card: {
    backgroundColor: '#fff',
    borderRadius: 8,
    padding: 16,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  cardHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 12,
  },
  eventName: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    flexShrink: 1,
    marginRight: 10,
  },
  itemButtons: {
    flexDirection: 'row',
    justifyContent: 'flex-end',
  },
  cardContent: {
    paddingTop: 10,
    borderTopWidth: 1,
    borderTopColor: '#eee',
  },
  row: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 8,
  },
  label: {
    fontSize: 14,
    color: '#555',
    fontWeight: '500',
  },
  value: {
    fontSize: 14,
    color: '#000',
  },
});


export default EventListScreen;
