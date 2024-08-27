// file path: src/screens/EventDay/EditEventPlayerScreen.js

import React, { useState, useEffect } from 'react';
import { View, Text, TextInput, Button, StyleSheet, Alert, ScrollView, ActivityIndicator } from 'react-native';
import * as SecureStore from 'expo-secure-store';
import { Picker } from '@react-native-picker/picker';

const EditEventPlayerScreen = ({ route, navigation }) => {
  const { player } = route.params;

  const [playerData, setPlayerData] = useState({
    id: player.id,
    name: player.name,
    alias: player.alias,
    gender: player.gender,
    contact: player.contact,
    level: player.level,
    age_range: player.age_range,
  });

  const [loading, setLoading] = useState(false);

  const handleInputChange = (field, value) => {
    setPlayerData({ ...playerData, [field]: value });
  };

  const handleSave = async () => {
    if (
      !playerData.name.trim() ||
      !playerData.alias.trim() ||
      !playerData.gender.trim() ||
      !playerData.contact.trim() ||
      !playerData.level.trim() ||
      !playerData.age_range.trim()
    ) {
      Alert.alert('Invalid input', 'Please fill in all fields');
      return;
    }

    setLoading(true);

    try {
      const token = await SecureStore.getItemAsync('userToken');
      if (!token) {
        throw new Error('User token not found');
      }

      const response = await fetch('https://api.pbbedahulu.my.id/player/update', {
        method: 'POST',
        headers: {
          'Authorization': `${token}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(playerData),
      });

      const data = await response.json();

      if (response.ok) {
        Alert.alert('Success', 'Player updated successfully');
        navigation.navigate('EventPlayers', { refresh: true });
      } else {
        let errorMessage = data.message || 'Failed to update player';
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
    <ScrollView contentContainerStyle={styles.container}>
      <Text style={styles.label}>Name</Text>
      <TextInput
        placeholder="Nama"
        value={playerData.name}
        onChangeText={(text) => handleInputChange('name', text)}
        style={styles.input}
      />

      <Text style={styles.label}>Alias</Text>
      <TextInput
        placeholder="Alias"
        value={playerData.alias}
        onChangeText={(text) => handleInputChange('alias', text)}
        style={styles.input}
      />

      <Text style={styles.label}>Gender</Text>
      <Picker
        selectedValue={playerData.gender}
        onValueChange={(itemValue) => handleInputChange('gender', itemValue)}
        style={styles.picker}
      >
        <Picker.Item label="Male" value="M" />
        <Picker.Item label="Female" value="F" />
      </Picker>

      <Text style={styles.label}>Contact</Text>
      <TextInput
        placeholder="Contact"
        value={playerData.contact}
        onChangeText={(text) => handleInputChange('contact', text)}
        style={styles.input}
      />

      <Text style={styles.label}>Level</Text>
      <Picker
        selectedValue={playerData.level}
        onValueChange={(itemValue) => handleInputChange('level', itemValue)}
        style={styles.picker}
      >
        <Picker.Item label="A" value="A" />
        <Picker.Item label="B" value="B" />
        <Picker.Item label="C" value="C" />
      </Picker>

      <Text style={styles.label}>Age Range</Text>
      <Picker
        selectedValue={playerData.age_range}
        onValueChange={(itemValue) => handleInputChange('age_range', itemValue)}
        style={styles.picker}
      >
        <Picker.Item label="15-20" value="15-20" />
        <Picker.Item label="21-30" value="21-30" />
        <Picker.Item label="31-40" value="31-40" />
        <Picker.Item label="41-50" value="41-50" />
        <Picker.Item label="51-60" value="51-60" />
        <Picker.Item label="61-70" value="61-70" />
        <Picker.Item label="71-80" value="71-80" />
      </Picker>

      <Button title={loading ? 'Saving...' : 'Save Changes'} onPress={handleSave} disabled={loading} />
    </ScrollView>
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
  picker: {
    height: 50,
    marginBottom: 12,
    backgroundColor: '#fff',
  },
});

export default EditEventPlayerScreen;
