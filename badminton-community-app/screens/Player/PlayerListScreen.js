// Player/PlayerListScreen.js
import React, {useState, useEffect} from 'react';
import { View, Text, FlatList, Button, StyleSheet, Alert } from 'react-native';

const PlayerListScreen = ({ navigation, route }) => {
  const [players, setPlayers] = useState([
    {
      id: '1',
      name: 'John Doe',
      alias: 'John',
      gender: 'M',
      contact: '123-456-7890',
      level: 'A',
      age_range: '21-30',
      payment_status: 'Paid'
    },
    // Tambahkan data player di sini
  ]);

  useEffect(() => {
    if (route.params?.newPlayer) {
      setPlayers((prevPlayers) => [...prevPlayers, route.params.newPlayer]);
    } else if (route.params?.updatedPlayer) {
        handleUpdatePlayer(route.params.updatedPlayer);
      }
  }, [route.params?.newPlayer, route.params?.updatedPlayer]);

  const handleAddPlayer = () => {
    navigation.navigate('AddPlayer');
  };

  const handleEditPlayer = (player) => {
    navigation.navigate('EditPlayer', { player });
  };

  const handleUpdatePlayer = (updatedPlayer) => {
    setPlayers((prevPlayers) =>
      prevPlayers.map((player) =>
        player.id === updatedPlayer.id ? updatedPlayer : player
      )
    );
  };

  const handleDeletePlayer = (playerId) => {
    Alert.alert(
      "Delete Player",
      "Are you sure you want to delete this player?",
      [
        {
          text: "Cancel",
          style: "cancel"
        },
        {
          text: "Delete",
          onPress: () => {
            setPlayers((prevPlayers) => prevPlayers.filter((player) => player.id !== playerId));
          },
          style: "destructive"
        }
      ]
    );
  };

  const renderItem = ({ item }) => (
    <View style={styles.item}>
      <Text style={styles.nameText}>Name: {item.name} ({item.alias})</Text>
      <Text style={styles.text}>Gender: {item.gender}</Text>
      <Text style={styles.text}>Contact: {item.contact}</Text>
      <Text style={styles.text}>Level: {item.level}</Text>
      <Text style={styles.text}>Age Range: {item.age_range}</Text>
      <Text style={styles.text}>Payment Status: {item.payment_status}</Text>
      <View style={styles.itemButtons}>
        <Button title="Edit" onPress={() => handleEditPlayer(item)} />
        <Button title="Delete" onPress={() => handleDeletePlayer(item.id)} color="red" />
      </View>
    </View>
  );

  return (
    <View style={styles.container}>
      <Button title="Add Player" onPress={handleAddPlayer} />
      <FlatList
        data={players}
        renderItem={renderItem}
        keyExtractor={item => item.id}
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
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#ccc',
  },
  nameText: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 8,
  },
  text: {
    fontSize: 14,
    marginBottom: 4,
  },
  itemButtons: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginTop: 10,
  },
});

export default PlayerListScreen;
