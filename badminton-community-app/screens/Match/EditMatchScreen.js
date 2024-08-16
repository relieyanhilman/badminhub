// Match/EditMatchScreen.js
import React, { useState } from 'react';
import { View, Text, TextInput, Button, StyleSheet, ScrollView } from 'react-native';

const EditMatchScreen = ({ route, navigation }) => {
  const { match} = route.params; // Menerima data match dari MatchListScreen

  const [matchData, setMatchData] = useState({
    id: match.id,
    open_mabar_day_id: match.open_mabar_day_id,
    court_id: match.court_id,
    player_name_a1: match.player_name_a1,
    player_level_a1: match.player_level_a1,
    player_name_a2: match.player_name_a2,
    player_level_a2: match.player_level_a2,
    player_name_b1: match.player_name_b1,
    player_level_b1: match.player_level_b1,
    player_name_b2: match.player_name_b2,
    player_level_b2: match.player_level_b2,
    start_time: match.start_time,
    end_time: match.end_time,
    score: match.score,
    shuttlecock_used: match.shuttlecock_used || '',
    note: match.note || '',
  });

  const handleInputChange = (field, value) => {
    setMatchData({ ...matchData, [field]: value });
  };

  const handleSave = () => {
      navigation.navigate('MatchList', { updatedMatch: matchData });

  };

  return (
    <ScrollView contentContainerStyle={styles.container}>
      <Text style={styles.label}>Court ID:</Text>
      <TextInput
        style={styles.input}
        value={matchData.court_id.toString()}
        onChangeText={(value) => handleInputChange('court_id', value)}
        keyboardType="numeric"
      />

      <Text style={styles.label}>Player A1 Name:</Text>
      <TextInput
        style={styles.input}
        value={matchData.player_name_a1}
        onChangeText={(value) => handleInputChange('player_name_a1', value)}
      />

      <Text style={styles.label}>Player A1 Level:</Text>
      <TextInput
        style={styles.input}
        value={matchData.player_level_a1}
        onChangeText={(value) => handleInputChange('player_level_a1', value)}
      />

      <Text style={styles.label}>Player A2 Name:</Text>
      <TextInput
        style={styles.input}
        value={matchData.player_name_a2}
        onChangeText={(value) => handleInputChange('player_name_a2', value)}
      />

      <Text style={styles.label}>Player A2 Level:</Text>
      <TextInput
        style={styles.input}
        value={matchData.player_level_a2}
        onChangeText={(value) => handleInputChange('player_level_a2', value)}
      />

      <Text style={styles.label}>Player B1 Name:</Text>
      <TextInput
        style={styles.input}
        value={matchData.player_name_b1}
        onChangeText={(value) => handleInputChange('player_name_b1', value)}
      />

      <Text style={styles.label}>Player B1 Level:</Text>
      <TextInput
        style={styles.input}
        value={matchData.player_level_b1}
        onChangeText={(value) => handleInputChange('player_level_b1', value)}
      />

      <Text style={styles.label}>Player B2 Name:</Text>
      <TextInput
        style={styles.input}
        value={matchData.player_name_b2}
        onChangeText={(value) => handleInputChange('player_name_b2', value)}
      />

      <Text style={styles.label}>Player B2 Level:</Text>
      <TextInput
        style={styles.input}
        value={matchData.player_level_b2}
        onChangeText={(value) => handleInputChange('player_level_b2', value)}
      />

      <Text style={styles.label}>Start Time (HH:MM:SS):</Text>
      <TextInput
        style={styles.input}
        value={matchData.start_time}
        onChangeText={(value) => handleInputChange('start_time', value)}
        placeholder="e.g., 14:00:00"
      />

      <Text style={styles.label}>End Time (HH:MM:SS):</Text>
      <TextInput
        style={styles.input}
        value={matchData.end_time}
        onChangeText={(value) => handleInputChange('end_time', value)}
        placeholder="e.g., 15:00:00"
      />

      <Text style={styles.label}>Score (3 Set):</Text>
      <TextInput
        style={styles.input}
        value={matchData.score}
        onChangeText={(value) => handleInputChange('score', value)}
        placeholder="e.g., 21-18, 19-21, 21-15"
      />

      <Text style={styles.label}>Shuttlecocks Used (Optional):</Text>
      <TextInput
        style={styles.input}
        value={matchData.shuttlecock_used.toString()}
        onChangeText={(value) => handleInputChange('shuttlecock_used', value)}
        keyboardType="numeric"
        placeholder="e.g., 3"
      />

      <Text style={styles.label}>Note (Optional):</Text>
      <TextInput
        style={styles.input}
        value={matchData.note}
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

export default EditMatchScreen;
