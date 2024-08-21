// Match/AddMatchScreen.js
import React, { useState, useEffect, useContext } from 'react';
import { View, Text, TextInput, Button, StyleSheet, Alert, ActivityIndicator, ScrollView} from 'react-native';
import * as SecureStore from 'expo-secure-store';
import { EventContext } from '../../EventContext';
import { Picker } from '@react-native-picker/picker';
import DateTimePicker from '@react-native-community/datetimepicker';

const AddMatchScreen = ({ navigation, route }) => {
  const {eventHallId} = useContext(EventContext)
  const { dayId } = route.params;
  const [attendees, setAttendees] = useState([]);
  const [courts, setCourts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [courtLoading, setCourtLoading] = useState(true);
  const [error, setError] = useState(null);

  const [courtId, setCourtId] = useState('');
  const [playerIdA1, setPlayerIdA1] = useState('');
  const [playerLevelA1, setPlayerLevelA1] = useState('A');
  const [playerIdA2, setPlayerIdA2] = useState('');
  const [playerLevelA2, setPlayerLevelA2] = useState('A');
  const [playerIdB1, setPlayerIdB1] = useState('');
  const [playerLevelB1, setPlayerLevelB1] = useState('A');
  const [playerIdB2, setPlayerIdB2] = useState('');
  const [playerLevelB2, setPlayerLevelB2] = useState('A');
  const [startTime, setStartTime] = useState(new Date());
  const [showTimePicker, setShowTimePicker] = useState(false);
  const [note, setNote] = useState('');

  useEffect(() => {
    fetchAttendees();
    fetchCourts()
  }, []);

  const fetchAttendees = async () => {
    try {
      const token = await SecureStore.getItemAsync('userToken');
      const response = await fetch(`https://api.pbbedahulu.my.id/mabar/day/${dayId}`, {
        method: 'GET',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      });

      const result = await response.json();

      if (result.success) {
        setAttendees(result.data.attendees);
      } else {
        setError(result.message || 'Failed to retrieve attendees data');
      }
    } catch (error) {
      setError('An error occurred while fetching attendees data');
    } finally {
      setLoading(false);
    }
  };

  const fetchCourts = async () => {
    try {
      const token = await SecureStore.getItemAsync('userToken');
      const response = await fetch('https://api.pbbedahulu.my.id/court', {
        method: 'POST',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          page: 1,
          perPage: 100,
          hall_id: eventHallId,
        }),
      });

      const result = await response.json();

      if (result.success) {
        setCourts(result.data);
      } else {
        setError(result.message || 'Failed to retrieve courts data');
      }
    } catch (error) {
      setError('An error occurred while fetching courts data');
    } finally {
      setCourtLoading(false);
    }
  };

  const handleSaveMatch = async () => {
    if (!courtId || !playerIdA1 || !playerIdA2 || !playerIdB1 || !playerIdB2 || !startTime) {
      Alert.alert('Error', 'Please fill in all required fields.');
      return;
    }
    try {

      const token = await SecureStore.getItemAsync('userToken');
      const response = await fetch('https://api.pbbedahulu.my.id/mabar/match/create', {
        method: 'POST',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          open_mabar_day_id: dayId,
          court_id: parseInt(courtId),
          player_id_a1: parseInt(playerIdA1),
          player_level_a1: attendees.find(att => att.player.id === parseInt(playerIdA1)).player.level,
          player_id_a2: parseInt(playerIdA2),
          player_level_a2: attendees.find(att => att.player.id === parseInt(playerIdA2)).player.level,
          player_id_b1: parseInt(playerIdB1),
          player_level_b1: attendees.find(att => att.player.id === parseInt(playerIdB1)).player.level,
          player_id_b2: parseInt(playerIdB2),
          player_level_b2: attendees.find(att => att.player.id === parseInt(playerIdB2)).player.level,
          start_time: formattedStartTime,
          note: note,
        }),
      });

      const result = await response.json();

      if (result.success) {
        Alert.alert('Success', 'Match added successfully.');
        navigation.navigate("MatchList", {refresh: true});
      } else {
        Alert.alert('Error', result.message || 'Failed to add match.');
      }
    } catch (error) {
      Alert.alert('Error', 'An error occurred while adding the match.');
    }
  };

  const onChangeTime = (event, selectedTime) => {
    setShowTimePicker(false);
    if (selectedTime) {
      setStartTime(selectedTime); // Update waktu jika pengguna memilih waktu
    }
  };

  const formattedStartTime = `${startTime.getHours().toString().padStart(2, '0')}:${startTime.getMinutes().toString().padStart(2, '0')}:${startTime.getSeconds().toString().padStart(2, '0')}`;

  if (loading || courtLoading ) {
    return (
      <View style={styles.loadingContainer}>
        <ActivityIndicator size="large" color="#0000ff" />
        <Text>Loading data...</Text>
      </View>
    );
  }

  if (error) {
    return (
      <View style={styles.loadingContainer}>
        <Text style={styles.errorText}>{error}</Text>
      </View>
    );
  }

  return (
    <ScrollView style={styles.scrollContainer}>
      <View style={styles.container}>

        <Text style={styles.label}>Court</Text>
        <Picker
          selectedValue={courtId}
          style={styles.input}
          onValueChange={(itemValue) => setCourtId(itemValue)}
        >
       <Picker.Item label="Select Court" value="" />
          {courts.map((court) => (
            <Picker.Item
              key={court.id}
              label={court.name}
              value={court.id}
            />
          ))}
        </Picker>

      <Text style={styles.label}>Player A1</Text>
      <Picker
        selectedValue={playerIdA1}
        style={styles.input}
        onValueChange={(itemValue) => setPlayerIdA1(itemValue)}
      >
        <Picker.Item label="Select Player A1" value="" />
        {attendees.map((attendee) => (
          <Picker.Item
            key={attendee.player.id}
            label={`${attendee.player.name} (${attendee.player.alias})`}
            value={attendee.player.id}
          />
        ))}
      </Picker>

        <Text style={styles.label}>Player A1 Level</Text>
        <Text style={styles.levelText}>
          {attendees.find(att => att.player.id === parseInt(playerIdA1))?.player.level || 'N/A'}
        </Text>

      <Text style={styles.label}>Player A2</Text>
      <Picker
        selectedValue={playerIdA2}
        style={styles.input}
        onValueChange={(itemValue) => setPlayerIdA2(itemValue)}
      >
       <Picker.Item label="Select Player A2" value="" />
        {attendees.map((attendee) => (
          <Picker.Item
            key={attendee.player.id}
            label={`${attendee.player.name} (${attendee.player.alias})`}
            value={attendee.player.id}
          />
        ))}
      </Picker>

        <Text style={styles.label}>Player A2 Level</Text>
        <Text style={styles.levelText}>
          {attendees.find(att => att.player.id === parseInt(playerIdA2))?.player.level || 'N/A'}
        </Text>

      <Text style={styles.label}>Player B1</Text>
      <Picker
        selectedValue={playerIdB1}
        style={styles.input}
        onValueChange={(itemValue) => setPlayerIdB1(itemValue)}
      >
       <Picker.Item label="Select Player B1" value="" />
        {attendees.map((attendee) => (
          <Picker.Item
            key={attendee.player.id}
            label={`${attendee.player.name} (${attendee.player.alias})`}
            value={attendee.player.id}
          />
        ))}
      </Picker>

        <Text style={styles.label}>Player B1 Level</Text>
        <Text style={styles.levelText}>
          {attendees.find(att => att.player.id === parseInt(playerIdB1))?.player.level || 'N/A'}
        </Text>

      <Text style={styles.label}>Player B2</Text>
      <Picker
        selectedValue={playerIdB2}
        style={styles.input}
        onValueChange={(itemValue) => setPlayerIdB2(itemValue)}
      >

       <Picker.Item label="Select Player B2" value="" />
        {attendees.map((attendee) => (
          <Picker.Item
            key={attendee.player.id}
            label={`${attendee.player.name} (${attendee.player.alias})`}
            value={attendee.player.id}
          />
        ))}
      </Picker>

        <Text style={styles.label}>Player B2 Level</Text>
        <Text style={styles.levelText}>
          {attendees.find(att => att.player.id === parseInt(playerIdB2))?.player.level || 'N/A'}
        </Text>

        <Text style={styles.label}>Start Time</Text>
        <View>
          <Button title="Select Start Time" onPress={() => setShowTimePicker(true)} />
          <Text style={styles.timeText}>{formattedStartTime}</Text>
        </View>
        {showTimePicker && (
          <DateTimePicker
            value={startTime}
            mode="time"
            display="default"
            onChange={onChangeTime}
          />
        )}

      <Text style={styles.label}>Note</Text>
      <TextInput
        style={styles.input}
        value={note}
        onChangeText={setNote}
        placeholder="Enter Note (optional)"
      />

      <Button title="Save Match" onPress={handleSaveMatch} />
    </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  scrollContainer: {
    flex: 1,
  },
  container: {
    flex: 1,
    padding: 16,
  },
  label: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 4,
  },
  input: {
    borderWidth: 1,
    borderColor: '#ccc',
    padding: 8,
    marginBottom: 16,
    borderRadius: 4,
  },
  levelText: {
    padding: 8,
    marginBottom: 16,
    backgroundColor: '#f0f0f0',
    borderRadius: 4,
    fontSize: 16,
  },
  timeText: {
    fontSize: 16,
    marginVertical: 8,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  errorText: {
    color: 'red',
    fontSize: 16,
  },
});

export default AddMatchScreen;
