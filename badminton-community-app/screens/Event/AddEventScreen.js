// screens/AddEventScreen.js
import React, { useState } from 'react';
import { View, Text, TextInput, Button, StyleSheet, Alert } from 'react-native';

const AddEventScreen = ({ navigation }) => {
  const [event, setEvent] = useState({
    id: Math.random().toString(),
    namaEvent: '',
    hall_id: '',
    hari_bermain: '',
    waktu_bermain: '',
    jumlah_court_yang_digunakan: '',
    max_slot_pemain: '',
    htm_member: '',
    htm_nonmember: '',
  });

  const handleSave = () => {
     if (
        !event.namaEvent ||
        !event.hall_id ||
        !event.hari_bermain ||
        !event.waktu_bermain ||
        !event.jumlah_court_yang_digunakan ||
        !event.max_slot_pemain ||
        !event.htm_member ||
        !event.htm_nonmember
        ) {
        // Jika ada field yang belum diisi, tampilkan pesan peringatan
        Alert.alert('Error', 'All fields are required!');
        return;
        }
    navigation.navigate('EventList', {newEvent: event})
  };

  return (
    <View style={styles.container}>
      <TextInput
        placeholder="Nama Event"
        value={event.namaEvent}
        onChangeText={(text) => setEvent({ ...event, namaEvent: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="Hall ID"
        value={event.hall_id}
        onChangeText={(text) => setEvent({ ...event, hall_id: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="Hari Bermain"
        value={event.hari_bermain}
        onChangeText={(text) => setEvent({ ...event, hari_bermain: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="Waktu Bermain"
        value={event.waktu_bermain}
        onChangeText={(text) => setEvent({ ...event, waktu_bermain: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="Jumlah Court yang Digunakan"
        value={event.jumlah_court_yang_digunakan}
        onChangeText={(text) => setEvent({ ...event, jumlah_court_yang_digunakan: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="Max Slot Pemain"
        value={event.max_slot_pemain}
        onChangeText={(text) => setEvent({ ...event, max_slot_pemain: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="HTM Member"
        value={event.htm_member}
        onChangeText={(text) => setEvent({ ...event, htm_member: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="HTM Nonmember"
        value={event.htm_nonmember}
        onChangeText={(text) => setEvent({ ...event, htm_nonmember: text })}
        style={styles.input}
      />
      <Button title="Save Event" onPress={handleSave} />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
  },
  input: {
    height: 40,
    borderColor: 'gray',
    borderWidth: 1,
    marginBottom: 12,
    padding: 8,
  },
});

export default AddEventScreen;
