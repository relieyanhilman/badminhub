// Event/AddEventScreen.js

import React, { useState, useEffect, useRef } from 'react';
import { View, Text, TextInput, Button, StyleSheet, Alert, ScrollView, KeyboardAvoidingView, Platform, TouchableOpacity, ActivityIndicator  } from 'react-native';
import * as SecureStore from 'expo-secure-store';
import DateTimePicker from '@react-native-community/datetimepicker';
import { Picker } from '@react-native-picker/picker';

const AddEventScreen = ({ navigation }) => {
  const [name, setName] = useState('');
  const [hallId, setHallId] = useState('');
  const [day, setDay] = useState('');
  const [start_time, setStartTime] = useState('');
  const [end_time, setEndTime] = useState('');
  const [courtCountUsed, setCourtCountUsed] = useState('');
  const [maxSlot, setMaxSlot] = useState('');
  const [htmMember, setHtmMember] = useState('');
  const [htmNonmember, setHtmNonmember] = useState('');
  const [loading, setLoading] = useState(false);

  const [timePickerVisible, setTimePickerVisible] = useState({ visible: false, field: '' });

  //halls untuk menyimpan data sementara hasil fetching seluruh hall
  const [halls, setHalls] = useState([]);
  const [page, setPage] = useState(1);
  const [allHallsFetched, setAllHallsFetched] = useState(false);
  const [loadingHalls, setLoadingHalls] = useState(false);



  // Refs untuk setiap TextInput
  const hallIdRef = useRef();
  const dayRef = useRef();
  const startTimeUsedRef = useRef();
  const endTimeUsedRef = useRef()
  const courtCountUsedRef = useRef();
  const maxSlotRef = useRef();
  const htmMemberRef = useRef();
  const htmNonmemberRef = useRef();


  const showTimePicker = (field) => {
    setTimePickerVisible({ visible: true, field });
  };

  const handleTimeChange = (event, selectedTime) => {
    setTimePickerVisible(false);
    if (selectedTime) {
      let hours = selectedTime.getHours();
      const minutes = selectedTime.getMinutes();
      const ampm = hours >= 12 ? 'PM' : 'AM';

      hours = hours % 12;
      hours = hours ? hours : 12; // Menjadikan 0 jam menjadi 12
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

  const fetchHalls = async (pageNumber = 1, reset = false) => {
      if (reset) {
        setHalls([]); // Kosongkan daftar hall saat melakukan refresh
        setAllHallsFetched(false); // Reset status pengambilan semua hall
        setHallId("")
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
          body: JSON.stringify({ page: pageNumber, perPage: 10 })
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
    if (!allHallsFetched){
       fetchHalls(pageNumber = page)
    };
  }, [page]);

  const handleSave = async () => {
    // Validasi input
    if (!name.trim() || !hallId.trim() || !day.trim() || !start_time.trim() || !end_time.trim() || !courtCountUsed.trim() || !maxSlot.trim() || !htmMember.trim() || !htmNonmember.trim()) {
      Alert.alert('Validation Error', 'Please fill in all the required fields.');
      return;
    }

    setLoading(true);

    try {
      // Gabungkan start_time dan end_time menjadi satu string untuk atribut time
      const combinedTime = `${start_time}-${end_time}`;
      const token = await SecureStore.getItemAsync('userToken');
      if (!token) {
        throw new Error('User token not found');
      }

      const response = await fetch('https://api.pbbedahulu.my.id/mabar/create', {
        method: 'POST',
        headers: {
          'Authorization': `${token}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
        	name: name,
            hall_id: parseInt(hallId),
            day: day,
            time: combinedTime,
            court_count_used: parseInt(courtCountUsed),
            max_slot: parseInt(maxSlot),
            htm_member: parseFloat(htmMember),
            htm_nonmember: parseFloat(htmNonmember)
        }),
      });

      const data = await response.json();

      if (response.ok) {
        // Event berhasil dibuat, navigasi kembali ke EventListScreen
        navigation.navigate('EventList', {refresh: true }); // Kirim event baru ke EventListScreen
      } else {
        let errorMessage = data.message || 'Failed to create event';
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
      keyboardVerticalOffset={Platform.OS === 'ios' ? 64 : 0} // Sesuaikan dengan kebutuhan
    >
    <ScrollView contentContainerStyle={styles.container}>
      <TextInput
        placeholder="Nama Event"
        value={name}
        onChangeText={setName}
        style={styles.input}
        returnKeyType="next"
        onSubmitEditing={() => hallIdRef.current.focus()} // Fokus ke input berikutnya
      />

      <View style={styles.pickerContainer}>
          <Text style={styles.label}>Hall</Text>
          <View style={styles.pickerRow}>
            <Picker
              selectedValue={hallId}
              onValueChange={(itemValue) => {
                 setHallId(itemValue)
                 dayRef.current.focus()
              }}
              style={styles.picker}
              ref={hallIdRef}
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
                fetchHalls(pageNumber = 1, true)
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
        selectedValue={day}
        onValueChange={(itemValue, itemIndex) => {
          setDay(itemValue)
          startTimeUsedRef.current.focus(); // Memfokuskan ke TextInput waktu bermain setelah memilih hari
        }}
        style={styles.pickerDay}
        ref={dayRef}
        onSubmitEditing={() => showTimePicker()} // Menampilkan time picker
      >
        <Picker.Item label="Select Day" value="" />
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
          value={start_time}
          onFocus={() => showTimePicker('start_time')}
          style={styles.input}
          ref={startTimeUsedRef}
        />

        <Text style={styles.label}>Waktu Selesai</Text>
        <TextInput
          value={end_time}
          onFocus={() => showTimePicker('end_time')}
          style={styles.input}
          ref={endTimeUsedRef}
        />

        {timePickerVisible.visible && (
          <DateTimePicker
            value={new Date()}
            mode="time"
            display="default"
            onChange={handleTimeChange}
          />
        )}

      <TextInput
        placeholder="Jumlah Court yang Digunakan"
        value={courtCountUsed}
        onChangeText={setCourtCountUsed}
        style={styles.input}
        keyboardType="numeric"
        ref={courtCountUsedRef}
        returnKeyType="next"
        onSubmitEditing={() => maxSlotRef.current.focus()} // Fokus ke input berikutnya
      />
      <TextInput
        placeholder="Max Slot Pemain"
        value={maxSlot}
        onChangeText={setMaxSlot}
        style={styles.input}
        keyboardType="numeric"
        ref={maxSlotRef}
        returnKeyType="next"
        onSubmitEditing={() => htmMemberRef.current.focus()} // Fokus ke input berikutnya
      />
      <TextInput
        placeholder="HTM Member"
        value={htmMember}
        onChangeText={setHtmMember}
        style={styles.input}
        keyboardType="numeric"
        ref={htmMemberRef}
        returnKeyType="next"
        onSubmitEditing={() => htmNonmemberRef.current.focus()} // Fokus ke input berikutnya
      />
      <TextInput
        placeholder="HTM Nonmember"
        value={htmNonmember}
        onChangeText={setHtmNonmember}
        style={styles.input}
        keyboardType="numeric"
        ref={htmNonmemberRef}
        returnKeyType="done"
      />
      <Button
        title={loading ? 'Saving...' : 'Save Event'}
        onPress={handleSave}
        disabled={loading}
      />
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
  pickerContainer: {
    marginBottom: 12,
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

export default AddEventScreen;
