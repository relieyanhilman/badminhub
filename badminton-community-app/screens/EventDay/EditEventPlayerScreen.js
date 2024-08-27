// file path: src/screens/CashflowScreen.js

import React from 'react';
import { View, Text, StyleSheet, Image } from 'react-native';

const EditEventPlayerScreen = () => {
  return (
    <View style={styles.container}>
      <Text style={styles.text}>COMING SOON</Text>
      <Text style={styles.subtext}>Fitur ini masih dalam tahap pengembangan. Stay tuned!</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#fff', // Sesuaikan dengan warna tema aplikasi
  },
  image: {
    width: 200,
    height: 200,
    marginBottom: 20,
  },
  text: {
    fontSize: 32,
    fontWeight: 'bold',
    color: '#333', // Sesuaikan dengan warna teks
    marginBottom: 10,
  },
  subtext: {
    fontSize: 18,
    color: '#666', // Sesuaikan dengan warna teks
    textAlign: 'center',
    paddingHorizontal: 20,
  },
});

export default EditEventPlayerScreen;
