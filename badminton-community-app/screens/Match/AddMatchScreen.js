// screens/AddMatchScreen.js
import React, { useState } from 'react';
import { View, Text, TextInput, Button, StyleSheet, ScrollView } from 'react-native';

const AddMatchScreen = ({ navigation, route }) => {
  const { eventId, matches_length } = route.params; // Menerima eventId dari MatchStackNavigator
  const [newMatch, setNewMatch] = useState({
    id: matches_length + 1, // ID sementara untuk match baru
    open_mabar_day_id: eventId,
    court_id: '',
    player_name_a1: '',
    player_level_a1: '',
    player_name_a2: '',
    player_level_a2: '',
    player_name_b1: '',
    player_level_b1: '',
    player_name_b2: '',
    player_level_b2: '',
    start_time: '',
    note: '',
  });

  const handleInputChange = (field, value) => {
    setNewMatch({ ...newMatch, [field]: value });
  };

  const handleSave = () => {
    // Kembali ke MatchListScreen dengan data match baru
    navigation.navigate('MatchList', { newMatch });
  };

  return (
    <ScrollView contentContainerStyle={styles.container}>
      <Text style={styles.label}>Court ID:</Text>
      <TextInput
        style={styles.input}
        value={newMatch.court_id}
        onChangeText={(value) => handleInputChange('court_id', value)}
        keyboardType="numeric"
      />

      <Text style={styles.label}>Player A1 Name:</Text>
      <TextInput
        style={styles.input}
        value={newMatch.player_name_a1}
        onChangeText={(value) => handleInputChange('player_name_a1', value)}
      />

      <Text style={styles.label}>Player A1 Level:</Text>
      <TextInput
        style={styles.input}
        value={newMatch.player_level_a1}
        onChangeText={(value) => handleInputChange('player_level_a1', value)}
      />

      <Text style={styles.label}>Player A2 Name:</Text>
      <TextInput
        style={styles.input}
        value={newMatch.player_name_a2}
        onChangeText={(value) => handleInputChange('player_name_a2', value)}
      />

      <Text style={styles.label}>Player A2 Level:</Text>
      <TextInput
        style={styles.input}
        value={newMatch.player_level_a2}
        onChangeText={(value) => handleInputChange('player_level_a2', value)}
      />

      <Text style={styles.label}>Player B1 Name:</Text>
      <TextInput
        style={styles.input}
        value={newMatch.player_name_b1}
        onChangeText={(value) => handleInputChange('player_name_b1', value)}
      />

      <Text style={styles.label}>Player B1 Level:</Text>
      <TextInput
        style={styles.input}
        value={newMatch.player_level_b1}
        onChangeText={(value) => handleInputChange('player_level_b1', value)}
      />

      <Text style={styles.label}>Player B2 Name:</Text>
      <TextInput
        style={styles.input}
        value={newMatch.player_name_b2}
        onChangeText={(value) => handleInputChange('player_name_b2', value)}
      />

      <Text style={styles.label}>Player B2 Level:</Text>
      <TextInput
        style={styles.input}
        value={newMatch.player_level_b2}
        onChangeText={(value) => handleInputChange('player_level_b2', value)}
      />

      <Text style={styles.label}>Start Time (HH:MM:SS):</Text>
      <TextInput
        style={styles.input}
        value={newMatch.start_time}
        onChangeText={(value) => handleInputChange('start_time', value)}
        placeholder="e.g., 14:00:00"
      />

      <Text style={styles.label}>Note (Optional):</Text>
      <TextInput
        style={styles.input}
        value={newMatch.note}
        onChangeText={(value) => handleInputChange('note', value)}
        placeholder="Any additional notes"
      />

      <Button title="Save Match" onPress={handleSave} />
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    padding: 16,
  },
  label: {
    fontSize: 16,
    fontWeight: 'bold',
    marginVertical: 8,
  },
  input: {
    height: 40,
    borderColor: 'gray',
    borderWidth: 1,
    marginBottom: 12,
    paddingHorizontal: 8,
    borderRadius: 5,
  },
});

export default AddMatchScreen;
