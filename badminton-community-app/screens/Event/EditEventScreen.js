// screens/EditEventScreen.js
import React, { useState, useEffect } from 'react';
import { View, Text, TextInput, Button, StyleSheet } from 'react-native';

const EditEventScreen = ({ route, navigation }) => {
  // Ambil event data dari parameter navigasi
  const { event } = route.params;

  // Inisialisasi state dengan data event yang akan diedit
  const [eventData, setEventData] = useState({
    id: event.id,
    namaEvent: event.namaEvent,
    hall_id: event.hall_id,
    hari_bermain: event.hari_bermain,
    waktu_bermain: event.waktu_bermain,
    jumlah_court_yang_digunakan: event.jumlah_court_yang_digunakan,
    max_slot_pemain: event.max_slot_pemain,
    htm_member: event.htm_member,
    htm_nonmember: event.htm_nonmember,
  });

  // Fungsi untuk menangani penyimpanan perubahan
  const handleSave = () => {
    // Kirim event yang sudah di-update kembali ke EventListScreen
    navigation.navigate('EventList', { updatedEvent: eventData });
  };

  return (
    <View style={styles.container}>
      <TextInput
        placeholder="Nama Event"
        value={eventData.namaEvent}
        onChangeText={(text) => setEventData({ ...eventData, namaEvent: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="Hall ID"
        value={eventData.hall_id}
        onChangeText={(text) => setEventData({ ...eventData, hall_id: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="Hari Bermain"
        value={eventData.hari_bermain}
        onChangeText={(text) => setEventData({ ...eventData, hari_bermain: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="Waktu Bermain"
        value={eventData.waktu_bermain}
        onChangeText={(text) => setEventData({ ...eventData, waktu_bermain: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="Jumlah Court yang Digunakan"
        value={eventData.jumlah_court_yang_digunakan}
        onChangeText={(text) => setEventData({ ...eventData, jumlah_court_yang_digunakan: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="Max Slot Pemain"
        value={eventData.max_slot_pemain}
        onChangeText={(text) => setEventData({ ...eventData, max_slot_pemain: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="HTM Member"
        value={eventData.htm_member}
        onChangeText={(text) => setEventData({ ...eventData, htm_member: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="HTM Nonmember"
        value={eventData.htm_nonmember}
        onChangeText={(text) => setEventData({ ...eventData, htm_nonmember: text })}
        style={styles.input}
      />
      <Button title="Save Changes" onPress={handleSave} />
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

export default EditEventScreen;
