// screens/LogoutScreen.js
import React, { useEffect } from 'react';
import { View, Text, StyleSheet, ActivityIndicator, Alert } from 'react-native';
import * as SecureStore from 'expo-secure-store';

const LogoutScreen = ({ navigation, lastTabRef }) => {
  useEffect(() => {
    const unsubscribe = navigation.addListener('focus', () => {
      const confirmLogout = () => {
        Alert.alert(
          'Confirm Logout',
          'Are you sure you want to logout?',
          [
            {
              text: 'Cancel',
              style: 'cancel',
              onPress: () => {
                 navigation.navigate(lastTabRef.current); // Kembali ke screen sebelumnya
              },
            },
            {
              text: 'Logout',
              style: 'destructive',
              onPress: async () => {
                // Hapus token dari SecureStore dan arahkan ke Login
                await SecureStore.deleteItemAsync('userToken');
                navigation.replace('Login');
              },
            },
          ],
          { cancelable: false }
        );
      };

      confirmLogout();
    });

    return unsubscribe; // Bersihkan listener ketika komponen dibongkar
  }, [navigation, lastTabRef]);

  return (
    <View style={styles.container}>
      <Text>Logging out...</Text>
      <ActivityIndicator size="large" color="#0000ff" />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
});

export default LogoutScreen;
