// screens/AddPlayerScreen.js
import React, { useState } from 'react';
import { View, Text, TextInput, Button, StyleSheet, Alert } from 'react-native';

const AddPlayerScreen = ({ navigation, route }) => {
  const [playerData, setPlayerData] = useState({
    id: Date.now().toString(), // ID unik berdasarkan timestamp
    name: '',
    alias: '',
    gender: '',
    contact: '',
    level: '',
    age_range: '',
    payment_status: '',
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

    // Setelah menyimpan, kirim data kembali ke PlayerListScreen
    navigation.navigate('PlayerList', { newPlayer: playerData });
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
      <Button title="Save Player" onPress={handleSave} />
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

export default AddPlayerScreen;
