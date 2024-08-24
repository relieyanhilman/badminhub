// Match/EditMatchScreen.js
import React, { useState, useEffect, useContext } from 'react';
import { View, Text, TextInput, Button, StyleSheet, Alert, ActivityIndicator, ScrollView } from 'react-native';
import * as SecureStore from 'expo-secure-store';
import { EventContext } from '../../EventContext';
import { Picker } from '@react-native-picker/picker';
import DateTimePicker from '@react-native-community/datetimepicker';

const EditMatchScreen = ({ route, navigation }) => {
  const { eventHallId } = useContext(EventContext);
  const { dayId, match } = route.params; // Menerima data match yang akan diedit
  const [attendees, setAttendees] = useState([]);
  const [courts, setCourts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [courtLoading, setCourtLoading] = useState(true);
  const [error, setError] = useState(null);

  const [courtId, setCourtId] = useState(match.court_id.toString());
  const [playerIdA1, setPlayerIdA1] = useState(match.player_id_a1.toString());
  const [playerIdA2, setPlayerIdA2] = useState(match.player_id_a2.toString());
  const [playerIdB1, setPlayerIdB1] = useState(match.player_id_b1.toString());
  const [playerIdB2, setPlayerIdB2] = useState(match.player_id_b2.toString());
  const [startTime, setStartTime] = useState(new Date(`2024-01-01T${match.start_time}`));
  const [endTime, setEndTime] = useState(match.end_time ?  new Date(`2024-01-01T${match.end_time}`) : new Date());
  const [score, setScore] = useState(match.score || '');
  const [shuttlecockUsed, setShuttlecockUsed] = useState(match.shuttlecock_used?.toString() || 0);
  const [note, setNote] = useState(match.note || '');
  const [showStartTimePicker, setShowStartTimePicker] = useState(false);
  const [showEndTimePicker, setShowEndTimePicker] = useState(false);

  useEffect(() => {
    fetchAttendees();
    fetchCourts();
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

    if (endTime && endTime < startTime) {
      Alert.alert('Error', 'End time cannot be earlier than start time.');
      return;
    }

    try {
      const token = await SecureStore.getItemAsync('userToken');
      console.log("MATCH START TIME", startTime)
      console.log("MATCH END TIME", endTime)
      const response = await fetch('https://api.pbbedahulu.my.id/mabar/match/update', {
        method: 'POST',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          id: match.id,
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
          end_time: formattedEndTime,
          score: score,
          shuttlecock_used: parseInt(shuttlecockUsed) || 0,
          note: note ,
        }),
      });

      const result = await response.json();
      if (result.success) {
        Alert.alert('Success', 'Match updated successfully.');
        navigation.navigate("MatchList", {refresh: true});
      } else {
        Alert.alert('Error', result.message || 'Failed to update match.');
      }
    } catch (error) {
      console.log(error)
      Alert.alert('Error', 'An error occurred while updating the match.');
    }
  };

  const onChangeStartTime = (event, selectedTime) => {
    setShowStartTimePicker(false);
    if (selectedTime) {
      setStartTime(selectedTime);
    }
  };

  const onChangeEndTime = (event, selectedTime) => {
    setShowEndTimePicker(false);
    if (selectedTime) {
      setEndTime(selectedTime);
    }
  };

  const formattedStartTime = `${startTime.getHours().toString().padStart(2, '0')}:${startTime.getMinutes().toString().padStart(2, '0')}:${startTime.getSeconds().toString().padStart(2, '0')}`;
  const formattedEndTime = endTime instanceof Date
      ? `${endTime.getHours().toString().padStart(2, '0')}:${endTime.getMinutes().toString().padStart(2, '0')}:${endTime.getSeconds().toString().padStart(2, '0')}`
      : new Date();

  if (loading || courtLoading) {
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
          {courts.map((court) => (
            <Picker.Item key={court.id} label={court.name} value={court.id.toString()} />
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
              label={`${attendee.player.name} (${attendee.player.alias}) - Level: ${attendee.player_level}`}
              value={attendee.player.id.toString()}
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
              label={`${attendee.player.name} (${attendee.player.alias}) - Level: ${attendee.player_level}`}
              value={attendee.player.id.toString()}
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
              label={`${attendee.player.name} (${attendee.player.alias}) - Level: ${attendee.player_level}`}
              value={attendee.player.id.toString()}
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
              label={`${attendee.player.name} (${attendee.player.alias}) - Level: ${attendee.player_level}`}
              value={attendee.player.id.toString()}
            />
          ))}
        </Picker>

        <Text style={styles.label}>Player B2 Level</Text>
        <Text style={styles.levelText}>
          {attendees.find(att => att.player.id === parseInt(playerIdB2))?.player.level || 'N/A'}
        </Text>

        <Text style={styles.label}>Start Time</Text>
        <View>
          <Button title="Select Start Time" onPress={() => setShowStartTimePicker(true)} />
          <Text style={styles.timeText}>{formattedStartTime}</Text>
        </View>
        {showStartTimePicker && (
          <DateTimePicker
            value={startTime}
            mode="time"
            display="default"
            onChange={onChangeStartTime}
          />
        )}

        <Text style={styles.label}>End Time</Text>
        <View>
          <Button title="Select End Time" onPress={() => setShowEndTimePicker(true)} />
          <Text style={styles.timeText}>{formattedEndTime}</Text>
        </View>
        {showEndTimePicker && (
          <DateTimePicker
            value={endTime}
            mode="time"
            display="default"
            onChange={onChangeEndTime}
          />
        )}

        <Text style={styles.label}>Score</Text>
        <TextInput
          style={styles.input}
          value={score}
          onChangeText={setScore}
          placeholder="Enter Score (optional)"
        />

        <Text style={styles.label}>Shuttlecocks Used</Text>
        <TextInput
          style={styles.input}
          value={shuttlecockUsed}
          onChangeText={setShuttlecockUsed}
          keyboardType="numeric"
          placeholder="Enter Shuttlecocks Used (optional)"
        />

        <Text style={styles.label}>Note</Text>
        <TextInput
          style={styles.input}
          value={note}
          onChangeText={setNote}
          placeholder="Enter Note (optional)"
        />

        <Button title="Update Match" onPress={handleSaveMatch} />
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

export default EditMatchScreen;