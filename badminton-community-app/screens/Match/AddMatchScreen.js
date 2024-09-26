// Match/AddMatchScreen.js
import React, { useState, useEffect, useContext, useMemo, useCallback } from 'react';
import { View, Text, TextInput, Button, StyleSheet, Alert, ActivityIndicator, ScrollView, FlatList, TouchableOpacity} from 'react-native';
import * as SecureStore from 'expo-secure-store';
import { EventContext } from '../../EventContext';
import { MatchContext } from '../../EventContext';
import { Picker } from '@react-native-picker/picker';
import DateTimePicker from '@react-native-community/datetimepicker';

// Komponen untuk List Pemain
const PlayerList = React.memo(({ filteredAttendees, showAllPlayers, setShowAllPlayers, handleSelectPlayer }) => (
  <>
    <FlatList
      data={filteredAttendees}
      keyExtractor={(item) => item.player.id.toString()}
      renderItem={({ item }) => (
        <TouchableOpacity onPress={() => handleSelectPlayer(item.player.id)}>
          <Text style={styles.listItem}>{`${item.player.name} (${item.player.alias}) - Level ${item.player.level}`}</Text>
        </TouchableOpacity>
      )}
      nestedScrollEnabled={true}
      style={showAllPlayers ? styles.searchResultList : [{ maxHeight: 200 }, styles.searchResultList]}
    />
    {!showAllPlayers && filteredAttendees.length > 3 && (
      <TouchableOpacity onPress={() => setShowAllPlayers(true)}>
        <Text style={styles.clickMoreText}>Click More</Text>
      </TouchableOpacity>
    )}
  </>
));

