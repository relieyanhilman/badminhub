// Player/EditPlayerScreen.js
import React, { useState, useEffect } from 'react';
import { View, Text, TextInput, Button, StyleSheet, Alert } from 'react-native';

const EditPlayerScreen = ({ route, navigation }) => {
  const { player } = route.params;

  const [playerData, setPlayerData] = useState({
    id: player.id,
    name: player.name,
    alias: player.alias,
    gender: player.gender,
    contact: player.contact,
    level: player.level,
    age_range: player.age_range,
    payment_status: player.payment_status,
  });

  const handleSave = () => {
    if (
      playerData.name.trim() === '' ||
      playerData.alias.trim() === '' ||
      playerData.gender.trim() === '' ||
      playerData.contact.trim() === '' ||
      playerData.level.trim() === '' ||
      playerData.age_range.trim() === '' ||
      playerData.payment_status.trim() === ''
    ) {
      Alert.alert('Invalid input', 'Please fill in all fields');
      return;
    }

    // Mengirim data yang sudah diedit kembali ke PlayerListScreen
    navigation.navigate('PlayerList', { updatedPlayer: playerData });
  };

  return (
    <View style={styles.container}>
      <TextInput
        placeholder="Nama Pemain"
        value={playerData.name}
        onChangeText={(text) => setPlayerData({ ...playerData, name: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="Alias Pemain"
        value={playerData.alias}
        onChangeText={(text) => setPlayerData({ ...playerData, alias: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="Gender (M/F)"
        value={playerData.gender}
        onChangeText={(text) => setPlayerData({ ...playerData, gender: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="Contact Number"
        value={playerData.contact}
        onChangeText={(text) => setPlayerData({ ...playerData, contact: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="Level (A/B/C)"
        value={playerData.level}
        onChangeText={(text) => setPlayerData({ ...playerData, level: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="Age Range (e.g., '21-30')"
        value={playerData.age_range}
        onChangeText={(text) => setPlayerData({ ...playerData, age_range: text })}
        style={styles.input}
      />
      <TextInput
        placeholder="Payment Status"
        value={playerData.payment_status}
        onChangeText={(text) => setPlayerData({ ...playerData, payment_status: text })}
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

export default EditPlayerScreen;
