// EventDayListScreen.js
import React, { useState, useEffect, useCallback, useContext } from 'react';
import { View, Text, FlatList, Button, TouchableOpacity, StyleSheet, ActivityIndicator, Alert } from 'react-native';
import { useFocusEffect } from '@react-navigation/native';
import { EventContext } from '../../EventContext';
import * as SecureStore from 'expo-secure-store';

const EventDayListScreen = ({ navigation, route }) => {
  const {eventId} = useContext(EventContext)
  const [eventDays, setEventDays] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchEventDays();
  }, []);

  const fetchEventDays = async () => {
    setLoading(true);
    setError(null);

    try {
      const token = await SecureStore.getItemAsync('userToken');
      if (!token) {
        throw new Error('User token not found');
      }

      const response = await fetch(`https://api.pbbedahulu.my.id/mabar/${eventId}`, {
        method: 'GET',
        headers: {
          'Authorization': `${token}`,
          'Content-Type': 'application/json',
        },
      });

      const data = await response.json();

      if (response.ok) {
       // Urutkan data berdasarkan tanggal, dari yang terbaru ke yang lebih lama
        const sortedData = data.data.sort((a, b) => new Date(b.date) - new Date(a.date));
        setEventDays(sortedData); // Set daftar hari Open Mabar
      } else {
        setError(data.message || 'Failed to fetch event days');
      }
    } catch (err) {
      console.log(err);
      setError('An error occurred while fetching data');
    } finally {
      setLoading(false);
    }
  };

  const formatDate = (dateString) => {
    const date = new Date(dateString);
    return new Intl.DateTimeFormat('id-ID', { day: '2-digit', month: 'long', year: 'numeric' }).format(date);
  };

  useFocusEffect(
    useCallback(() => {
      if (route.params?.refresh) {
        fetchEventDays();  // Fetch ulang data jika refresh true
        // Reset refresh parameter agar tidak terjadi loop fetching
        navigation.setParams({ refresh: false });
      }
    }, [route.params?.refresh])
  );

  const handleEventDayPress = (item) => {
    navigation.navigate('EventDetail', { dayId: item.id, eventDayName: formatDate(item.date) });
  };

  const handleEditPress = (day) => {
    navigation.navigate('EditEventDay', { eventId, day });
  };

  const renderItem = ({ item }) => (
    <View style={styles.itemContainer}>
     <TouchableOpacity onPress={() => handleEventDayPress(item)}>
        <Text style={styles.text}>Date: {formatDate(item.date)}</Text>
        <Text style={styles.text}>Note: {item.note}</Text>
     </TouchableOpacity>
     <Button title="Edit" onPress={() => handleEditPress(item)} />
    </View>

  );

  if (loading) {
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
        <Button title="Try Again" onPress={fetchEventDays} />
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <Button title="Add Event Day" onPress={() => navigation.navigate('AddEventDay', { eventId })} />
      <FlatList
        data={eventDays}
        renderItem={renderItem}
        keyExtractor={(item) => item.id.toString()}
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
  itemContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    backgroundColor: '#fff',
    padding: 16,
    borderRadius: 8,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  text: {
    fontSize: 16,
    color: '#333',
  },
});

export default EventDayListScreen;
