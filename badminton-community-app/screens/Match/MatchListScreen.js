// Match/MatchListScreen.js
import React, {useState, useEffect, useCallback} from 'react';
import { useFocusEffect } from '@react-navigation/native';
import { View, Text, FlatList, Button, StyleSheet, Alert, ActivityIndicator, TextInput } from 'react-native';
import * as SecureStore from 'expo-secure-store';

const MatchListScreen = ({ navigation, route }) => {
  const { dayId } = route.params;
  const [matches, setMatches] = useState([]);
  const [courts, setCourts] = useState({});
  const [loading, setLoading] = useState(true); // Menambah state loading
  const [refreshing, setRefreshing] = useState(false); // State for pull to refresh
  const [error, setError] = useState(null); // Menambah state error

  const [totalParticipants, setTotalParticipants] = useState(0); // State for total participants
  const [totalMatches, setTotalMatches] = useState(0); // State for total matches

  //state untuk mendukung search function
  const [searchQuery, setSearchQuery] = useState('')
  const [filteredMatches, setFilteredMatches] = useState([])

  useEffect(() => {
    fetchMatches()
    fetchSummary()
  }, []);

  useEffect(() => {
    applySearchFilter()
  }, [searchQuery, matches])

  useFocusEffect(
      useCallback(() => {
        if (route.params?.refresh) {
          fetchMatches(); // Panggil fungsi fetchMatches saat screen difokuskan kembali
          fetchSummary(); // Refresh total participants and matches

          navigation.setParams({ refresh: false });
        }
      }, [route.params?.refresh])
  );

  const fetchMatches = async () => {
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
            const sortedMatches = result.data.matches.sort((a, b) => {
              const dateA = new Date(`2024-01-01T${a.start_time}`);
              const dateB = new Date(`2024-01-01T${b.start_time}`);
              return dateB - dateA; // Sort by newest start_time first
            });
          setMatches(sortedMatches);

          applySearchFilter(sortedMatches)
        } else {
          setError(result.message || 'Failed to retrieve data');
        }
      } catch (error) {
        setError('An error occurred while fetching matches');
      } finally {
        setLoading(false);
        setRefreshing(false); // Reset refreshing state when data is fetched

      }
    };

  const fetchSummary = async () => {
    try {
      const token = await SecureStore.getItemAsync('userToken');
      const response = await fetch(`https://apiv2.pbbedahulu.my.id/mabar/day/recap/generate`, {
        method: 'POST',
        headers: {
          'Authorization': `${token}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          open_mabar_day_id: dayId,
          note: '',
        }),
      });

      const result = await response.json();
      if (response.ok && result.success) {
        await fetchRecap(dayId); // Fetch recap after generating it
      } else {
        Alert.alert('Error', result.message || 'Failed to regenerate summary');
      }
    } catch (error) {
      Alert.alert('Error', 'An error occurred while regenerate the summary');
    }
  };

  const fetchRecap = async (dayId) => {
    try {

      const token = await SecureStore.getItemAsync('userToken');
      if (!token) {
        throw new Error('User token not found');
      }

      const response = await fetch(`https://apiv2.pbbedahulu.my.id/mabar/day/recap/${dayId}`, {
        method: 'GET',
        headers: {
          'Authorization': `${token}`,
          'Content-Type': 'application/json',
        },
      });

      const data = await response.json();

      if (response.ok && data.success) {
        setTotalParticipants(data.data[0].participant_count_total || 0);
        setTotalMatches(data.data[0].total_matches_count || 0);
      } else {
        Alert.alert('Error', data.message || 'Failed to retrieve summary');
      }
    } catch (error) {
      console.error('Failed to fetch summary:', error);
      Alert.alert('Error', 'An error occurred while retrieve the summary');
    }
  };

  const applySearchFilter = (matchList=matches) => {
    if (!searchQuery){
        setFilteredMatches(matchList)
    }

    const filterResult = [];

    for (const matchItem of matchList){
        if(matchItem.player_name_a1.toLowerCase().includes(searchQuery.toLowerCase()) ||
        matchItem.player_alias_a1.toLowerCase().includes(searchQuery.toLowerCase()) ||
        matchItem.player_name_a2.toLowerCase().includes(searchQuery.toLowerCase()) ||
        matchItem.player_alias_a2.toLowerCase().includes(searchQuery.toLowerCase()) ||
        matchItem.player_name_b1.toLowerCase().includes(searchQuery.toLowerCase()) ||
        matchItem.player_alias_b1.toLowerCase().includes(searchQuery.toLowerCase()) ||
        matchItem.player_name_b2.toLowerCase().includes(searchQuery.toLowerCase()) ||
        matchItem.player_alias_b2.toLowerCase().includes(searchQuery.toLowerCase()) ){
            filterResult.push(matchItem)
        }
    }
    setFilteredMatches(filterResult)
  }

  const handleAddMatch = () => {
    navigation.navigate('AddMatch', {dayId});
  };

  const handleEditMatch = (match) => {
    navigation.navigate('EditMatch', {
    match, dayId
     });
  };

  const handleUpdateMatch = (updatedMatch) => {
    setMatches((prevMatches) =>
      prevMatches.map((match) =>
        match.id === updatedMatch.id ? updatedMatch : match
      )
    );
  };

  const handleAddNewMatch = (newMatch) => {
    setMatches((prevMatches) => [...prevMatches, newMatch]);
  };


  const renderItem = ({ item }) => (
    <View style={styles.item}>
      <Text style={styles.headerText}>{item.court_name}</Text>
      <View style={styles.matchContainer}>
            <View style={styles.teamContainer}>
              <View style={styles.playerContainer}>
                <Text style={styles.playerText}>{item.player_name_a1}</Text>
                <Text style={styles.playerLevel}>Level: {item.player_level_a1}</Text>
              </View>
              <View style={styles.playerContainer}>
                <Text style={styles.playerText}>{item.player_name_a2}</Text>
                <Text style={styles.playerLevel}>Level: {item.player_level_a2}</Text>
              </View>
            </View>

              <Text style={styles.vsText}>VS</Text>

            <View style={styles.teamContainer}>
              <View style={styles.playerContainer}>
                <Text style={styles.playerText}>{item.player_name_b1}</Text>
                <Text style={styles.playerLevel}>Level: {item.player_level_b1}</Text>
              </View>
              <View style={styles.playerContainer}>
                <Text style={styles.playerText}>{item.player_name_b2}</Text>
                <Text style={styles.playerLevel}>Level: {item.player_level_b2}</Text>
              </View>
            </View>
      </View>

      {item.score == null || item.score == "" ? null : (      <View style={styles.vsContainer}>
                                             <Text style={[styles.scoreText, {fontWeight: 'bold'}]}>Final Score</Text>
                                             <Text style={styles.scoreText}>{item.score || 'N/A'}</Text>
                                         </View>)}


      <View style={styles.matchDetailInfoContainer}>
        <View style={styles.timeInfo}>
          {item.start_time !== "" ? <Text style={styles.timeText}>Start Time: {item.start_time}</Text> : null}
          <Text style={styles.text}>End Time: {item.end_time !== null ? item.end_time : "Not Set" }</Text>
        </View>

        <View style={styles.additionalInfo}>
          {item.duration == "0 minutes" ? null : <Text style={styles.text}>Duration: {item.duration}</Text>}
          <Text style={styles.text}>Shuttlecocks Used: {item.shuttlecock_used || item.shuttlecock_used === 0? item.shuttlecock_used : "Not Set"}</Text>
          {item.note ? <Text style={styles.text}>Note: {item.note}</Text> : null}
        </View>
      </View>

      <View style={styles.itemButtons}>
        <Button title="Edit" onPress={() => handleEditMatch(item)} />
      </View>
    </View>
  );

   const onRefresh = () => {
     setRefreshing(true);
     fetchMatches();
     fetchSummary();

   };

  if (loading && !refreshing) {
    return (
      <View style={styles.loadingContainer}>
        <ActivityIndicator size="large" color="#0000ff" />
        <Text>Loading matches...</Text>
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
    <View style={styles.container}>

      <View style={styles.searchContainer}>
        <TextInput
            style={styles.searchInput}
            value={searchQuery}
            onChangeText={(query) => setSearchQuery(query)}
            placeholder="Search match by player name/ alias"
        />
      </View>
      <Button title="Add Match" onPress={handleAddMatch} />
      <View style={styles.summaryContainer}>

        <View style={styles.summarySubContainer}>
            <Text style={[styles.summaryText, {fontWeight: 'bold'}]}>Total Participants</Text>
            <Text style={styles.summaryText}>{totalParticipants}</Text>
        </View>

        <View style={styles.summarySubContainer}>
            <Text style={[styles.summaryText, {fontWeight: 'bold'}]}>Total Matches</Text>
            <Text style={styles.summaryText}>{totalMatches}</Text>
        </View>

      </View>
      <FlatList
        data={filteredMatches}
        renderItem={renderItem}
        keyExtractor={item => item.id.toString()}
        contentContainerStyle={styles.container}
        contentContainerStyle={{ paddingBottom: 16 }} // Menambahkan padding di bagian bawah
        style={{ flex: 1 }} // Memastikan FlatList mengambil seluruh tinggi container
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
  },
  searchContainer: {
    marginBottom: 7
  },
  searchInput: {
    height: 40,
    borderColor: '#ccc',
    borderWidth: 1,
    borderRadius: 5,
    paddingHorizontal: 10,
  },
  summaryContainer: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    padding: 8,
    backgroundColor: 'white', // Warna abu-abu lembut
    borderRadius: 8,
    marginTop: 7,
    marginBottom: 10
  },
  summarySubContainer: {
    alignItems: 'center',
  },
  summaryText: {
    fontSize: 15, // Ukuran font lebih kecil
    color: '#555', // Warna abu-abu gelap untuk teks
  },
  item: {
    backgroundColor: '#f9f9f9',
    padding: 16,
    marginVertical: 8,
    borderRadius: 8,
    borderColor: '#ccc',
    borderWidth: 1,
  },
  itemButtons: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  headerText: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 8,
  },

  matchContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 5,
  },
  teamContainer: {
    flex: 1,
    alignItems: 'center',
  },
  playerContainer: {
    marginBottom: 8,
    alignItems: 'center',
  },
  playerText: {
    fontSize: 16,
    fontWeight: 'bold',
  },
  vsContainer: {
    marginTop: -25,
    marginBottom: 10
  },
  vsText: {
    fontSize: 18,
    fontWeight: 'bold',
    marginHorizontal: 16,
  },
  scoreText: {
    fontSize: 16,
    fontStyle: 'italic',
    alignSelf: 'center',
  },
  matchDetailInfoContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: 12,
  },
  timeInfo: {
    flex: 1,
  },
  additionalInfo: {
    flex: 1,
  },
  timeText: {
    fontSize: 14,
    marginVertical: 4,
  },
  text: {
    fontSize: 14,
    marginVertical: 4,
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
});

export default MatchListScreen;
