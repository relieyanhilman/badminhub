import React, { useState, useEffect, useRef} from 'react';
import { View, Text, TextInput, Button, StyleSheet, Alert, ScrollView, KeyboardAvoidingView, Platform, TouchableOpacity, ActivityIndicator } from 'react-native';
import * as SecureStore from 'expo-secure-store';
import DateTimePicker from '@react-native-community/datetimepicker';
import { Picker } from '@react-native-picker/picker';

const EditEventScreen = ({ route, navigation }) => {
  const { event } = route.params;

  const [eventData, setEventData] = useState({
    id: event.id,
    name: event.name,
    hall_id: event.hall_id.toString(),
    day: event.day,
    court_count_used: event.court_count_used.toString(),
    max_slot: event.max_slot.toString(),
    htm_member: event.htm_member.toString(),
    htm_nonmember: event.htm_nonmember.toString(),
  });

  const courtCountUsedRef = useRef()
  const endTimeUsedRef = useRef()

  const [loading, setLoading] = useState(false);
  const [timePickerVisible, setTimePickerVisible] = useState({ visible: false, field: '' });
  const [halls, setHalls] = useState([]);
  const [page, setPage] = useState(1);
  const [allHallsFetched, setAllHallsFetched] = useState(false);
  const [loadingHalls, setLoadingHalls] = useState(false);

  const [start_time, setStartTime] = useState((event.time).split("-")[0]); // State sementara untuk start_time
  const [end_time, setEndTime] = useState((event.time).split("-")[1]); // State sementara untuk end_time

  const handleInputChange = (field, value) => {
    setEventData({ ...eventData, [field]: value });
  };

  const handleTimeChange = (event, selectedTime) => {
    setTimePickerVisible(false);
    if (selectedTime) {
      let hours = selectedTime.getHours();
      const minutes = selectedTime.getMinutes();
      const ampm = hours >= 12 ? 'PM' : 'AM';

      hours = hours % 12;
      hours = hours ? hours : 12;
      const minutesStr = minutes < 10 ? `0${minutes}` : minutes;

      const formattedTime = `${hours}:${minutesStr} ${ampm}`;

      if (timePickerVisible.field === 'start_time') {
        setStartTime(formattedTime);
        endTimeUsedRef.current.focus()
      } else if (timePickerVisible.field === 'end_time') {
        setEndTime(formattedTime);
        courtCountUsedRef.current.focus(); // Fokus ke input berikutnya
      }
    }
  };

  const showTimePicker = (field) => {
    setTimePickerVisible({visible: true, field});
  };

  const fetchHalls = async (pageNumber = 1, reset = false) => {
      if (reset) {
        setHalls([]); // Kosongkan daftar hall saat melakukan refresh
        setAllHallsFetched(false); // Reset status pengambilan semua hall
        setPage(pageNumber = 1); // Reset halaman
      }

//      if (allHallsFetched && !reset) return; // Jangan fetch lagi jika semua hall sudah diambil

      setLoadingHalls(true)
      try {
        const token = await SecureStore.getItemAsync('userToken');
        if (!token) {
          throw new Error('User token not found');
        }

        const response = await fetch('https://api.pbbedahulu.my.id/hall', {
          method: 'POST',
          headers: {
            'Authorization': `${token}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ page: pageNumber, perPage: 10})
        });

        const data = await response.json();
        if (response.ok && data.success) {
          setHalls(prevHalls => [...prevHalls, ...data.data]);

          if (pageNumber >= data.pagination.totalPages) {
            setAllHallsFetched(true);
            setPage(1)
          } else {
            setPage(pageNumber + 1);
          }
        } else {
          Alert.alert('Error', data.message || 'Failed to fetch halls');
        }
      } catch (err) {
        console.log(err);
        Alert.alert('Error', 'Something went wrong. Please try again later.');
      } finally{
        setLoadingHalls(false)
      }
    };

  useEffect(() => {
    if (!allHallsFetched) {
      fetchHalls(pageNumber = page);
    }
  }, [page]);
  const handleSave = async () => {
    if (
      !eventData.name.trim() ||
      !eventData.hall_id.trim() ||
      !eventData.day.trim() ||
      !start_time.trim() ||
      !end_time.trim() ||
      !eventData.court_count_used.trim() ||
      !eventData.max_slot.trim() ||
      !eventData.htm_member.trim() ||
      !eventData.htm_nonmember.trim()
    ) {
      Alert.alert('Invalid input', 'Please fill in all fields');
      return;
    }

    setLoading(true);

    try {
      // Gabungkan start_time dan end_time menjadi satu string untuk atribut time
      const combinedTime = `${start_time}-${end_time}`;
      setEventData({ ...eventData, time: combinedTime });

      const token = await SecureStore.getItemAsync('userToken');
      if (!token) {
        throw new Error('User token not found');
      }

      const response = await fetch('https://api.pbbedahulu.my.id/mabar/update', {
        method: 'POST',
        headers: {
          'Authorization': `${token}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          id: parseInt(eventData.id),
          name: eventData.name,
          hall_id: parseInt(eventData.hall_id),
          day: eventData.day,
          time: combinedTime,
          court_count_used: parseInt(eventData.court_count_used),
          max_slot: parseInt(eventData.max_slot),
          htm_member: parseFloat(eventData.htm_member),
          htm_nonmember: parseFloat(eventData.htm_nonmember),
        }),
      });

      const data = await response.json();

      if (response.ok) {
        Alert.alert('Success', 'Event updated successfully');
        navigation.navigate('EventList', { refresh: true }); // Kirim data event yang telah diupdate ke EventListScreen
      } else {
        let errorMessage = data.message || 'Failed to update event';
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
        <Text style={styles.label}>Nama Event</Text>
        <TextInput
          placeholder="Nama Event"
          value={eventData.name}
          onChangeText={(text) => handleInputChange('name', text)}
          style={styles.input}
        />

        <View style={styles.pickerContainer}>
          <Text style={styles.label}>Hall</Text>
          <View style={styles.pickerRow}>
            <Picker
              selectedValue={eventData.hall_id}
              onValueChange={(itemValue) => {
                handleInputChange('hall_id', itemValue);
              }}
              style={styles.picker}
            >
              <Picker.Item label="Select Hall" value="" />
              {halls.map((hall) => (
                <Picker.Item
                  key={hall.id}
                  label={`${hall.name} - ${hall.address}`}
                  value={hall.id.toString()}
                />
              ))}
            </Picker>
            <TouchableOpacity
              onPress={() => {
                fetchHalls(pageNumber = 1, true);
              }}
              style={styles.refreshButton}
            >
              {loadingHalls ? (
                <ActivityIndicator size="small" color="#0000ff" />
              ) : (
                <Text style={styles.refreshText}>Refresh</Text>
              )}
            </TouchableOpacity>
          </View>
        </View>

        <Text style={styles.label}>Hari Bermain</Text>
        <Picker
          selectedValue={eventData.day}
          onValueChange={(itemValue) => {
            handleInputChange('day', itemValue);
          }}
          style={styles.pickerDay}
        >
          <Picker.Item label="Sunday" value="sun" />
          <Picker.Item label="Monday" value="mon" />
          <Picker.Item label="Tuesday" value="tue" />
          <Picker.Item label="Wednesday" value="wed" />
          <Picker.Item label="Thursday" value="thu" />
          <Picker.Item label="Friday" value="fri" />
          <Picker.Item label="Saturday" value="sat" />
        </Picker>

        <Text style={styles.label}>Waktu Mulai</Text>
        <TextInput
          placeholder="Waktu Mulai"
          value={start_time}
          onFocus={() => showTimePicker('start_time')}
          style={styles.input}
        />

        <Text style={styles.label}>Waktu Selesai</Text>
        <TextInput
          placeholder="Waktu Selesai"
          value={end_time}
          onFocus={() => showTimePicker('end_time')}
          style={styles.input}
          ref= {endTimeUsedRef}
        />

        {timePickerVisible.visible && (
          <DateTimePicker
            value={new Date()}
            mode="time"
            display="default"
            onChange={handleTimeChange}
          />
        )}

        <Text style={styles.label}>Jumlah Court yang Digunakan</Text>
        <TextInput
          placeholder="Jumlah Court yang Digunakan"
          value={eventData.court_count_used}
          onChangeText={(text) => handleInputChange('court_count_used', text)}
          style={styles.input}
          keyboardType="numeric"
          ref={courtCountUsedRef}
        />

        <Text style={styles.label}>Max Slot Pemain</Text>
        <TextInput
          placeholder="Max Slot Pemain"
          value={eventData.max_slot}
          onChangeText={(text) => handleInputChange('max_slot', text)}
          style={styles.input}
          keyboardType="numeric"
        />

        <Text style={styles.label}>HTM Member</Text>
        <TextInput
          placeholder="HTM Member"
          value={eventData.htm_member}
          onChangeText={(text) => handleInputChange('htm_member', text)}
          style={styles.input}
          keyboardType="numeric"
        />

        <Text style={styles.label}>HTM Nonmember</Text>
        <TextInput
          placeholder="HTM Nonmember"
          value={eventData.htm_nonmember}
          onChangeText={(text) => handleInputChange('htm_nonmember', text)}
          style={styles.input}
          keyboardType="numeric"
          returnKeyType="done"
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
  pickerContainer: {
    marginBottom: 12,
  },
  pickerLabel: {
    marginBottom: 5,
  },
  pickerRow: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  picker: {
    flex: 1,
    height: 50,
    borderColor: 'gray',
    borderWidth: 1,
    padding: 10,
    backgroundColor: '#fff',
    borderRadius: 5,
  },
  refreshButton: {
    marginLeft: 10,
    padding: 10,
    backgroundColor: '#007BFF',
    borderRadius: 5,
  },
  refreshText: {
    color: '#fff',
    fontWeight: 'bold',
  },
  pickerDay: {
    height: 50,
    marginBottom: 12,
    backgroundColor: '#fff',
  },
  label: {
    fontSize: 16,
    marginBottom: 8,
    fontWeight: 'bold',
    color: '#333',
  },
  pickerDay: {
      height: 50,
      marginBottom: 12,
      backgroundColor: '#fff',
  },
});

export default EditEventScreen;
