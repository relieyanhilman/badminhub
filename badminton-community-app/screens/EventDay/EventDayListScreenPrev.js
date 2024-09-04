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

  const [recaps, setRecaps] = useState({});
  const [expandedItems, setExpandedItems] = useState({}); // To handle dropdown visibility

  useEffect(() => {
    fetchEventDays();
  }, []);

  useFocusEffect(
    useCallback(() => {
      if (route.params?.refresh) {
        fetchEventDays();  // Fetch ulang data jika refresh true
        // Reset refresh parameter agar tidak terjadi loop fetching
        navigation.setParams({ refresh: false });
      }
    }, [route.params?.refresh])
  );

  const fetchEventDays = async () => {
    setLoading(true);
    setError(null);

    try {
      const token = await SecureStore.getItemAsync('userToken');
      if (!token) {
        throw new Error('User token not found');
      }

      const response = await fetch(`https://apiv2.pbbedahulu.my.id/mabar/${eventId}`, {
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

  const fetchRecap = async (dayId) => {
    try {
      const token = await SecureStore.getItemAsync('userToken');
      if (!token) {
        throw new Error('User token not found');
      }

      const response = await fetch(`https://appv2.pbbedahulu.my.id/mabar/day/recap/${dayId}`, {
        method: 'GET',
        headers: {
          'Authorization': `${token}`,
          'Content-Type': 'application/json',
        },
      });

      const data = await response.json();

      if (response.ok && data.success) {
        setRecaps((prevRecaps) => ({
          ...prevRecaps,
          [dayId]: data.data[0],
        }));
      } else {
        Alert.alert('Error', data.message || 'Failed to retrieve recap');
      }
    } catch (error) {
      console.error('Failed to fetch recap:', error);
      Alert.alert('Error', 'An error occurred while fetching the recap');
    }
  };

  const generateRecap = async (dayId, shuttlecockProvided) => {
    try {
      const token = await SecureStore.getItemAsync('userToken');
      if (!token) {
        throw new Error('User token not found');
      }

      const response = await fetch(`https://appv2.pbbedahulu.my.id/mabar/day/recap/generate`, {
        method: 'POST',
        headers: {
          'Authorization': `${token}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          open_mabar_day_id: dayId,
          shuttlecock_provided: shuttlecockProvided,
          note: '',
        }),
      });

      const data = await response.json();

      if (response.ok && data.success) {
        await fetchRecap(dayId); // Fetch recap after generating it
      } else {
        Alert.alert('Error', data.message || 'Failed to generate recap');
      }
    } catch (error) {
      console.error('Failed to generate recap:', error);
      Alert.alert('Error', 'An error occurred while generating the recap');
    }
  };

  const handleToggleExpand = (dayId, isRecapGenerated) => {
    setExpandedItems((prevExpandedItems) => ({
      ...prevExpandedItems,
      [dayId]: !prevExpandedItems[dayId],
    }));

    if (!isRecapGenerated) {
      generateRecap(dayId, 36); // Example: 36 shuttlecock provided, customize as needed
    } else if (!recaps[dayId]) {
      fetchRecap(dayId);
    }
  };

  const handleRegenerateRecap = (dayId) => {
    generateRecap(dayId, 36); // Regenerate recap with same process
  };

  const formatDate = (dateString) => {
    const date = new Date(dateString);
    return new Intl.DateTimeFormat('id-ID', { day: '2-digit', month: 'long', year: 'numeric' }).format(date);
  };

  const handleEventDayPress = (item) => {
    navigation.navigate('EventDetail', { dayId: item.id, eventDayName: formatDate(item.date) });
  };

  const handleEditPress = (day) => {
    navigation.navigate('EditEventDay', { eventId, day });
  };

  const renderItem = ({ item }) => {
    const isRecapGenerated = !!recaps[item.id];
    const isExpanded = expandedItems[item.id];

  return (
    <View style={styles.itemContainer}>
     <TouchableOpacity onPress={() => handleEventDayPress(item)}>
        <Text style={styles.text}>Date: {formatDate(item.date)}</Text>
        <Text style={styles.text}>Note: {item.note}</Text>
     </TouchableOpacity>

     <Button title="Edit" onPress={() => handleEditPress(item)} />

        <View style={styles.buttonContainer}>
          <Button title="Recap" onPress={() => handleToggleExpand(item.id, isRecapGenerated)} />
        </View>

        {isExpanded && recaps[item.id] && (
          <View style={styles.recapContainer}>
            <Text style={styles.text}>Member Count: {recaps[item.id].participant_count_member}</Text>
            <Text style={styles.text}>Non-member Count: {recaps[item.id].participant_count_nonmember}</Text>
            <Text style={styles.text}>Total Matches: {recaps[item.id].total_matches_count}</Text>
            <Text style={styles.text}>Shuttlecock Provided: {recaps[item.id].shuttlecock_provided}</Text>
            <Text style={styles.text}>Shuttlecock Used: {recaps[item.id].shuttlecock_used}</Text>
            <Text style={styles.text}>Shuttlecock Available: {recaps[item.id].shuttlecock_available}</Text>
            <Text style={styles.text}>Total Participants: {recaps[item.id].participant_count_total}</Text>
            <Button title="Regenerate Recap" onPress={() => handleRegenerateRecap(item.id)} />
          </View>
        )}

    </View>

  );
  }

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
    flexDirection: '',
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
  button: {
    backgroundColor: '#555555',
    padding: 10,
    marginVertical: 4,
    borderRadius: 4,
    alignItems: 'center',
  },
});

export default EventDayListScreen;
