// screens/EventDay/EventPlayerScreen.js
import React, { useState, useEffect, useContext, useCallback } from 'react';
import { View, Text, FlatList, ActivityIndicator, StyleSheet, Alert, TouchableOpacity, TextInput, Modal } from 'react-native';
import { useFocusEffect } from '@react-navigation/native';
import * as SecureStore from 'expo-secure-store';
import { EventContext } from '../../EventContext';
import DateTimePicker from '@react-native-community/datetimepicker';

const EventPlayerScreen = ({ route, navigation }) => {
  const { eventId, shouldRefresh, resetRefresh, eventHtmMember } = useContext(EventContext);
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

  //state untuk justifikasi di-display lebih detail terkait info membership tiap player yang termasuk member
  const [expandedPlayerIds, setExpandedPlayerIds] = useState([])

  //state untuk modal subscribe
  const [isModalVisible, setIsModalVisible] = useState({visible: false, modeSubResub: null});
  const [membershipStart, setMembershipStart] = useState(new Date().toISOString().split('T')[0]);
  const [nominal, setNominal] = useState(eventHtmMember);
    //default value membershipEndDate adalah 4 weeks dari membershipStart
      const date = new Date();
      date.setDate(date.getDate() + 28);
      const membershipEndDate = date.toISOString().split('T')[0];
      const [membershipEnd, setMembershipEnd] = useState(membershipEndDate);
  const [playerSubResubModal, setPlayerSubResubModal] = useState(null);
  const [showDatePicker, setShowDatePicker] = useState({visible: false, mode: null});
  const [maxParticipation, setMaxParticipation] = useState(4);

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

  useFocusEffect(
    useCallback(() => {
      if (shouldRefresh) {
        fetchEventPlayers();
        resetRefresh(); // Reset state setelah refresh dilakukan
      }
    }, [shouldRefresh])
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

  const handleSubResub = async (player, modeSubResub) => {
    // Handle the subscribe action
    if (isProcessing) return;
    setPlayerSubResubModal(player.player)
    setIsModalVisible({visible: true, modeSubResub: modeSubResub});
  };

  const handleModalSubResub = async (modeSubResub) => {
    try {
      if (membershipStart > membershipEnd){
        throw new Error("membership start date must be before membership end date");
      }
      if (nominal == '' || maxParticipation == ''){
        throw new Error("All fields must be filled in");
      }
      if (nominal < 0 || maxParticipation < 0){
        throw new Error("Nominal and max participation must be a positive number");
      }
      setIsProcessing(true)
      const token = await SecureStore.getItemAsync('userToken');
      let api;
      if (modeSubResub == "sub"){
        api = "https://apiv2.pbbedahulu.my.id/mabar/player/create"
      } else if (modeSubResub == 'resub'){
        api = "https://apiv2.pbbedahulu.my.id/mabar/player/recreate"
      }
      const response = await fetch(api, {
        method: 'POST',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          player_id: playerSubResubModal.id,
          open_mabar_id: eventId,
          payment_method: "Cash",
          membership_start: membershipStart,
          membership_end: membershipEnd,
          nominal: parseFloat(nominal),
          max_participation: parseInt(maxParticipation),
        }),
      });

      const result = await response.json();

      if (result.success) {
        const message = modeSubResub == 'sub' ? 'Player subscribed successfully.' : 'Player resubscribed successfully.'
        setIsModalVisible({visible: false, modeSubResub: null})
        Alert.alert('Success', message, [{ text: 'OK'}]);
      } else {
        const errorMessage = modeSubResub == 'sub'? 'Failed to subscribe player.' : 'Failed to resubscribe player.'
        setIsModalVisible({visible: false, modeSubResub: null})
        Alert.alert('Error', result.message || errorMessage, [{ text: 'OK'}]);
      }
    } catch (err) {
      console.log(err)
      const catchErrorMessage = modeSubResub == 'sub'? 'An error occurred while subscribing player.' : 'An error occurred while resubscribing player.'
      Alert.alert('Error', err.message || catchErrorMessage, [{ text: 'OK', onPress: () => setIsModalVisible({visible: false, modeSubResub: null}) }]);
    } finally{
      setIsProcessing(false);
      setPlayerSubResubModal(null)
      setModalAttToDefault()
    }
  };

  const handleModalCancel = () => {
    setIsModalVisible({visible: false, modeSubResub: null});
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

  const applySearchFilter = (players, query) => {
    if (!query){
      return players
    }
      const hasilFilter = [];
      for (const playerItem of players){
           if(playerItem.player.name.toLowerCase().includes(query.toLowerCase()) ||
           playerItem.player.alias.toLowerCase().includes(query.toLowerCase()) ||
           playerItem.player.contact.includes(query)){
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

  const toggleExpand = (playerId) => {
    setExpandedPlayerIds(prevState =>
      prevState.includes(playerId)
        ? prevState.filter(id => id !== playerId)
        : [...prevState, playerId]
    );
  };

  const renderItem = ({ item }) => {
    const isExpanded = expandedPlayerIds.includes(item.id);

    return (
        <View style={styles.itemContainer}>
          <Text style={styles.nameText}>{item.player.name} ({item.player.alias})</Text>
           <View style={{flexDirection: 'row', justifyContent: 'space-between'}}>
             <View>
              <Text style={styles.text}>Level: {item.player.level}</Text>
              <Text style={styles.text}>Gender: {item.player.gender}</Text>
              <Text style={styles.text}>Age Range: {item.player.age_range}</Text>
              <Text style={styles.text}>Contact: {item.player.contact}</Text>
              <Text style={styles.text}>Status: {item.status}</Text>
              {item.note && <Text style={styles.text}>Note: {item.note}</Text>}
              {item.status === 'member' ? (
                <TouchableOpacity style={styles.toggleButton} onPress={() => toggleExpand(item.id)}>
                  <Text style={styles.toggleButtonText}>{isExpanded ? 'Hide Detail Membership' : 'Show Detail Membership'}</Text>
                </TouchableOpacity>
              ) : (<></>)
              }
             </View>

              <View style={styles.buttonColumn}>
               <TouchableOpacity style={[styles.button, isProcessing === item.id && styles.buttonDisabled, styles.buttonEdit]}
               onPress={() => handleEdit(item.player)}
               disabled={isProcessing === item.id}
               >
                 <Text style={styles.buttonText}>Edit</Text>
               </TouchableOpacity>

               {item.status === 'non member' ? (
                 <TouchableOpacity style={[styles.button, isProcessing === item.id && styles.buttonDisabled, styles.buttonSubscribe]}
                 onPress={() => handleSubResub(item, 'sub')}
                 disabled={isProcessing === item.id}
                 >
                   <Text style={styles.buttonText}>Subscribe</Text>
                 </TouchableOpacity>
               ) : (
                 <>
                   <TouchableOpacity style={[styles.button, isProcessing === item.id && styles.buttonDisabled, styles.buttonResubscribe]}
                   onPress={() => handleSubResub(item, 'resub')}
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

          {isExpanded ? (
            <View style={styles.expandedContainer}>
              <Text style={styles.text}>Membership start: {item.membership_start}</Text>
              <Text style={styles.text}>Membership end: {item.membership_end}</Text>
              <Text style={styles.text}>Jumlah sudah bermain: {item.current_participation_count}</Text>
              <Text style={styles.text}>Sisa bermain: {item.participation_count_left}</Text>
                </View>
          ) : (<></>)}



        </View>
  );}

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

  const handleMembershipDateChange = (event, selectedDate) => {
    const mode = showDatePicker.mode
    setShowDatePicker({visible: false, mode: null});

    if (selectedDate) {
        if(mode === 'startDatePicker'){
          setMembershipStart(selectedDate.toISOString().split('T')[0]); // Format YYYY-MM-DD
        } else if (mode === 'endDatePicker'){
          setMembershipEnd(selectedDate.toISOString().split('T')[0]); // Format YYYY-MM-DD)
        }
    }
  }

  const setModalAttToDefault = () => {
    setNominal(eventHtmMember)
    setMembershipStart(new Date().toISOString().split('T')[0]);

    const date = new Date();
    date.setDate(date.getDate() + 28);
    const membershipEndDate = date.toISOString().split('T')[0];
    setMembershipEnd(membershipEndDate);

    setMaxParticipation(4)
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

    <Modal
      visible={isModalVisible.visible}
      animationType="slide"
      transparent={true}
      onRequestClose={() => setIsModalVisible({visible: false, modeSubResub: null})}
    >
      <View style={styles.modalContainer}>
        <View style={styles.modalContent}>
          {isModalVisible.modeSubResub === 'sub' ? (
            <Text style={styles.modalTitle}>Subscribe Player</Text>
          ) :
          ( <Text style={styles.modalTitle}>Resubscribe Player</Text>
          )
          }
          <Text style={styles.labelModal}>Membership Start</Text>
          <TouchableOpacity onPress={() => setShowDatePicker({visible: true, mode: 'startDatePicker'})}>
              <TextInput
                style={styles.textInputModal}
                value={membershipStart}
                placeholder={membershipStart}
                editable={false}
              />
          </TouchableOpacity>
          <Text style={styles.labelModal}>Membership End</Text>
          <TouchableOpacity onPress={() => setShowDatePicker({visible: true, mode: 'endDatePicker'})}>
            <TextInput
              style={styles.textInputModal}
              value={membershipEnd}
              placeholder={membershipEnd}
              editable={false}
            />
          </TouchableOpacity>
          {showDatePicker.visible == true && (
              <DateTimePicker
                value={showDatePicker.mode === 'startDatePicker' ? new Date(membershipStart) : new Date(membershipEnd)} // Pastikan nilai awal adalah tanggal valid
                mode="date"
                display="default"
                onChange={handleMembershipDateChange}
              />
          )}

          <Text style={styles.labelModal}>Max Participation</Text>
          <TextInput
            style={styles.textInputModal}
            value={maxParticipation.toString()}
            onChangeText={(text) => setMaxParticipation(text)}
            placeholder="4"
            keyboardType="numeric"
          />

          <Text style={styles.labelModal}>Nominal</Text>
          <TextInput
            style={styles.textInputModal}
            value={nominal.toString()}
            onChangeText={(text) => setNominal(text)}
            placeholder={eventHtmMember.toString()}
            keyboardType="numeric"
          />

          <View style={styles.modalButtonContainer}>
            <TouchableOpacity
              style={[styles.buttonModal, {backgroundColor: '#d9534f'}]}
              onPress={ () => {
                handleModalCancel();
                setModalAttToDefault();
              }}
            >
              <Text style={styles.buttonText}>Cancel</Text>
            </TouchableOpacity>
            {isModalVisible.modeSubResub == 'sub' ? (
                <TouchableOpacity
                  style={[styles.buttonModal, {backgroundColor: '#007BFF'}]}
                  onPress={ () => handleModalSubResub('sub')}
                >

                  <Text style={styles.buttonTextModal}>Subscribe</Text>
                </TouchableOpacity>
            ) :
            (
                <TouchableOpacity
                  style={[styles.buttonModal, {backgroundColor: '#007BFF'}]}
                  onPress={ () => handleModalSubResub('resub')}
                >

                  <Text style={styles.buttonTextModal}>Resubscribe</Text>
                </TouchableOpacity>
            )
            }


          </View>
        </View>
      </View>
    </Modal>

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
      columnGap: 5
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
  buttonColumn: {
    flexDirection: 'column',
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
  },
  toggleButton: {
    marginVertical: 5,
    alignSelf: 'flex-start',
    padding: 8,
    backgroundColor: '#d3d3d3',
  },
  toggleButtonText: {
    color: '#fff',
    fontSize: 14,
    fontWeight: 'bold',
  },
  expandedContainer: {
    marginTop: 10,
    backgroundColor: '#f0f0f0',  // Light background for expanded area
    padding: 10,
    borderRadius: 5,
  },

});

export default EventPlayerScreen;