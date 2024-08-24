// screens/EventDay/EventPlayerScreen.js
import React, { useState, useEffect, useContext } from 'react';
import { View, Text, FlatList, ActivityIndicator, StyleSheet, Alert } from 'react-native';
import * as SecureStore from 'expo-secure-store';
import { EventContext } from '../../EventContext';

const EventPlayerScreen = ({ route }) => {
  const { eventId } = useContext(EventContext);
  const [players, setPlayers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchEventPlayers();
  }, []);

  const fetchEventPlayers = async () => {
    try {
      const token = await SecureStore.getItemAsync('userToken');
      if (!token) {
        throw new Error('User token not found');
      }

      const response = await fetch(`https://api.pbbedahulu.my.id/mabar/player/${eventId}`, {
        method: 'GET',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      });

      const result = await response.json();

      if (response.ok) {
        const filteredPlayers = result.data.filter(player => player.status === "member");
        setPlayers(filteredPlayers);
      } else {
        setError(result.message || 'Failed to fetch players');
      }
    } catch (err) {
      setError('An error occurred while fetching players');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const renderItem = ({ item }) => (
    <View style={styles.itemContainer}>
      <Text style={styles.nameText}>{item.player.name} ({item.player.alias})</Text>
      <Text style={styles.text}>Level: {item.player.level}</Text>
      <Text style={styles.text}>Age Range: {item.player.age_range}</Text>
      <Text style={styles.text}>Contact: {item.player.contact}</Text>
      <Text style={styles.text}>Status: {item.status}</Text>
      {item.note && <Text style={styles.text}>Note: {item.note}</Text>}
    </View>
  );

  if (loading) {
    return (
      <View style={styles.loadingContainer}>
        <ActivityIndicator size="large" color="#0000ff" />
      </View>
    );
  }

  if (error) {
    return (
      <View style={styles.errorContainer}>
        <Text style={styles.errorText}>{error}</Text>
      </View>
    );
  }

  return (
    <FlatList
      data={players}
      renderItem={renderItem}
      keyExtractor={(item) => item.id.toString()}
      contentContainerStyle={styles.listContainer}
    />
  );
};

const styles = StyleSheet.create({
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  errorContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 16,
  },
  errorText: {
    fontSize: 18,
    color: 'red',
    marginBottom: 16,
    textAlign: 'center',
  },
  listContainer: {
    padding: 16,
  },
  itemContainer: {
    backgroundColor: '#f9f9f9',
    padding: 16,
    marginVertical: 8,
    borderRadius: 8,
    borderColor: '#ccc',
    borderWidth: 1,
  },
  nameText: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 8,
  },
  text: {
    fontSize: 14,
    marginBottom: 4,
    color: '#555',
  },
});

export default EventPlayerScreen;