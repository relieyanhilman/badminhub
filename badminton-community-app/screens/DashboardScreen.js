// screens/DashboardScreen.js
import React, { useEffect, useState } from 'react';
import { View, Text, Image, StyleSheet, ActivityIndicator, Alert , Button} from 'react-native';
import * as SecureStore from 'expo-secure-store';

const DashboardScreen = () => {
  const [communityInfo, setCommunityInfo] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchCommunityInfo = async () => {
    setLoading(true);
    setError(null);

      try {
        const token = await SecureStore.getItemAsync('userToken');
        if (!token) {
          throw new Error('User token not found');
        }

        const response = await fetch('https://api.pbbedahulu.my.id/profile', {
          method: 'GET',
          headers: {
            'Authorization': `${token}`,
            'Content-Type': 'application/json',
          },
        });

        const data = await response.json();
        if (response.ok) {
          const dataKomunitas = data["data"]["community"]
          setCommunityInfo(dataKomunitas);
        } else if (response.status === 401) {
          // Token tidak valid atau expired
          await SecureStore.deleteItemAsync('userToken');
          Alert.alert('Session Expired', 'Your session has expired. Please log in again.', [
            { text: 'OK', onPress: () => navigation.replace('Login') },
          ]);
        } else {
          setError(data.message || 'Failed to fetch community information');
        }
      } catch (err) {
        console.log(err);
        setError(err.message || 'An error occurred while fetching data');
      } finally {
        setLoading(false);
      }
    };

  useEffect(() => {
    fetchCommunityInfo();
  }, []);

  if (loading) {
    return (
      <View style={styles.container}>
        <ActivityIndicator size="large" color="#0000ff" />
      </View>
    );
  }

  if (error) {
    return (
      <View style={styles.container}>
        <Text style={styles.errorText}>{error}</Text>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <Text style={styles.name}>{communityInfo?.name}</Text>
      <Text style={styles.address}>{communityInfo?.address}</Text>
      <Text style={styles.contact}>Contact: {communityInfo?.contact}</Text>

      <Text style={styles.socialMediaTitle}>Social Media:</Text>
      <Text style={styles.socialMedia}>Instagram: {communityInfo?.instagram}</Text>
      <Text style={styles.socialMedia}>TikTok: {communityInfo?.tiktok}</Text>
      <Text style={styles.socialMedia}>Email: {communityInfo?.email}</Text>
      <Text style={styles.socialMedia}>Website: {communityInfo?.website}</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    padding: 16,
    backgroundColor: '#f2f2f2',
  },
  name: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 8,
  },
  address: {
    fontSize: 16,
    color: '#666',
    marginBottom: 8,
    textAlign: 'center',
  },
  contact: {
    fontSize: 16,
    color: '#333',
    marginBottom: 16,
  },
  socialMediaTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 8,
  },
  socialMedia: {
    fontSize: 16,
    color: '#333',
    marginBottom: 4,
  },
  errorText: {
    fontSize: 18,
    color: 'red',
  },
});

export default DashboardScreen;
