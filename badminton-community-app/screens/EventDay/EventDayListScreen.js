// EventDayListScreen.js
import React, { useState, useEffect, useCallback, useContext } from 'react';
import { View, Text, FlatList, Button, TouchableOpacity, StyleSheet, ActivityIndicator, Alert } from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome'; // Menggunakan FontAwesome untuk ikon
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
  const [isRegenerating, setIsRegenerating] = useState(false); // State untuk melacak regenerasi recap
  const [loadingItems, setLoadingItems] = useState({}); // State untuk melacak loading generate recap per item

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

      if(route.params?.dayIdUpdated !== undefined){
        generateRecap(route.params?.dayIdUpdated);

        navigation.setParams({ dayIdUpdated : 0})
      }
    }, [route.params?.refresh, route.params?.dayIdUpdated])
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

      const response = await fetch(`https://apiv2.pbbedahulu.my.id/mabar/day/recap/${dayId}`, {
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
    } finally {
      setLoadingItems((prevLoadingItems) => ({
      ...prevLoadingItems,
      [dayId]: false,
    }));
      }
  };

  const generateRecap = async (dayId) => {
    setIsRegenerating(true); // Mulai proses regenerasi
    try {
      const token = await SecureStore.getItemAsync('userToken');
      if (!token) {
        throw new Error('User token not found');
      }

      const response = await fetch(`https://apiv2.pbbedahulu.my.id/mabar/day/recap/generate`, {
        method: 'POST',
        headers: {
          'Authorization': `${token}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          open_mabar_day_id: dayId,
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
    } finally {
      setIsRegenerating(false); // Proses regenerasi selesai
    }
  };

  const handleToggleExpand = (dayId, isRecapGenerated) => {
    setExpandedItems((prevExpandedItems) => ({
      ...prevExpandedItems,
      [dayId]: !prevExpandedItems[dayId],
    }));

    if (!isRecapGenerated) {
      setLoadingItems((prevLoadingItems) => ({
        ...prevLoadingItems,
        [dayId]: true,
      })); // Set loading saat generate recap dimulai
      generateRecap(dayId); // Example: 36 shuttlecock provided, customize as needed
    } else if (!recaps[dayId]) {
      fetchRecap(dayId);
    }
  };

  const handleRegenerateRecap = (dayId) => {
    generateRecap(dayId); // Regenerate recap with same process
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
    const isLoading = loadingItems[item.id]; // Periksa apakah item sedang loading

  return (
    <View style={styles.itemContainer}>

        <View style={styles.dateNoteEdit}>
             <TouchableOpacity onPress={() => handleEventDayPress(item)}>

                <View style={{flexDirection: 'row'}}>
                    <Text style={[styles.text, {fontWeight: 'bold'}]}>Date: </Text>
                    <Text style={styles.text}>{formatDate(item.date)}</Text>
                </View>

                <View style={{flexDirection: 'row'}}>
                    <Text style={[styles.text, {fontWeight: 'bold'}]}>Note: </Text>
                    <Text style={styles.text}>{item.note}</Text>
                </View>

                { item.shuttlecock_provided !== null ? (<View style={{flexDirection: 'row'}}>
                    <Text style={[styles.text, {fontWeight: 'bold'}]}>Shuttlecock provided: </Text>
                    <Text style={styles.text}>{item.shuttlecock_provided} </Text>
                    </View>) : null}



             </TouchableOpacity>

             <TouchableOpacity style={[styles.button, styles.editButton]} onPress={() => handleEditPress(item)}>
                <Text style={[styles.text, {color: 'white'}]}>Edit</Text>
             </TouchableOpacity>
         </View>

       <TouchableOpacity style={styles.recapIconTouchable} onPress={() => handleToggleExpand(item.id, isRecapGenerated)}>
        <View style={styles.recapIconContainer}>
          <Text style={styles.recapText}>RECAP</Text>
           {isLoading? (
                <ActivityIndicator size="small" color="#333" />
           ) : (
                <Icon name={isExpanded ? 'chevron-up' : 'chevron-down'} size={20} color="#333" />
           )}
        </View>
       </TouchableOpacity>

        {isExpanded && recaps[item.id] && (
          <View style={styles.recapContainer}>
            <View style={styles.recapItem}>
              <Text style={styles.recapLabel}>Member Count:</Text>
              <Text style={styles.recapValue}>{recaps[item.id].participant_count_member}</Text>
            </View>
            <View style={styles.recapItem}>
              <Text style={styles.recapLabel}>Non-member Count:</Text>
              <Text style={styles.recapValue}>{recaps[item.id].participant_count_nonmember}</Text>
            </View>
            <View style={[styles.recapItem, {marginTop: 5}]}>
              <Text style={styles.recapLabel}>Shuttlecock Provided:</Text>
              <Text style={styles.recapValue}>{recaps[item.id].shuttlecock_provided}</Text>
            </View>
            <View style={[styles.recapItem]}>
              <Text style={styles.recapLabel}>Shuttlecock Used:</Text>
              <Text style={styles.recapValue}>{recaps[item.id].shuttlecock_used}</Text>
            </View>
            <View style={styles.recapItem}>
              <Text style={styles.recapLabel}>Shuttlecock Available:</Text>
              <Text style={styles.recapValue}>{recaps[item.id].shuttlecock_available}</Text>
            </View>
            <View style={[styles.recapItem, {marginTop: 5}]}>
              <Text style={styles.recapLabel}>Total Participants:</Text>
              <Text style={styles.recapValue}>{recaps[item.id].participant_count_total}</Text>
            </View>
            <View style={styles.recapItem}>
              <Text style={styles.recapLabel}>Total Matches:</Text>
              <Text style={styles.recapValue}>{recaps[item.id].total_matches_count}</Text>
            </View>
            <TouchableOpacity
              onPress={() => handleRegenerateRecap(item.id)}
              style={[styles.button, styles.regenerateButton]}
              disabled={isRegenerating} // Nonaktifkan tombol saat regenerasi berlangsung
            >
              {isRegenerating ? (
                <ActivityIndicator size="small" color="#fff" /> // Tampilkan loading saat regenerasi
              ) : (
                <Text style={{ color: 'white' }}>Regenerate Recap</Text>
              )}
            </TouchableOpacity>
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
  dateNoteEdit: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center'
  },
  recapContainer: {
    marginTop: 10,
    padding: 16,
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 8,
    backgroundColor: '#f9f9f9',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  recapItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 8,
  },
  recapLabel: {
    fontWeight: 'bold',
    color: '#333',
  },
  recapValue: {
    color: '#555',
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
    flexDirection: 'column',
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
  regenerateButton: {
    backgroundColor: '#007bff', // Warna biru untuk tombol Regenerate
    marginTop: 16,
  },
  recapIconContainer: {
    alignItems: 'center', // Pusatkan teks dan ikon secara vertikal
    marginTop: 5, // Beri sedikit jarak dari atas
  },
  recapIconTouchable: {
    alignSelf: 'center',
    width: '100%',
  },
  recapText: {
    fontSize: 12, // Ukuran font kecil
    opacity: 0.6, // Opacity yang tidak terlalu tebal
    marginBottom: 2, // Jarak antara teks dan ikon
    color: '#333', // Warna teks
  },

});

export default EventDayListScreen;
