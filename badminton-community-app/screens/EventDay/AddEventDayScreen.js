// AddEventDayScreen.js
import React, { useState } from 'react';
import { View, Text, TextInput, Button, StyleSheet, Alert, TouchableOpacity } from 'react-native';
import * as SecureStore from 'expo-secure-store';
import DateTimePicker from '@react-native-community/datetimepicker';

const AddEventDayScreen = ({ navigation, route }) => {
  const { eventId } = route.params;
  const [date, setDate] = useState('');
  const [note, setNote] = useState('');
  const [loading, setLoading] = useState(false);
  const [showDatePicker, setShowDatePicker] = useState(false);

  const handleDateChange = (event, selectedDate) => {
    setShowDatePicker(false);
    if (selectedDate) {
      setDate(selectedDate.toISOString().split('T')[0]); // Format YYYY-MM-DD
    }
  };

  const handleSave = async () => {
    if (!date) {
      Alert.alert('Validation Error', 'Date is required.');
      return;
    }

    setLoading(true);

    try {
      const token = await SecureStore.getItemAsync('userToken');
      if (!token) {
        throw new Error('User token not found');
      }

      const response = await fetch('https://api.pbbedahulu.my.id/mabar/day/create', {
        method: 'POST',
        headers: {
          'Authorization': `${token}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          open_mabar_id: eventId,
          date: date,
          note: note,
        }),
      });

      const data = await response.json();

      if (response.ok) {
        Alert.alert('Success', 'Event day added successfully');
        navigation.navigate('EventDayList', {eventId, refresh: true}); // Kembali ke EventDayListScreen
      } else {
        let errorMessage = data.message || 'Failed to add event day';
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
    } finally {
      setLoading(false);
    }
  };

return (
    <View style={styles.container}>
      <Text style={styles.label}>Date</Text>
      <TouchableOpacity onPress={() => setShowDatePicker(true)}>
        <TextInput
          style={styles.input}
          placeholder="YYYY-MM-DD"
          value={date}
          editable={false} // Nonaktifkan input manual, hanya menggunakan DateTimePicker
        />
      </TouchableOpacity>
      {showDatePicker && (
        <DateTimePicker
          value={new Date()} // Pastikan nilai awal adalah tanggal valid
          mode="date"
          display="default"
          onChange={handleDateChange}
        />
      )}
      <Text style={styles.label}>Note (Optional)</Text>
      <TextInput
        style={styles.input}
        placeholder="Note"
        value={note}
        onChangeText={setNote}
      />
      <Button title={loading ? 'Saving...' : 'Save Event Day'} onPress={handleSave} disabled={loading} />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
    backgroundColor: '#f5f5f5',
  },
  label: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 8,
    color: '#333',
  },
  input: {
    height: 50,
    borderColor: 'gray',
    borderWidth: 1,
    marginBottom: 16,
    padding: 10,
    backgroundColor: '#fff',
    borderRadius: 5,
  },
});

export default AddEventDayScreen;
