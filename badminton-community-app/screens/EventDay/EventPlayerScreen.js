// screens/EventDay/EventPlayerScreen.js
import React, { useState, useEffect, useContext } from 'react';
import { View, Text, FlatList, ActivityIndicator, StyleSheet, Alert, TouchableOpacity } from 'react-native';
import * as SecureStore from 'expo-secure-store';
import { EventContext } from '../../EventContext';

const EventPlayerScreen = ({ route }) => {
  const { eventId } = useContext(EventContext);
  const [players, setPlayers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false); // State for pull to refresh
  const [error, setError] = useState(null);

  const [isProcessing, setIsProcessing] = useState(null); // State to track which button is being processed

  useEffect(() => {
    fetchEventPlayers();
  }, []);

  const fetchEventPlayers = async () => {
    setLoading(true);  // Set loading to true when fetching data
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
        setPlayers(result.data);
      } else {
        setError(result.message || 'Failed to fetch players');
      }
    } catch (err) {
      setError('An error occurred while fetching players');
      console.error(err);
    } finally {
      setLoading(false);
      setRefreshing(false); // Reset refreshing state when data is fetched
    }
  };

  const handleEdit = (player) => {
    // Handle the edit action, navigate to the edit screen
//    navigation.navigate('EditPlayerScreen', { player });
    setIsProcessing(player.id);
    console.log("handleEdit")
    setIsProcessing(null);
  };

  const handleSubscribe = async (player) => {
    // Handle the subscribe action
    if (isProcessing) return;
    setIsProcessing(player.id);

    try {
      const token = await SecureStore.getItemAsync('userToken');
      const response = await fetch('https://api.pbbedahulu.my.id/mabar/player/create', {
        method: 'POST',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          player_id: player.player.id,
          open_mabar_id: eventId,
          payment_method: "Cash"
        }),
      });

      const result = await response.json();

      if (result.success) {
        Alert.alert('Success', 'Player subscribed successfully.', [{ text: 'OK', onPress: () => setIsProcessing(null) }]);
        fetchEventPlayers(); // Refresh the player list
      } else {
        Alert.alert('Error', result.message || 'Failed to subscribe player.', [{ text: 'OK', onPress: () => setIsProcessing(null) }]);
      }
    } catch (err) {
      Alert.alert('Error', 'An error occurred while subscribing player.', [{ text: 'OK', onPress: () => setIsProcessing(null) }]);
    }
  };

  const handleUnsubscribe = async (player) => {
    if (isProcessing) return;
    setIsProcessing(player.id);

    // Handle the unsubscribe action
    try {
      const token = await SecureStore.getItemAsync('userToken');
      const response = await fetch('https://api.pbbedahulu.my.id/mabar/player/delete', {
        method: 'POST',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          player_id: player.player.id,
          open_mabar_id: eventId,
        }),
      });

      const result = await response.json();

      if (result.success) {
        Alert.alert('Success', 'Player unsubscribed successfully.', [{ text: 'OK', onPress: () => setIsProcessing(null) }]);
        fetchEventPlayers(); // Refresh the player list
      } else {
        Alert.alert('Error', result.message || 'Failed to unsubscribe player.', [{ text: 'OK', onPress: () => setIsProcessing(null) }]);
      }
    } catch (err) {
      Alert.alert('Error', 'An error occurred while unsubscribing player.', [{ text: 'OK', onPress: () => setIsProcessing(null) }]);
    }
  };

  const handleResubscribe = async (player) => {
    if (isProcessing) return;
    setIsProcessing(player.id);

    // Handle the subscribe action
    try {
      const token = await SecureStore.getItemAsync('userToken');
      const response = await fetch('https://api.pbbedahulu.my.id/mabar/player/recreate', {
        method: 'POST',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          player_id: player.player.id,
          open_mabar_id: eventId,
          payment_method: "Cash"
        }),
      });

      const result = await response.json();

      if (result.success) {
        Alert.alert('Success', 'Player resubscribed successfully.', [{ text: 'OK', onPress: () => setIsProcessing(null) }]);
        fetchEventPlayers(); // Refresh the player list
      } else {
        Alert.alert('Error', result.message || 'Failed to resubscribe player.', [{ text: 'OK', onPress: () => setIsProcessing(null) }]);
      }
    } catch (err) {
      Alert.alert('Error', 'An error occurred while resubscribing player.', [{ text: 'OK', onPress: () => setIsProcessing(null) }]);
    }
  };

  const renderItem = ({ item }) => (
    <View style={styles.itemContainer}>
      <Text style={styles.nameText}>{item.player.name} ({item.player.alias})</Text>
      <Text style={styles.text}>Level: {item.player.level}</Text>
      <Text style={styles.text}>Gender: {item.player.gender}</Text>
      <Text style={styles.text}>Age Range: {item.player.age_range}</Text>
      <Text style={styles.text}>Contact: {item.player.contact}</Text>
      <Text style={styles.text}>Status: {item.status}</Text>
      {item.note && <Text style={styles.text}>Note: {item.note}</Text>}

      <View style={styles.buttonRow}>
      <TouchableOpacity style={[styles.button, isProcessing === item.id && styles.buttonDisabled, styles.buttonEdit]}
      onPress={() => handleEdit(item)}
      disabled={isProcessing === item.id}
      >
        <Text style={styles.buttonText}>Edit</Text>
      </TouchableOpacity>

      {item.status === 'non member' ? (
        <TouchableOpacity style={[styles.button, isProcessing === item.id && styles.buttonDisabled, styles.buttonSubscribe]}
        onPress={() => handleSubscribe(item)}
        disabled={isProcessing === item.id}
        >
          <Text style={styles.buttonText}>Subscribe</Text>
        </TouchableOpacity>
      ) : (
        <>

          <TouchableOpacity style={[styles.button, isProcessing === item.id && styles.buttonDisabled, styles.buttonResubscribe]}
          onPress={() => handleResubscribe(item)}
          disabled={isProcessing === item.id}
          >
            <Text style={styles.buttonText}>Resubscribe</Text>
          </TouchableOpacity>

          <TouchableOpacity style={[styles.button, isProcessing === item.id && styles.buttonDisabled, styles.buttonUnsubscribe]}
          onPress={() => handleUnsubscribe(item)}
          disabled={isProcessing === item.id}
          >
            <Text style={styles.buttonText}>Unsubscribe</Text>
          </TouchableOpacity>
        </>
      )}
      </View>
    </View>
  );

  const onRefresh = () => {
    setRefreshing(true);
    fetchEventPlayers();
  };

  if (loading && !refreshing) {
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
      refreshing={refreshing}
      onRefresh={onRefresh}
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
  buttonRow: {
    flexDirection: 'row',
    justifyContent: 'space-between', // This can be changed to 'center' if you want the buttons to be centered
    marginTop: 8,
  },
  button: {
    backgroundColor: '#555555',
    padding: 10,
    marginVertical: 4,
    borderRadius: 4,
    alignItems: 'center',
  },
  buttonText: {
    color: '#fff',
    fontWeight: 'bold',
  },
  buttonDisabled: {
    backgroundColor: '#999999', // Change the color to indicate that the button is disabled
  },
  buttonUnsubscribe: {
    backgroundColor: 'red'
  },
  buttonSubscribe: {
    backgroundColor: 'green'
  },
  buttonResubscribe: {
    backgroundColor: 'orange'
  },
  buttonEdit: {
    backgroundColor: 'blue'
  }
});

export default EventPlayerScreen;