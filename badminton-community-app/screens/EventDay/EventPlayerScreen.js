// screens/EventDay/EventPlayerScreen.js
import React, { useState, useEffect, useContext, useCallback } from 'react';
import { View, Text, FlatList, ActivityIndicator, StyleSheet, Alert, TouchableOpacity, TextInput } from 'react-native';
import { useFocusEffect } from '@react-navigation/native';
import * as SecureStore from 'expo-secure-store';
import { EventContext } from '../../EventContext';

const EventPlayerScreen = ({ route, navigation }) => {
  const { eventId } = useContext(EventContext);
  const [players, setPlayers] = useState([]);
  const [filteredPlayers, setFilteredPlayers] = useState([]); // State untuk menyimpan hasil pencarian
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false); // State for pull to refresh
  const [error, setError] = useState(null);

  const [isProcessing, setIsProcessing] = useState(null); // State to track which button is being processed

  // State untuk pencarian
  const [searchQuery, setSearchQuery] = useState('');

  //State untuk filter member, non member, atau all players
  const [filterOption, setFilterOption] = useState('all'); // 'all', 'member', 'non member'


  useEffect(() => {
    fetchEventPlayers();
  }, []);

  useEffect(() => {
     applyFiltersAndSearch();
  }, [searchQuery, players, filterOption]);

  useFocusEffect(
    useCallback(() => {
      if (route.params?.refresh) {
        fetchEventPlayers();
        // menghapus refresh param setelah fetching
        navigation.setParams({ refresh: false });
      }
    }, [route.params?.refresh])
  );

  const fetchEventPlayers = async () => {
    setLoading(true);  // Set loading to true when fetching data
    try {
      const token = await SecureStore.getItemAsync('userToken');
      if (!token) {
        throw new Error('User token not found');
      }

      const response = await fetch(`https://apiv2.pbbedahulu.my.id/mabar/player/${eventId}`, {
        method: 'GET',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      });

      const result = await response.json();

      if (response.ok) {
        setPlayers(result.data);

        //langsung terapkan filter setelah setPlayers
        applyFiltersAndSearch(players)
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
    navigation.navigate("EditEventPlayer", {player})
  };

  const handleSubscribe = async (player) => {
    // Handle the subscribe action
    if (isProcessing) return;

    Alert.alert(
        "Subscribe Confirmation",
        `Are you sure you want to subscribe ${player.player.name}?`,
        [
          {
            text: "Cancel",
            style: "cancel",
            onPress: () => setIsProcessing(null),
          },
          {
            text: "Yes",
            onPress: async () => {
              setIsProcessing(player.id);
                  try {
                    const token = await SecureStore.getItemAsync('userToken');
                    const response = await fetch('https://apiv2.pbbedahulu.my.id/mabar/player/create', {
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
            }
          }
        ]
    )
  };

  const handleUnsubscribe = async (player) => {
    if (isProcessing) return;

    Alert.alert(
        "Unsubscribe Confirmation",
        `Are you sure you want to unsubscribe ${player.player.name}?`,
        [
          {
            text: "Cancel",
            style: "cancel",
            onPress: () => setIsProcessing(null),
          },
          {
            text: "Yes",
            onPress: async () => {
            setIsProcessing(player.id);
              try {
                const token = await SecureStore.getItemAsync('userToken');
                const response = await fetch('https://apiv2.pbbedahulu.my.id/mabar/player/delete', {
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
            }
          }
        ]
    )
  };

  const handleResubscribe = async (player) => {
    if (isProcessing) return;

    Alert.alert(
        "Resubscribe Confirmation",
        `Are you sure you want to resubscribe ${player.player.name}?`,
        [
          {
            text: "Cancel",
            style: "cancel",
            onPress: () => setIsProcessing(null),
          },
          {
            text: "Yes",
            onPress: async () => {
              setIsProcessing(player.id);
          try {
            const token = await SecureStore.getItemAsync('userToken');
            const response = await fetch('https://apiv2.pbbedahulu.my.id/mabar/player/recreate', {
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
        }
      }
    ]
   )
  }

  const applySearchFilter = (players, query) => {
    if (!query){
      return players
    }
      const hasilFilter = [];
      for (const playerItem of players){
           if(playerItem.player.name.toLowerCase().includes(query.toLowerCase()) || playerItem.player.alias.toLowerCase().includes(query.toLowerCase())){
             hasilFilter.push(playerItem)
           }
      }
    return hasilFilter;
  };

  const applyFiltersAndSearch = (updatedPlayers = players) => {
    let filteredByMembership;
    if (filterOption === 'member') {
      filteredByMembership = updatedPlayers.filter(player => player.status !== 'non member');
    } else if (filterOption === 'non member') {
      filteredByMembership = updatedPlayers.filter(player => player.status === 'non member');
    } else {
      filteredByMembership = updatedPlayers; // Jika 'all', tidak ada filter
    }
    const finalResult = applySearchFilter(filteredByMembership, searchQuery);
    setFilteredPlayers(finalResult);
  };

    // Fungsi untuk menangani perubahan filter
  const handleFilterChange = (selectedOption) => {
      setFilterOption(selectedOption);
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
      onPress={() => handleEdit(item.player)}
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
   <View style={styles.container}>

    <View style={styles.buttonContainer}>
        <TextInput
          style={styles.searchInput}
          placeholder="Search by name or alias"
          value={searchQuery}
          onChangeText={(query) => setSearchQuery(query)}
        />
    </View>

    <View style={styles.filterContainer}>
      <TouchableOpacity
        style={[styles.filterButton, filterOption === 'all' && styles.activeFilter]}
        onPress={() => handleFilterChange('all')}
      >
        <Text style={styles.filterText}>All</Text>
      </TouchableOpacity>
      <TouchableOpacity
        style={[styles.filterButton, filterOption === 'member' && styles.activeFilter]}
        onPress={() => handleFilterChange('member')}
      >
        <Text style={styles.filterText}>Members</Text>
      </TouchableOpacity>
      <TouchableOpacity
        style={[styles.filterButton, filterOption === 'non member' && styles.activeFilter]}
        onPress={() => handleFilterChange('non member')}
      >
        <Text style={styles.filterText}>Non Members</Text>
      </TouchableOpacity>
    </View>

    <FlatList
      data={filteredPlayers}
      renderItem={renderItem}
      keyExtractor={(item) => item.id.toString()}
      contentContainerStyle={{paddingBottom: 16}}
      refreshing={refreshing}
      onRefresh={onRefresh}
    />

    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
    backgroundColor: '#f5f5f5',
  },
  filterContainer: {
    flexDirection: 'row',
    justifyContent: 'flex-start',
    marginBottom: 10,
    columnGap: 5
  },
  filterButton: {
    padding: 10,
    borderRadius: 5,
    backgroundColor: '#ccc',
  },
  activeFilter: {
    backgroundColor: '#007bff',
  },
  filterText: {
    color: '#fff',
    fontWeight: 'bold',
  },
  buttonContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 7
  },
  searchInput: {
    flex: 8,
    height: 40,
    marginRight: 3,
    borderColor: '#ccc',
    borderWidth: 1,
    borderRadius: 5,
    paddingHorizontal: 10,
  },
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