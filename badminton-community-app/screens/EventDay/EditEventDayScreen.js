import React, { useState } from 'react';
import { View, Text, TextInput, Button, StyleSheet, Alert, ScrollView, KeyboardAvoidingView, Platform } from 'react-native';
import DateTimePicker from '@react-native-community/datetimepicker';
import * as SecureStore from 'expo-secure-store';

const EditEventDayScreen = ({ route, navigation }) => {
  const { day, eventId } = route.params;

  const [eventDayData, setEventDayData] = useState({
    id: day.id,
    open_mabar_id: eventId,
    date: day.date,
    note: day.note || '',
  });

  const [showDatePicker, setShowDatePicker] = useState(false);
  const [loading, setLoading] = useState(false);

  const handleInputChange = (field, value) => {
    setEventDayData({ ...eventDayData, [field]: value });
  };

  const handleDateChange = (event, selectedDate) => {
    setShowDatePicker(false);
    if (selectedDate) {
      const formattedDate = selectedDate.toISOString().split('T')[0];
      setEventDayData({ ...eventDayData, date: formattedDate });
    }
  };

  const handleSave = async () => {
    if (!eventDayData.date.trim()) {
      Alert.alert('Invalid input', 'Please select a date');
      return;
    }

    setLoading(true);

    try {
      const token = await SecureStore.getItemAsync('userToken');
      if (!token) {
        throw new Error('User token not found');
      }

      const response = await fetch('https://apiv2.pbbedahulu.my.id/mabar/day/update', {
        method: 'POST',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(eventDayData),
      });

      const data = await response.json();

      if (response.ok) {
        Alert.alert('Success', 'Event Day updated successfully');
        navigation.navigate('EventDayList', { refresh: true });
      } else {
        let errorMessage = data.message || 'Failed to update event day';
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
    <KeyboardAvoidingView
      style={{ flex: 1 }}
      behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
      keyboardVerticalOffset={Platform.OS === 'ios' ? 64 : 0}
    >
      <ScrollView contentContainerStyle={styles.container}>
        <Text style={styles.label}>Tanggal</Text>
        <TextInput
          placeholder="Date"
          value={eventDayData.date}
          onFocus={() => setShowDatePicker(true)}
          style={styles.input}
        />
        {showDatePicker && (
          <DateTimePicker
            value={new Date(eventDayData.date)}
            mode="date"
            display="default"
            onChange={handleDateChange}
          />
        )}

        <Text style={styles.label}>Note</Text>
        <TextInput
          placeholder="Note"
          value={eventDayData.note}
          onChangeText={(text) => handleInputChange('note', text)}
          style={styles.input}
        />

        <Button title={loading ? 'Saving...' : 'Save Changes'} onPress={handleSave} disabled={loading} />
      </ScrollView>
    </KeyboardAvoidingView>
  );
};

const styles = StyleSheet.create({
  container: {
    flexGrow: 1,
    padding: 16,
    backgroundColor: '#f2f2f2',
  },
  input: {
    height: 50,
    borderColor: 'gray',
    borderWidth: 1,
    marginBottom: 12,
    padding: 10,
    backgroundColor: '#fff',
    borderRadius: 5,
  },
  label: {
    fontSize: 16,
    marginBottom: 8,
    fontWeight: 'bold',
    color: '#333',
  },
});

export default EditEventDayScreen;
