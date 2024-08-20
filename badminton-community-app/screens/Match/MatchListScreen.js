// Match/MatchListScreen.js
import React, {useState, useEffect, useCallback} from 'react';
import { useFocusEffect } from '@react-navigation/native';
import { View, Text, FlatList, Button, StyleSheet, Alert, ActivityIndicator } from 'react-native';
import * as SecureStore from 'expo-secure-store';

const MatchListScreen = ({ navigation, route }) => {
  const { dayId } = route.params;
  const [matches, setMatches] = useState([]);
  const [courts, setCourts] = useState({});
  const [loading, setLoading] = useState(true); // Menambah state loading
  const [error, setError] = useState(null); // Menambah state error

  useEffect(() => {
    fetchMatches()
  }, []);

  useFocusEffect(
      useCallback(() => {
        if (route.params?.refresh) {
          fetchMatches(); // Panggil fungsi fetchMatches saat screen difokuskan kembali
          navigation.setParams({ refresh: false });
        }
      }, [route.params?.refresh])
  );

    const fetchMatches = async () => {
      try {
      const token = await SecureStore.getItemAsync('userToken');
        const response = await fetch(`https://api.pbbedahulu.my.id/mabar/day/${dayId}`, {
          method: 'GET',
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json',
          },
        });

        const result = await response.json();

        if (result.success) {
          setMatches(result.data.matches);
        } else {
          setError(result.message || 'Failed to retrieve data');
        }
      } catch (error) {
        setError('An error occurred while fetching matches');
      } finally {
        setLoading(false);
      }
    };


  const handleAddMatch = () => {
    matches_length = matches.length
    navigation.navigate('AddMatch', {matches_length});
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

      <Text style={styles.timeText}>Start Time: {item.start_time}</Text>
      {item.end_time !== "00:00:00" && <Text style={styles.text}>End Time: {item.end_time}</Text>}

      {item.end_time !== "00:00:00" && <Text style={styles.text}>Duration: {item.duration}</Text>}
      <Text style={styles.scoreText}>Score: {item.score || 'Not Set'}</Text>
      {item.shuttlecock_used && <Text style={styles.text}>Shuttlecocks Used: {item.shuttlecock_used}</Text>}
      {item.note && <Text style={styles.text}>Note: {item.note}</Text>}
      <View style={styles.itemButtons}>
        <Button title="Edit" onPress={() => handleEditMatch(item)} />
      </View>
    </View>
  );

  if (loading) {
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
      <Button title="Add Match" onPress={handleAddMatch} />
      <FlatList
        data={matches}
        renderItem={renderItem}
        keyExtractor={item => item.id.toString()}
        contentContainerStyle={styles.container}
        style={{ flex: 1 }} // Memastikan FlatList mengambil seluruh tinggi container
        contentContainerStyle={{ paddingBottom: 16 }} // Menambahkan padding di bagian bawah
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
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
    marginBottom: 12,
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
  vsText: {
    fontSize: 18,
    fontWeight: 'bold',
    marginHorizontal: 16,
  },
  timeText: {
    fontSize: 14,
    marginVertical: 4,
  },
  scoreText: {
    fontSize: 16,
    fontWeight: 'bold',
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
