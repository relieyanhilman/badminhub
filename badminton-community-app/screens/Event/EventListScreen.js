// screens/EventListScreen.js
import React, {useState, useEffect} from 'react';
import { View, Text, FlatList, Button, TouchableOpacity, StyleSheet, Alert } from 'react-native';

const EventListScreen = ({ navigation, route }) => {
  const [events, setEvents] = useState([
    { id: '1', namaEvent: 'Open Mabar January', hall_id: '1', hari_bermain: 'Saturday', waktu_bermain: '4-6 PM', jumlah_court_yang_digunakan: 4, max_slot_pemain: 40, htm_member: 35000, htm_nonmember: 45000,  },
    // Tambahkan data event di sini
  ]);

 useEffect(() => {
  if (route.params?.newEvent){
     setEvents((prevEvents) => [...prevEvents, route.params.newEvent])
  } else if(route.params?.updatedEvent){
     handleUpdateEvent(route.params.updatedEvent)
  }
 }, [route.params?.newEvent, route.params?.updatedEvent])

 const handleEventPress = (eventId) => {
      // Navigasi ke EventDetail, mengirimkan eventId sebagai parameter
      navigation.navigate('EventDetail', { eventId });
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
  }

  const handleDeleteEvent = (eventId) => {
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
            onPress: () => {
              // Logika untuk menghapus event dari state
              setEvents((prevEvents) => prevEvents.filter((event) => event.id !== eventId));
            },
            style: "destructive"
          }
        ]
      );
    };

  const renderItem = ({ item }) => (
    <TouchableOpacity onPress={() => handleEventPress(item.id)}>
      <View style={styles.card}>
        <View style={styles.cardHeader}>
          <Text style={styles.eventName} numberOfLines={2} ellipsizeMode="tail" minimumFontScale={0.8}>{item.namaEvent}</Text>
          <View style={styles.itemButtons}>
            <Button title="Edit" onPress={() => handleEditEvent(item)} />
            <Button title="Delete" onPress={() => handleDeleteEvent(item.id)} color="red" />
          </View>
        </View>
        <View style={styles.cardContent}>
          <View style={styles.row}>
            <Text style={styles.label}>Hari Bermain:</Text>
            <Text style={styles.value}>{item.hari_bermain}</Text>
          </View>
          <View style={styles.row}>
            <Text style={styles.label}>Waktu Bermain:</Text>
            <Text style={styles.value}>{item.waktu_bermain}</Text>
          </View>
          <View style={styles.row}>
            <Text style={styles.label}>Court:</Text>
            <Text style={styles.value}>{item.jumlah_court_yang_digunakan}</Text>
          </View>
          <View style={styles.row}>
            <Text style={styles.label}>Slot Pemain:</Text>
            <Text style={styles.value}>{item.max_slot_pemain}</Text>
          </View>
          <View style={styles.row}>
            <Text style={styles.label}>HTM Member:</Text>
            <Text style={styles.value}>Rp{item.htm_member.toLocaleString()}</Text>
          </View>
          <View style={styles.row}>
            <Text style={styles.label}>HTM Nonmember:</Text>
            <Text style={styles.value}>Rp{item.htm_nonmember.toLocaleString()}</Text>
          </View>
        </View>
      </View>
    </TouchableOpacity>
  );

  return (
    <View style={styles.container}>
      <Button title="Add Event" onPress={handleAddEvent} />
      <FlatList
        data={events}
        renderItem={renderItem}
        keyExtractor={(item) => item.id}
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
    marginRight: 10
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