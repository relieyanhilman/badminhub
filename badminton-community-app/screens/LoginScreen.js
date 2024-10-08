// screens/LoginScreen.js
import React, { useState } from 'react';
import { View, Text, TextInput, Button, StyleSheet, Alert, TouchableOpacity, Linking, Image, Dimensions } from 'react-native';
import * as SecureStore from 'expo-secure-store';
import {Ionicons} from '@expo/vector-icons';

//Mendapatkan lebar layar perangkat
const { width, height } = Dimensions.get('window');


const LoginScreen = ({ navigation }) => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [isPasswordVisible, setPasswordVisible] = useState(false); // State untuk mengontrol visibilitas password

  const togglePasswordVisibility = () => {
    setPasswordVisible(!isPasswordVisible);
  };

  const handleLogin = async () => {
    setLoading(true); // Mengatur state loading
    try {
      const response = await fetch('https://apiv2.pbbedahulu.my.id/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ username, password }),
      });

      const data = await response.json();
      if (response.ok && data.success) {
        await SecureStore.setItemAsync('userToken', data["data"]["token"]);
        navigation.replace('Main');
      } else {
        let errorMessage = 'Invalid credentials';
        if (response.status === 401) {
           data.message? data.message : 'Unauthorized access';
        } else if (response.status >=500){
           errorMessage = 'Server error, please try again later';
        }
        Alert.alert('Login Failed', errorMessage);
      }
    } catch (error) {
      console.log(error)
      Alert.alert('Error', 'Something went wrong. Please try again later.');
    } finally {
      setLoading(false); // Mengatur state loading selesai
    }
  };

  return (
      <View style={styles.container}>
        <View>
            <Image source={require('../assets/images/logo_pb_bedahulu.png')} style={styles.logo} />
        </View>
        <View>
            <Text style={styles.title}>Welcome to BadminHub!</Text>
            <TextInput
              style={styles.input}
              placeholder="Username"
              value={username}
              onChangeText={setUsername}
            />
            <View style={styles.passwordContainer}>
              <TextInput
                style={styles.passwordInput}
                placeholder="Password"
                value={password}
                onChangeText={setPassword}
                secureTextEntry={!isPasswordVisible}
              />
              <TouchableOpacity onPress={togglePasswordVisibility}>
                <Ionicons
                  name={isPasswordVisible ? 'eye-off' : 'eye'}
                  size={24}
                  color="gray"
                />
              </TouchableOpacity>
            </View>
            <Button title={loading ? 'Logging in...' : 'Login'} onPress={handleLogin} disabled={loading} />

            <View style={{ flexDirection: 'row', justifyContent: 'center', marginTop: 16 }}>
              <Text>Don't have an account? </Text>
              <TouchableOpacity
                onPress={() => Linking.openURL('https://badminhub.scriptsweet.my.id/trial')}
              >
                <Text style={{ color: 'blue', textDecorationLine: 'underline' }}>
                  Register here
                </Text>
              </TouchableOpacity>
            </View>
        </View>

      </View>
    );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    justifyContent: 'flex-start',
    paddingHorizontal: 16,
    backgroundColor: '#f2f2f2',
    marginTop: height * 0.06
  },
  logo: {
    height: width * 0.8, // Lebar logo
    resizeMode: 'contain', // Agar logo sesuai dengan ukuran
    alignSelf: 'center', // Untuk memposisikan di tengah
  },
  title: {
    fontSize: 28,
    marginBottom: 20,
    textAlign: 'center',
    fontWeight: 'bold',
    color: '#333',
  },
  input: {
    height: 50, // Menambahkan tinggi yang seragam untuk semua input
    borderColor: 'gray',
    borderWidth: 1,
    padding: 10,
    marginBottom: 16,
    backgroundColor: '#fff',
    borderRadius: 5,
  },
  passwordContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    borderColor: 'gray',
    borderWidth: 1,
    paddingHorizontal: 10,
    backgroundColor: '#fff',
    marginBottom: 16,
    borderRadius: 5,
    height: 50, // Menambahkan tinggi yang seragam untuk password container
  },
  passwordInput: {
    flex: 1,
    height: '100%', // Menambahkan tinggi 100% untuk mengisi seluruh container
    paddingVertical: 0, // Menghilangkan padding vertikal agar sesuai dengan input lainnya
  },
});

  export default LoginScreen;
