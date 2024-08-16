// screens/MatchListScreen.js
import React, {useState, useEffect} from 'react';
import { View, Text, FlatList, Button, StyleSheet, Alert } from 'react-native';

const MatchListScreen = ({ navigation, route }) => {
  const {eventId} = route.params; //menerima eventID (open_mabar_id) dari MatchStackNavigator

  const [matches, setMatches] = useState([
      {
        id: 1,
        open_mabar_day_id: 1,
        court_id: 1,
        player_name_a1: 'John Doe',
        player_level_a1: 'A',
        player_name_a2: 'Jane Smith',
        player_level_a2: 'B',
        player_name_b1: 'Mike Johnson',
        player_level_b1: 'A',
        player_name_b2: 'Emily Davis',
        player_level_b2: 'B',
        start_time: '14:00:00',
        end_time: '15:00:00',
        score: '21-18, 19-21, 21-15',
        shuttlecock_used: 3,
        note: 'Close match!',
      },
      // Tambahkan data match di sini
    ]);

  useEffect(() => {
    if (route.params?.updatedMatch) {
      handleUpdateMatch(route.params.updatedMatch);
    }else if (route.params?.newMatch) {
           handleAddNewMatch(route.params.newMatch);
         }
  }, [route.params?.updatedMatch, route.params?.newMatch]);

  const handleAddMatch = () => {
    matches_length = matches.length
    navigation.navigate('AddMatch', {matches_length});
  };

  const handleEditMatch = (match) => {
    navigation.navigate('EditMatch', {
    match,
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

  const handleDeleteMatch = (matchId) => {
      // Tampilkan konfirmasi sebelum menghapus
      Alert.alert(
        "Delete Match",
        "Are you sure you want to delete this match?",
        [
          {
            text: "Cancel",
            style: "cancel"
          },
          {
            text: "Delete",
            onPress: () => {
              setMatches((prevMatches) =>
                prevMatches.filter((match) => match.id !== matchId)
              );
            },
            style: "destructive"
          }
        ]
      );
    };

  const renderItem = ({ item }) => (
    <View style={styles.item}>
      <Text style={styles.headerText}>Court: {item.court_id}</Text>

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
      <Text style={styles.timeText}>End Time: {item.end_time || 'N/A'}</Text>
      <Text style={styles.scoreText}>Score: {item.score || 'Not Set'}</Text>
      {item.shuttlecock_used && <Text style={styles.text}>Shuttlecocks Used: {item.shuttlecock_used}</Text>}
      {item.note && <Text style={styles.text}>Note: {item.note}</Text>}
      <View style={styles.itemButtons}>
        <Button title="Edit" onPress={() => handleEditMatch(item)} />
        <Button title="Delete" onPress={() => handleDeleteMatch(item.id)} color="red" />
      </View>
    </View>
  );

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

});

export default MatchListScreen;
