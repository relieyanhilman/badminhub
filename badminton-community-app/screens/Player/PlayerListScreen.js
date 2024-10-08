//Player/PlayerListScreen
import React, { useState, useEffect, useCallback, useContext } from 'react';
import { View, Text, FlatList, Button, TouchableOpacity, StyleSheet, Alert, ActivityIndicator, Modal, TextInput} from 'react-native';
import { useFocusEffect } from '@react-navigation/native';
import { Picker } from '@react-native-picker/picker';
import {Ionicons} from '@expo/vector-icons';
import * as SecureStore from 'expo-secure-store';

import { EventContext } from '../../EventContext';
import {MatchContext} from '../../EventContext';

const PlayerListScreen = ({ navigation, route }) => {
  const { dayId } = route.params;
  const [players, setPlayers] = useState([]);
  const [masterPlayers, setMasterPlayers] = useState([]);
  const [filteredPlayers, setFilteredPlayers] = useState([]); // State untuk menyimpan hasil pencarian
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false); // State untuk pull-to-refresh
  const [error, setError] = useState(null);
  const [expandedPlayerIds, setExpandedPlayerIds] = useState([]);
  const [applyingPlayerIds, setApplyingPlayerIds] = useState([]); // State untuk melacak tombol yang sedang diproses

  const [filterModalVisible, setFilterModalVisible] = useState(false);

  // State untuk filter
  const [levelFilter, setLevelFilter] = useState('');
  const [matchPlayedFilter, setMatchPlayedFilter] = useState('');
  const [paymentStatusFilter, setPaymentStatusFilter] = useState('');
  const [genderFilter, setGenderFilter] = useState('');
  const [ageRangeFilter, setAgeRangeFilter] = useState('');

  // State untuk pencarian
  const [searchQuery, setSearchQuery] = useState('');

  // State untuk mark as leave
  const [markAsLeavePlayerId, setMarkAsLeavePlayerId] = useState(null);

  //untuk men-trigger refresh di EventPlayerScreen
  // khusus eventHtmNonMember adalah untuk mengelola visibilitas modal setelah menekan tombol mark as paid
  const { triggerRefresh, eventHtmNonMember } = useContext(EventContext);

  //untuk menerima trigger refresh dari addMatchScreen atau editMatchScreen
  const {matchUpdated, setMatchUpdated} = useContext(MatchContext);

  //state untuk mengelola visibilitas modal setelah menekan tombol mark as paid
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [nominal, setNominal] = useState(eventHtmNonMember);
  const [playerPaidModal, setPlayerPaidModal] = useState(null);
  const [isProcessing, setIsProcessing] = useState(false);

  useEffect(() => {
    fetchPlayers();
  }, []);

  useFocusEffect(
    useCallback(() => {
      if (route.params?.refresh) {
        fetchPlayers();
        // menghapus refresh param setelah fetching
        navigation.setParams({ refresh: false });
      }
    }, [route.params?.refresh])
  );

  useEffect(() => {
     applyFiltersAndSearch();
  }, [searchQuery, players, masterPlayers]);

  useEffect(() => {
      if (matchUpdated) {
        fetchPlayers();
        setMatchUpdated(false);
      }
    }, [matchUpdated]);

  const fetchPlayers = async (isRefreshing = false) => {7
    if (!isRefreshing) {
        setLoading(true)
    }
    setError(null);

    try {
      const token = await SecureStore.getItemAsync('userToken');
      if (!token) {
        throw new Error('User token not found');
      }

      // Fetch Event Day Players
      const response1 = await fetch(`https://apiv2.pbbedahulu.my.id/mabar/day/${dayId}`, {
        method: 'GET',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      });

      const data1 = await response1.json();

      // Fetch Master Players
      const response2 = await fetch(`https://apiv2.pbbedahulu.my.id/player`, {
        method: 'POST',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          page: 1,
          perPage: 1000,  // Fetch all data
        }),
      });

      const data2 = await response2.json();

      if (response1.ok && response2.ok) {
        const masterPlayerData = data2.data.filter(masterPlayer =>
          !data1.data.attendees.some(player => player.player.id === masterPlayer.id)
        );

        const updatedPlayers = data1.data.attendees.map(player => ({ ...player, isMasterPlayer: false }));
        const updatedMasterPlayers = masterPlayerData.map(player => ({ ...player, isMasterPlayer: true }));

        setPlayers(updatedPlayers);
        setMasterPlayers(updatedMasterPlayers);

        // Langsung terapkan filter setelah setPlayers dan setMasterPlayers
        applyFiltersAndSearch(updatedPlayers, updatedMasterPlayers);
      } else {
        setError(data.message || 'Failed to fetch players');
      }
    } catch (err) {
      console.log(err);
      setError('An error occurred while fetching data');
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  };

  const onRefresh = () => {
    setRefreshing(true);
    fetchPlayers(true);
  };

  const applyFilters = (players) => {
  return players.filter(player => {
    const isMasterPlayer = player.isMasterPlayer;

    const matchesLevelFilter = levelFilter === '' ||
      (isMasterPlayer ? player.level === levelFilter : player.player_level === levelFilter);

    const matchesMatchPlayedFilter = matchPlayedFilter === '' ||
      (!isMasterPlayer && player.match_played === parseInt(matchPlayedFilter));

    const matchesPaymentStatusFilter = paymentStatusFilter === '' ||
      (!isMasterPlayer && player.payment_status === paymentStatusFilter);

    const matchesGenderFilter = genderFilter === '' ||
      (isMasterPlayer ? player.gender === genderFilter : player.player.gender === genderFilter);

    const matchesAgeRangeFilter = ageRangeFilter === '' ||
      (isMasterPlayer ? player.age_range === ageRangeFilter : player.player.age_range === ageRangeFilter);

    return matchesLevelFilter &&
           matchesMatchPlayedFilter &&
           matchesPaymentStatusFilter &&
           matchesGenderFilter &&
           matchesAgeRangeFilter;
  });
};

  const handleSearch = (query) => {
      setSearchQuery(query)
  };

  const handleApplyPlayer = async (playerT) => {
    if (applyingPlayerIds.includes(playerT.id)) {
      return; // Jika tombol sudah ditekan, tidak lakukan apa-apa
    }

    Alert.alert(
        "Apply Player Confirmation",
        `Are you sure you want to apply ${playerT.name} (${playerT.alias}) to this event day?`,
        [
          {
            text: "Cancel",
            style: "cancel",
          },
          {
            text: "Yes",
            onPress: async () => {
                setApplyingPlayerIds(prevState => [...prevState, playerT.id]); // Tandai bahwa pemain ini sedang diproses

                try {
                  const token = await SecureStore.getItemAsync('userToken');
                  if (!token) {
                    throw new Error('User token not found');
                  }

                  const response = await fetch(`https://apiv2.pbbedahulu.my.id/mabar/day/detail/create`, {
                    method: 'POST',
                    headers: {
                      'Authorization': token,
                      'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                      open_mabar_day_id: dayId,
                      player_id: playerT.id,
                      payment_status: 'unpaid',
                    }),
                  });

                  if (response.ok) {
                      triggerRefresh(); // Trigger refresh di EventPlayerScreen
                      const response2 = await fetch(`https://apiv2.pbbedahulu.my.id/mabar/day/${dayId}`, {
                        method: 'GET',
                        headers: {
                          'Authorization': token,
                          'Content-Type': 'application/json',
                        },
                      });

                      const data2 = await response2.json()

                      if(response2.ok){
                        Alert.alert('Success', `Player ${playerT.name} (${playerT.alias}) applied successfully.`, [{ text: 'OK' }]);
                        const appliedPlayer = data2.data.attendees.filter(player => player.player_id === playerT.id)
                        const updatedPlayers = [...players, { ...appliedPlayer[0], isMasterPlayer: false }];
                        const updatedMasterPlayers = masterPlayers.filter(player => player.id !== playerT.id);

                        setPlayers(updatedPlayers);
                        setMasterPlayers(updatedMasterPlayers);

                        applyFiltersAndSearch(updatedPlayers, updatedMasterPlayers);
                      }else{
                        const data = await response.json();
                        Alert.alert('Error', data.message || 'Failed to get new mabar day player');
                      }
                  } else {
                    const data = await response.json();
                    Alert.alert('Error', data.errors[0]["msg"] || 'Failed to apply player');
                  }
                } catch (err) {
                  console.log(err);
                  Alert.alert('Error', 'An error occurred while applying player');
                }finally{
                  setApplyingPlayerIds(prevState => prevState.filter(id => id !== playerT.id)); // Selesai, hilangkan dari state
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
        if (playerItem.isMasterPlayer){
           if(playerItem.name.toLowerCase().includes(query.toLowerCase()) ||
           playerItem.alias.toLowerCase().includes(query.toLowerCase()) ||
           playerItem.contact.includes(query)) {
             hasilFilter.push(playerItem)
           }
        }else{
           if(playerItem.player.name.toLowerCase().includes(query.toLowerCase()) ||
           playerItem.player.alias.toLowerCase().includes(query.toLowerCase()) ||
           playerItem.player.contact.includes(query)){
             hasilFilter.push(playerItem)
           }
        }
      }
    return hasilFilter;
  };

  const applyFiltersAndSearch = (updatedPlayers = players, updatedMasterPlayers = masterPlayers) => {
    const combinedPlayers = [...updatedPlayers, ...updatedMasterPlayers];
    const filtered = applyFilters(combinedPlayers);
    const finalResult = applySearchFilter(filtered, searchQuery);
    setFilteredPlayers(finalResult);
  };

  const handlePaymentStatusChange = async (item) => {
     if (isProcessing) return;
     setPlayerPaidModal(item);
     setIsModalVisible(true);
  }

  const handleModalCancel = () => {
    setIsModalVisible(false)
  }
  const handleModalPaymentStatusChange = async () => {
    try {
      setIsProcessing(true);
      const token = await SecureStore.getItemAsync('userToken');
      if (!token) throw new Error('User token not found');

      const response = await fetch(`https://apiv2.pbbedahulu.my.id/cashflow/paid`, {
        method: 'POST',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ id: playerPaidModal.id, nominal: parseFloat(nominal) }),
      });

      if (response.ok) {
        setIsModalVisible(false);
        setIsProcessing(false);
        Alert.alert('Success', `Paid payment status player ${ playerPaidModal.player.name} (${playerPaidModal.player.alias}) marked successfully.`, [{ text: 'OK'}]);
        setPlayers((prevPlayers) =>
          prevPlayers.map((player) =>
            player.id === playerPaidModal.id ? { ...player, payment_status: 'paid' } : player
          )
        );
      } else {
        const data = await response.json();
        setIsModalVisible(false);
        setIsProcessing(false);
        Alert.alert('Error', data.message || 'Failed to change payment status');
      }
    } catch (error) {
      console.log(error);
      setIsProcessing(false);
      Alert.alert('Error', 'An error occurred while changing payment status');
    } finally {
      setPlayerPaidModal(null);
      setNominal(eventHtmNonMember)
    }

  }

  const toggleExpand = (playerId) => {
    setExpandedPlayerIds(prevState =>
      prevState.includes(playerId)
        ? prevState.filter(id => id !== playerId)
        : [...prevState, playerId]
    );
  };

  const StatusIcon = ({ item }) => {
      let color;
      let iconName;

      switch (item.status) {
        case 1:
          color = '#34C759'; // hijau
          iconName = 'radio-button-on';
          break;
        case 0:
          color = '#F7DC6F'; // kuning
          iconName = 'radio-button-on';
          break;
        case 2:
          color = 'red'; // abu-abu
          iconName = 'close-circle';
          break;
        default:
          color = '#AAAAAA'; // abu-abu
          iconName = 'help-circle';
          break;
      }

      return (
        <View style={{ flexDirection: 'row', alignItems: 'center' }}>
          <Ionicons name={iconName} size={16} color={color} />
          <Text style={{ marginLeft: 5 }}>{item.status_info}</Text>
        </View>
      );
    };

  const handleLeavePlayer = async (playerT) => {
    Alert.alert(
        "Mark as Leave Confirmation",
        `Are you sure you want to Mark as Leave player ${playerT.player.name} (${playerT.player.alias}) ?`,
        [
          {
            text: "Cancel",
            style: "cancel",
          },
          {
            text: "Yes",
            onPress: async () => {
                setMarkAsLeavePlayerId(playerT.id);
                try {
                  const token = await SecureStore.getItemAsync('userToken');
                  if (!token) throw new Error('User token not found');

                  const response = await fetch(`https://apiv2.pbbedahulu.my.id/mabar/day/detail/leave`, {
                    method: 'POST',
                    headers: {
                      'Authorization': token,
                      'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ id: playerT.id }),
                  });

                  if (response.ok) {
                    Alert.alert('Success', `Status player ${playerT.player.name} (${playerT.player.alias}) marked as leave successfully.`, [{ text: 'OK'}]);
                    setPlayers((prevPlayers) =>
                      prevPlayers.map((player) =>
                        player.id === playerT.id ? { ...player, status: 2, status_info: 'leave' } : player
                      )
                    );
                  } else {
                    const data = await response.json();
                    Alert.alert('Error', data.message || 'Failed to change payment status');
                  }
                } catch (error) {
                  console.log(error);
                  Alert.alert('Error', 'An error occurred while changing payment status');
                } finally {
                  setMarkAsLeavePlayerId(null);
                }
            }
          }
        ]
    )
  }

  const renderItem = ({ item }) => {
   const isMasterPlayer = item.isMasterPlayer;
   const isExpanded = expandedPlayerIds.includes(item.id);
   const isApplying = applyingPlayerIds.includes(item.id);

   return (
      <View style={isMasterPlayer ? styles.masterItem : styles.item}>
        <View style={styles.itemInfo}>
        {isMasterPlayer ? (
            <>
              <Text style={styles.nameText}>{item.name} ({item.alias})</Text>
              <Text style={styles.text}>Level: {item.level}</Text>
              <Text style={styles.text}>Age Range: {item.age_range}</Text>
            </>
        ) : (
            <>
              <View style={styles.playerInfoRow}>
                  <Text style={styles.nameText}>{item.player.name} ({item.player.alias})</Text>
                  <StatusIcon item={item} />
              </View>
              <Text style={styles.text}>Level: {item.player_level}</Text>
              <Text style={styles.text}>Arrival Time: {new Date(item.player_arrival_time).toLocaleString()}</Text>
              <Text style={styles.text}>Matches Played: {item.match_played}</Text>
              <Text style={styles.text}>Shuttlecock Used: {item.shuttlecock_used === null? "0" : item.shuttlecock_used}</Text>
              <Text style={styles.text}>Payment Status: {item.payment_status}</Text>
            </>
        )}


        </View>
        {isExpanded && (
          <View style={styles.hiddenInfo}>
            {isMasterPlayer? (
                <>
                <Text style={styles.text}>Gender: {item.gender}</Text>
                <Text style={styles.text}>Contact: {item.contact}</Text>
                </>
            ) : (
                <>
                <Text style={styles.text}>Gender: {item.player.gender}</Text>
                <Text style={styles.text}>Contact: {item.player.contact}</Text>
                <Text style={styles.text}>Age Range: {item.player.age_range}</Text>
                </>
            )}
          </View>
        )}
        <View style={styles.itemButtons}>
          <TouchableOpacity style={styles.expandButton} onPress={() => toggleExpand(item.id)}>
            <Text style={[styles.buttonText, {textAlign: 'center', fontSize: 12}]}>{isExpanded ? 'Hide Details' : 'Show Details'}</Text>
          </TouchableOpacity>
          {isMasterPlayer ? (
            <Button title="Apply Player" onPress={() => handleApplyPlayer(item)} disabled={isApplying}/>
          ) :
          (
            <View style={[styles.markButtonContainer, {flexDirection: 'row', alignItems: 'center', columnGap: 5}]}>
              <Button
                title={isProcessing ? "Processing..." : "Mark as Paid"}
                onPress={() => handlePaymentStatusChange(item)}
                disabled={item.payment_status === "paid" || isProcessing}
                color={item.payment_status === "paid" ? "green" : "orange"}
              />
          {item.status_info !== "leave" && (
            <Button
              title={isProcessing ? "Processing..." : "Mark as Leave"}
              onPress={() => handleLeavePlayer(item)}
              disabled={item.status_info === "leave" || isProcessing}
              color={item.status_info === "leave" ? "grey" : "red"}
            />
          )}
            </View>
          )}
        </View>
      </View>
);};

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
        <TouchableOpacity onPress={fetchPlayers} style={styles.retryButton}>
          <Text style={styles.retryText}>Try Again</Text>
        </TouchableOpacity>
      </View>
    );
  }

  return (
    <View style={styles.container}>

      <View style={styles.buttonContainer}>
        <TextInput
          style={styles.searchInput}
          placeholder="Search by name, alias, or contact"
          value={searchQuery}
          onChangeText={handleSearch}
        />
        <TouchableOpacity
          style={styles.filterButton}
          onPress={() => setFilterModalVisible(true)}
        >
          <Text style={styles.buttonText}>FILTER</Text>
        </TouchableOpacity>
      </View>

      <Modal
        visible={filterModalVisible}
        animationType="slide"
        transparent={true}
        onRequestClose={() => setFilterModalVisible(false)}
      >

        <View style={styles.modalContainer}>
          <View style={styles.modalContent}>
            <Text style={styles.modalTitle}>Filter Options</Text>

            <Text style={styles.label}>Player Level</Text>
            <Picker selectedValue={levelFilter} onValueChange={(itemValue) => setLevelFilter(itemValue)}>
              <Picker.Item label="All Levels" value="" />
              <Picker.Item label="Level A" value="A" />
              <Picker.Item label="Level B" value="B" />
              <Picker.Item label="Level C" value="C" />
            </Picker>

            <Text style={styles.label}>Matches Played</Text>
            <TextInput
              style={styles.textInput}
              placeholder="Enter exact number"
              value={matchPlayedFilter}
              onChangeText={(text) => setMatchPlayedFilter(text)}
              keyboardType="numeric"
            />

            <Text style={styles.label}>Payment Status</Text>
            <Picker selectedValue={paymentStatusFilter} onValueChange={(itemValue) => setPaymentStatusFilter(itemValue)}>
              <Picker.Item label="All Payment Status" value="" />
              <Picker.Item label="Paid" value="paid" />
              <Picker.Item label="Unpaid" value="unpaid" />
            </Picker>

            <Text style={styles.label}>Gender</Text>
            <Picker selectedValue={genderFilter} onValueChange={(itemValue) => setGenderFilter(itemValue)}>
              <Picker.Item label="All Genders" value="" />
              <Picker.Item label="Male" value="M" />
              <Picker.Item label="Female" value="F" />
            </Picker>

            <Text style={styles.label}>Age Range</Text>
            <Picker selectedValue={ageRangeFilter} onValueChange={(itemValue) => setAgeRangeFilter(itemValue)}>
              <Picker.Item label="All Age Ranges" value="" />
              <Picker.Item label="15-20" value="15-20" />
              <Picker.Item label="21-30" value="21-30" />
              <Picker.Item label="31-40" value="31-40" />
              <Picker.Item label="41-50" value="41-50" />
              <Picker.Item label="51-60" value="51-60" />
              <Picker.Item label="61-70" value="61-70" />
              <Picker.Item label="71-80" value="71-80" />
            </Picker>

          <View style={styles.modalButtonContainer}>
            <TouchableOpacity
              style={styles.cancelFilterButton}
              onPress={() => setFilterModalVisible(false)}
            >
              <Text style={styles.cancelFilterButtonText}>Cancel</Text>
            </TouchableOpacity>

            <TouchableOpacity
              style={styles.applyFilterButton}
              onPress={() => {
                setFilterModalVisible(false);
                applyFiltersAndSearch();
              }}
            >
              <Text style={styles.applyFilterButtonText}>Apply Filters</Text>
            </TouchableOpacity>
           </View>

          </View>
        </View>
      </Modal>

      {/* Tombol CREATE PLAYER */}
      <TouchableOpacity
        style={styles.createButton}
        onPress={() => navigation.navigate('AddPlayer', { dayId })}
      >
        <Text style={styles.buttonText}>CREATE PLAYER</Text>
      </TouchableOpacity>

      {/* Tombol Modal untuk Mark as Paid*/}
      <Modal
        visible={isModalVisible}
        animationType="slide"
        transparent={true}
        onRequestClose={() => setIsModalVisible(false)}
      >
        <View style={styles.modalContainer}>
            <View style={styles.modalContent}>
                <Text style={styles.modalTitle}>Mark as Paid Player</Text>
                  <Text style={styles.labelModal}>Nominal</Text>
                  <TextInput
                    style={styles.textInputModal}
                    value={nominal.toString()}
                    onChangeText={(text) => setNominal(text)}
                    placeholder={eventHtmNonMember.toString()}
                    keyboardType="numeric"
                  />
                  <View style={[styles.modalButtonContainer, {columnGap: 5}]}>
                    <TouchableOpacity
                      style={[styles.buttonModal, {backgroundColor: '#d9534f'}]}
                      onPress={ () => {
                        handleModalCancel();
                        setNominal(eventHtmNonMember);
                        setPlayerPaidModal(null);
                      }}
                    >
                      <Text style={styles.buttonText}>Cancel</Text>
                    </TouchableOpacity>
                    <TouchableOpacity
                      style={[styles.buttonModal, {backgroundColor: '#007BFF'}]}
                      onPress={ () => handleModalPaymentStatusChange()}
                    >

                      <Text style={styles.buttonTextModal}>Mark as Paid</Text>
                    </TouchableOpacity>
                  </View>
            </View>
        </View>
      </Modal>

      <FlatList
        data={filteredPlayers}
        renderItem={renderItem}
        keyExtractor={item => item.isMasterPlayer ? `master-${item.id}` : `event-${item.id}`}
        contentContainerStyle={{ paddingBottom: 16 }}
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
  filterButton: {
    flex: 2,
    height: 40,
    backgroundColor: '#646464',
    paddingVertical: 10,
    paddingHorizontal: 20,
    borderRadius: 5,
    alignItems: 'center',
    justifyContent: 'center',
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
  buttonContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 7
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
  retryButton: {
    backgroundColor: '#007BFF',
    paddingVertical: 10,
    paddingHorizontal: 20,
    borderRadius: 5,
  },
  retryText: {
    color: '#fff',
    fontWeight: 'bold',
  },
  listContainer: {
    paddingHorizontal: 16,
  },
  item: {
      backgroundColor: '#f9f9f9',
      padding: 16,
      marginVertical: 8,
      borderRadius: 8,
      borderColor: '#ccc',
      borderWidth: 1,
  },
  masterItem: {
    backgroundColor: '#e6f7ff', // Highlighted background color for masterPlayers
    padding: 16,
    marginVertical: 8,
    borderRadius: 8,
    borderColor: '#007BFF', // Blue border for masterPlayers
    borderWidth: 1,
  },
  itemInfo: {
    marginBottom: 12,
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
  itemButtons: {
    flexDirection: 'row',
    justifyContent: 'center',
  },
  createButton: {
    marginBottom: 10,
    backgroundColor: '#007BFF',
    padding: 10,
    borderRadius: 5,
    alignItems: 'center',
  },
  buttonText: {
    color: '#fff',
    fontWeight: 'bold',
    textAlign: 'center',
  },
  expandButton: {
    backgroundColor: '#d3d3d3',
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 8,
    padding: 3
  },
  filterContainer: {
    marginBottom: 16,
    backgroundColor: '#fff',
    borderRadius: 8,
    padding: 10,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },

  filterButtonText: {
    color: '#fff',
    fontWeight: 'bold',
  },
  modalContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
  },
  modalContent: {
    width: '80%',
    backgroundColor: '#fff',
    borderRadius: 10,
    padding: 20,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 5,
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 16,
    textAlign: 'center',
  },
  modalButtonContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginTop: 16,
  },
  buttonModal: {
      flex: 1,
      paddingVertical: 12,
      paddingHorizontal: 20,
      borderRadius: 5,
      alignItems: 'center',
  },
  buttonText: {
    color: '#fff',
    fontWeight: 'bold',
  },
  buttonTextModal: {
      color: '#fff',
      fontWeight: 'bold',
  },
  textInputModal: {
      height: 40,
      borderColor: '#ccc',
      borderWidth: 1,
      borderRadius: 5,
      paddingHorizontal: 10,
      marginBottom: 12,
    },
  labelModal: {
      fontSize: 16,
      fontWeight: 'bold',
      marginBottom: 5
  },
  cancelFilterButton: {
    flex: 1,
    backgroundColor: '#d9534f',
    paddingVertical: 12,
    paddingHorizontal: 20,
    borderRadius: 5,
    alignItems: 'center',
    marginRight: 8,
    marginTop: 16,
  },
  cancelFilterButtonText: {
    color: '#fff',
    fontWeight: 'bold',
  },
  applyFilterButton: {
    flex: 1,
    backgroundColor: '#007BFF',
    paddingVertical: 12,
    paddingHorizontal: 20,
    borderRadius: 5,
    alignItems: 'center',
    marginTop: 16,
  },
  applyFilterButtonText: {
    color: '#fff',
    fontWeight: 'bold',
  },
  label: {
    fontSize: 16,
    fontWeight: 'bold'
  },
  playerInfoRow : {
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'center',
  },
  textInput: {
    height: 40,
    borderColor: '#ccc',
    borderWidth: 1,
    borderRadius: 5,
    paddingHorizontal: 10,
    marginBottom: 12,
  },

});

export default PlayerListScreen;