const AddMatchScreen = ({ navigation, route }) => {
  const {eventHallId} = useContext(EventContext)
  const { dayId } = route.params;
  const [attendees, setAttendees] = useState([]);
  const [courts, setCourts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [courtLoading, setCourtLoading] = useState(true);
  const [error, setError] = useState(null);

  //Context Match untuk update PlayerListScreen setiap update match
  const {setMatchUpdated} = useContext(MatchContext)

  const [courtId, setCourtId] = useState('');
  const [playerIdA1, setPlayerIdA1] = useState('');
  const [playerNameA1, setPlayerNameA1] = useState(''); // State untuk menyimpan nama pemain A1
  const [playerLevelA1, setPlayerLevelA1] = useState('');
  const [playerIdA2, setPlayerIdA2] = useState('');
  const [playerNameA2, setPlayerNameA2] = useState(''); // State untuk menyimpan nama pemain A2
  const [playerLevelA2, setPlayerLevelA2] = useState('');
  const [playerIdB1, setPlayerIdB1] = useState('');
  const [playerNameB1, setPlayerNameB1] = useState(''); // State untuk menyimpan nama pemain B1
  const [playerLevelB1, setPlayerLevelB1] = useState('');
  const [playerIdB2, setPlayerIdB2] = useState('');
  const [playerNameB2, setPlayerNameB2] = useState(''); // State untuk menyimpan nama pemain B2
  const [playerLevelB2, setPlayerLevelB2] = useState('');
  const [startTime, setStartTime] = useState(new Date());
  const [showTimePicker, setShowTimePicker] = useState(false);
  const [note, setNote] = useState('');

  // State for search query
  const [searchQueryA1, setSearchQueryA1] = useState('');
  const [searchQueryA2, setSearchQueryA2] = useState('');
  const [searchQueryB1, setSearchQueryB1] = useState('');
  const [searchQueryB2, setSearchQueryB2] = useState('');

  const [filteredAttendeesA1, setFilteredAttendeesA1] = useState([]);
  const [filteredAttendeesA2, setFilteredAttendeesA2] = useState([]);
  const [filteredAttendeesB1, setFilteredAttendeesB1] = useState([]);
  const [filteredAttendeesB2, setFilteredAttendeesB2] = useState([]);

  // State to control the visibility of search inputs
  const [showSearchA1, setShowSearchA1] = useState(false);
  const [showSearchA2, setShowSearchA2] = useState(false);
  const [showSearchB1, setShowSearchB1] = useState(false);
  const [showSearchB2, setShowSearchB2] = useState(false);

  const [showAllPlayersA1, setShowAllPlayersA1] = useState(false);
  const [showAllPlayersA2, setShowAllPlayersA2] = useState(false);
  const [showAllPlayersB1, setShowAllPlayersB1] = useState(false);
  const [showAllPlayersB2, setShowAllPlayersB2] = useState(false);

  useEffect(() => {
    fetchAttendees();
    fetchCourts()
  }, []);

  useEffect(() => {
    setFilteredAttendeesA1(
      searchQueryA1 === ''
         ? attendees :
         attendees.filter(att =>
            att.player.name.toLowerCase().includes(searchQueryA1.toLowerCase()) ||
            att.player.alias.toLowerCase().includes(searchQueryA1.toLowerCase())
      )
    )
  }, [searchQueryA1, attendees]);

  useEffect(() => {
    setFilteredAttendeesA2(
      attendees.filter(att =>
        att.player.name.toLowerCase().includes(searchQueryA2.toLowerCase()) ||
        att.player.alias.toLowerCase().includes(searchQueryA2.toLowerCase())
      )
    );
  }, [searchQueryA2, attendees]);

  useEffect(() => {
    setFilteredAttendeesB1(
      attendees.filter(att =>
        att.player.name.toLowerCase().includes(searchQueryB1.toLowerCase()) ||
        att.player.alias.toLowerCase().includes(searchQueryB1.toLowerCase())
      )
    );
  }, [searchQueryB1, attendees]);

  useEffect(() => {
    setFilteredAttendeesB2(
      attendees.filter(att =>
        att.player.name.toLowerCase().includes(searchQueryB2.toLowerCase()) ||
        att.player.alias.toLowerCase().includes(searchQueryB2.toLowerCase())
      )
    );
  }, [searchQueryB2, attendees]);

  const fetchAttendees = async () => {
    try {
      const token = await SecureStore.getItemAsync('userToken');
      const response = await fetch(`https://apiv2.pbbedahulu.my.id/mabar/day/${dayId}`, {
        method: 'GET',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      });

      const result = await response.json();
      if (result.success) {
        setAttendees(result.data.attendees);

      } else {
        setError(result.message || 'Failed to retrieve attendees data');
      }
    } catch (error) {
      setError('An error occurred while fetching attendees data');
    } finally {
      setLoading(false);
    }
  };

  const fetchCourts = async () => {
    try {
      const token = await SecureStore.getItemAsync('userToken');
      const response = await fetch('https://apiv2.pbbedahulu.my.id/court', {
        method: 'POST',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          page: 1,
          perPage: 100,
          hall_id: eventHallId,
        }),
      });

      const result = await response.json();

      if (result.success) {
        setCourts(result.data);
      } else {
        setError(result.message || 'Failed to retrieve courts data');
      }
    } catch (error) {
      setError('An error occurred while fetching courts data');
    } finally {
      setCourtLoading(false);
    }
  };

  const handleSaveMatch = async () => {
    if (!courtId || !playerIdA1 || !playerIdA2 || !playerIdB1 || !playerIdB2 || !startTime) {
      Alert.alert('Error', 'Please fill in all required fields.');
      return;
    }
    try {

      const token = await SecureStore.getItemAsync('userToken');
      const response = await fetch('https://apiv2.pbbedahulu.my.id/mabar/match/create', {
        method: 'POST',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          open_mabar_day_id: dayId,
          court_id: parseInt(courtId),
          player_id_a1: parseInt(playerIdA1),
          player_level_a1: playerLevelA1,
          player_id_a2: parseInt(playerIdA2),
          player_level_a2: playerLevelA2,
          player_id_b1: parseInt(playerIdB1),
          player_level_b1: playerLevelB1,
          player_id_b2: parseInt(playerIdB2),
          player_level_b2: playerLevelB2,
          start_time: formattedStartTime,
          note: note,
        }),
      });

      const result = await response.json();

      if (result.success) {
        setMatchUpdated(true);
        Alert.alert('Success', 'Match added successfully.');
        navigation.navigate("MatchList", {refresh: true});
      } else {
        Alert.alert('Error', result.message || 'Failed to add match.');
      }
    } catch (error) {
      Alert.alert('Error', 'An error occurred while adding the match.');
    }
  };

  const onChangeTime = (event, selectedTime) => {
    setShowTimePicker(false);
    if (selectedTime) {
      setStartTime(selectedTime); // Update waktu jika pengguna memilih waktu
    }
  };

  const formattedStartTime = useMemo(() => {
    return `${startTime.getHours().toString().padStart(2, '0')}:${startTime.getMinutes()
      .toString()
      .padStart(2, '0')}:${startTime.getSeconds().toString().padStart(2, '0')}`;
  }, [startTime]);


  const handleSelectPlayer = useCallback(
    (playerId, setPlayerId, setPlayerName, setPlayerLevel, setSearchQuery, setShowSearch, setShowAllPlayers) => {
      const selectedPlayer = attendees.find((att) => att.player.id === playerId);
      setPlayerId(playerId);
      setPlayerName(selectedPlayer.player.name);
      setPlayerLevel(selectedPlayer.player.level);
      setSearchQuery('');
      setShowSearch(false);
      setShowAllPlayers(false);
    },
    [attendees]
  );

  if (loading || courtLoading ) {
    return (
      <View style={styles.loadingContainer}>
        <ActivityIndicator size="large" color="#0000ff" />
        <Text>Loading data...</Text>
      </View>
    );
  }

  if (error) {
    return (
      <View style={styles.loadingContainer}>
        <Text style={styles.errorText}>{error}</Text>
      </View>
    );
  }

  return (
    <FlatList
      data={[]}
            keyExtractor={() => "key"}
            ListHeaderComponent={
      <View style={styles.container}>

        <Text style={styles.label}>Court</Text>
        <Picker
          selectedValue={courtId}
          style={styles.input}
          onValueChange={(itemValue) => setCourtId(itemValue)}
        >
       <Picker.Item label="Select Court" value="" />
          {courts.map((court) => (
            <Picker.Item
              key={court.id}
              label={court.name}
              value={court.id}
            />
          ))}
        </Picker>

          {/* Player A1 */}
          <Text style={styles.label}>Player A1 {playerNameA1 !== '' && (
                                                               <Text style={styles.selectedPlayerText}>
                                                                 : {playerNameA1} - Level {playerLevelA1}
                                                               </Text>
                                                             )}</Text>
          {!showSearchA1 ? (
            <TouchableOpacity style={styles.button} onPress={() => setShowSearchA1(true)}>
              <Text style={styles.buttonText}>Search Player A1</Text>
            </TouchableOpacity>          ) : (
            <>
              <TextInput
                style={styles.input}
                placeholder="Search Player A1"
                value={searchQueryA1}
                onChangeText={setSearchQueryA1}
              />
              <PlayerList
                filteredAttendees={filteredAttendeesA1}
                showAllPlayers={showAllPlayersA1}
                setShowAllPlayers={setShowAllPlayersA1}
                handleSelectPlayer={(playerId) =>
                  handleSelectPlayer(playerId, setPlayerIdA1, setPlayerNameA1, setPlayerLevelA1, setSearchQueryA1, setShowSearchA1, setShowAllPlayersA1)
                }
              />
            </>
          )}


          {/* Player A2 */}
          <Text style={styles.label}>Player A2 {playerNameA2 !== '' && (
                                                               <Text style={styles.selectedPlayerText}>
                                                                 : {playerNameA2} - Level {playerLevelA2}
                                                               </Text>
                                                             )}</Text>
          {!showSearchA2 ? (
            <TouchableOpacity style={styles.button} onPress={() => setShowSearchA2(true)}>
              <Text style={styles.buttonText}>Search Player A2</Text>
            </TouchableOpacity>
            ) : (
            <>
              <TextInput
                style={styles.input}
                placeholder="Search Player A2"
                value={searchQueryA2}
                onChangeText={setSearchQueryA2}
              />
              <PlayerList
                filteredAttendees={filteredAttendeesA2}
                showAllPlayers={showAllPlayersA2}
                setShowAllPlayers={setShowAllPlayersA2}
                handleSelectPlayer={(playerId) =>
                  handleSelectPlayer(playerId, setPlayerIdA2, setPlayerNameA2, setPlayerLevelA2, setSearchQueryA2, setShowSearchA2, setShowAllPlayersA2)
                }
              />
            </>
          )}



          {/* Player B1 */}
          <Text style={styles.label}>Player B1 {playerNameB1 !== '' && (
                                                               <Text style={styles.selectedPlayerText}>
                                                                 : {playerNameB1} - Level {playerLevelB1}
                                                               </Text>
                                                             )}</Text>
          {!showSearchB1 ? (
            <TouchableOpacity style={styles.button} onPress={() => setShowSearchB1(true)}>
              <Text style={styles.buttonText}>Search Player B1</Text>
            </TouchableOpacity>          ) : (
            <>
              <TextInput
                style={styles.input}
                placeholder="Search Player B1"
                value={searchQueryB1}
                onChangeText={setSearchQueryB1}
              />
              <PlayerList
                filteredAttendees={filteredAttendeesB1}
                showAllPlayers={showAllPlayersB1}
                setShowAllPlayers={setShowAllPlayersB1}
                handleSelectPlayer={(playerId) =>
                  handleSelectPlayer(playerId, setPlayerIdB1, setPlayerNameB1, setPlayerLevelB1, setSearchQueryB1, setShowSearchB1, setShowAllPlayersB1)
                }
              />
            </>
          )}

          {/* Player B2 */}
          <Text style={styles.label}>Player B2 {playerNameB2 !== '' && (
                                                               <Text style={styles.selectedPlayerText}>
                                                                 : {playerNameB2} - Level {playerLevelB2}
                                                               </Text>
                                                             )}</Text>
          {!showSearchB2 ? (
            <TouchableOpacity style={styles.button} onPress={() => setShowSearchB2(true)}>
              <Text style={styles.buttonText}>Search Player B2</Text>
            </TouchableOpacity>
            ) : (
            <>
              <TextInput
                style={styles.input}
                placeholder="Search Player B2"
                value={searchQueryB2}
                onChangeText={setSearchQueryB2}
              />
              <PlayerList
                filteredAttendees={filteredAttendeesB2}
                showAllPlayers={showAllPlayersB2}
                setShowAllPlayers={setShowAllPlayersB2}
                handleSelectPlayer={(playerId) =>
                  handleSelectPlayer(playerId, setPlayerIdB2, setPlayerNameB2, setPlayerLevelB2, setSearchQueryB2, setShowSearchB2, setShowAllPlayersB2)
                }
              />

            </>
          )}

        <Text style={styles.label}>Start Time {formattedStartTime !== null ? <Text style={styles.timeText}>: {formattedStartTime}</Text> : null}</Text>
        <View>
            <TouchableOpacity style={styles.button} onPress={() => setShowTimePicker(true)}>
              <Text style={styles.buttonText}>Select Start Time</Text>
            </TouchableOpacity>
        </View>
        {showTimePicker && (
          <DateTimePicker
            value={startTime}
            mode="time"
            display="default"
            onChange={onChangeTime}
          />
        )}

      <Text style={styles.label}>Note</Text>
      <TextInput
        style={styles.input}
        value={note}
        onChangeText={setNote}
        placeholder="Enter Note (optional)"
      />

      <Button title="Save Match" onPress={handleSaveMatch} />
    </View>
    }
    />
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
  },
  label: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 4,
    marginTop: 8
  },
  input: {
    borderWidth: 1,
    borderColor: '#ccc',
    padding: 8,
    marginBottom: 16,
    borderRadius: 4,
  },
  selectedPlayerText: {
    fontSize: 16,
    color: '#555',
    marginVertical: 8,
    fontStyle: 'italic'
  },
  timeText: {
    fontSize: 16,
    marginVertical: 8,
    fontWeight: 'normal'
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  errorText: {
    color: 'red',
    fontSize: 16,
  },
  listItem: {
    padding: 10,
    borderBottomWidth: 1,
    borderBottomColor: '#eee',
  },
  searchResultList: {
    marginBottom: 16,
    backgroundColor: '#fff',
    borderWidth: 1,
    borderColor: '#ccc',
    borderRadius: 4,
  },
  buttonText: {
    color: '#fff',
    fontWeight: 'bold',
  },
  clickMoreText: {
    color: 'blue',
    fontWeight: 'bold',
    textAlign: 'center',
  },
  button: {
    backgroundColor: '#555555',
    padding: 12,
    marginVertical: 8,
    borderRadius: 4,
    alignItems: 'center',
  },


});

export default AddMatchScreen;
