// Player/AddPlayerScreen.js
import React, { useState, useRef } from 'react';
import { View, Text, TextInput, Button, StyleSheet, ScrollView, Alert, TouchableOpacity, KeyboardAvoidingView, Platform, ActivityIndicator} from 'react-native';
import { Picker } from '@react-native-picker/picker';
import * as SecureStore from 'expo-secure-store';

const AddPlayerScreen = ({ navigation, route }) => {
  const { dayId } = route.params;

  const [name, setName] = useState('');
  const [alias, setAlias] = useState('');
  const [gender, setGender] = useState('M');
  const [contact, setContact] = useState('');
  const [level, setLevel] = useState('A');
  const [ageRange, setAgeRange] = useState('15-20');
  const [loading, setLoading] = useState(false);

  const aliasRef = useRef(null);
  const genderRef = useRef(null);
  const contactRef = useRef(null);
  const levelRef = useRef(null);
  const ageRangeRef = useRef(null);

  const handleCreatePlayer = async () => {
    if (!name || !alias || !contact || !gender || !level || !ageRange) {
      Alert.alert('Validation Error', 'All fields are required');
      return;
    }

    setLoading(true);

    try {
      const token = await SecureStore.getItemAsync('userToken');
      if (!token) {
        throw new Error('User token not found');
      }

      // Create Player API Request
      const response = await fetch('https://api.pbbedahulu.my.id/player/create', {
        method: 'POST',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          name,
          alias,
          gender,
          contact,
          level,
          age_range: ageRange,
        }),
      });

      const playerData = await response.json();

      if (!response.ok) {
        throw new Error(playerData.message || 'Failed to create player');
      }

      // Apply Player to Event Day
      const applyResponse = await fetch('https://api.pbbedahulu.my.id/mabar/day/detail/create', {
        method: 'POST',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          open_mabar_day_id: dayId,
          player_id: playerData.data.id,
          payment_status: 'unpaid',
        }),
      });

      if (!applyResponse.ok) {
        throw new Error('Failed to apply player to event day');
      }

      Alert.alert('Success', 'Player created and applied to event day successfully');
      navigation.navigate('PlayerList', { refresh: true }); // Kembali ke PlayerListScreen dan kirimkan param `refresh`
    } catch (error) {
      console.error(error);
      Alert.alert('Error', error.message || 'An error occurred');
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
          style={styles.input}
          placeholder="Name"
          value={name}
          onChangeText={setName}
          returnKeyType="next"
          onSubmitEditing={() => aliasRef.current.focus()} // Fokus ke input berikutnya
      />

      <TextInput
          style={styles.input}
          placeholder="Alias"
          value={alias}
          onChangeText={setAlias}
          returnKeyType="next"
          ref={aliasRef}
          onSubmitEditing={() => genderRef.current.focus()}
      />

      <Text style={styles.label}>Gender</Text>
      <Picker selectedValue={gender} onValueChange={setGender} style={styles.input}>
        <Picker.Item label="Select Gender" value="" />
        <Picker.Item label="Male" value="M" />
        <Picker.Item label="Female" value="F" />
      </Picker>

      <TextInput
        style={styles.input}
        value={contact}
        onChangeText={(text) => {
          // Filter input to allow only numeric values
          if (/^\d*$/.test(text)) {
            setContact(text);
          }
        }}
        placeholder="Contact Number"
        keyboardType="numeric"
        returnKeyType="next"
        ref={contactRef}
        onSubmitEditing={() => levelRef.current.focus()}
      />

      <Text style={styles.label}>Level</Text>
      <Picker selectedValue={level} onValueChange={setLevel} style={styles.input}>
        <Picker.Item label="Select Level" value="" />
        <Picker.Item label="Level A" value="A" />
        <Picker.Item label="Level B" value="B" />
        <Picker.Item label="Level C" value="C" />
      </Picker>

      <Text style={styles.label}>Age Range</Text>
      <Picker selectedValue={ageRange} onValueChange={setAgeRange} style={styles.input}>
        <Picker.Item label="Select Age Range" value="" />
        <Picker.Item label="15-20" value="15-20" />
        <Picker.Item label="21-30" value="21-30" />
        <Picker.Item label="31-40" value="31-40" />
        <Picker.Item label="41-50" value="41-50" />
        <Picker.Item label="51-60" value="51-60" />
        <Picker.Item label="61-70" value="61-70" />
        <Picker.Item label="71-80" value="71-80" />
      </Picker>

        <View style={styles.buttonContainer}>
          <TouchableOpacity
            style={[styles.createButton, loading && styles.createButtonDisabled]}
            onPress={handleCreatePlayer}
            disabled={loading}
          >
            {loading ? (
              <ActivityIndicator size="small" color="#fff" />
            ) : (
              <Text style={styles.createButtonText}>CREATE AND APPLY PLAYER</Text>
            )}
          </TouchableOpacity>
        </View>

    </ScrollView>
     </KeyboardAvoidingView>
  );
};

const styles = StyleSheet.create({
  container: {
    padding: 16,
    flexGrow: 1,
    justifyContent: 'space-between',
  },
  label: {
    fontSize: 16,
    fontWeight: 'bold',
    marginVertical: 8,
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
  createButton: {
    backgroundColor: '#007BFF',
    paddingVertical: 15,
    paddingHorizontal: 20,
    borderRadius: 5,
    alignItems: 'center',
  },
  createButtonText: {
    color: '#fff',
    fontWeight: 'bold',
    fontSize: 16,
  },
  buttonContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    marginTop: 5,
  },
  createButtonDisabled: {
    backgroundColor: '#7a7a7a',
  },


});

export default AddPlayerScreen;