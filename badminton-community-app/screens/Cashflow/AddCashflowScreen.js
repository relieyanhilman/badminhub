// Step 1: Import necessary dependencies
import React, { useState } from 'react';
import { View, Text, TextInput, Button, Alert, StyleSheet, TouchableOpacity, ScrollView, KeyboardAvoidingView, Platform} from 'react-native';
import DateTimePicker from '@react-native-community/datetimepicker';
import * as SecureStore from 'expo-secure-store';
import { Picker } from '@react-native-picker/picker';


// Step 2: Initialize states for form fields
const AddCashflowScreen = ({navigation}) => {
  const [type, setType] = useState('');
  const [source, setSource] = useState('');
  const [purpose, setPurpose] = useState('');
  const [paymentMethod, setPaymentMethod] = useState('');
  const [date, setDate] = useState('');
  const [nominal, setNominal] = useState('');
  const [note, setNote] = useState('');

  //state untuk mengelola DatePicker
  const [showDatePicker, setShowDatePicker] = useState(false);

  // Step 3: Define handleSubmit function
  const handleSubmit = async () => {
    // Step 3a: Validate form fields
    if (!type) {
      Alert.alert('Error', 'Type is required');
      return;
    }
    if (type === 'in' && !source) {
      Alert.alert('Error', 'Source is required for "income" type');
      return;
    }
    if (type === 'out' && !purpose) {
      Alert.alert('Error', 'Purpose is required for "expense" type');
      return;
    }
    if (!paymentMethod) {
      Alert.alert('Error', 'Payment method is required');
      return;
    }
    if (!date) {
      Alert.alert('Error', 'Date is required');
      return;
    }
    if (!nominal || isNaN(nominal) || nominal <= 0) {
      Alert.alert('Error', 'Valid nominal amount is required');
      return;
    }
    if (!note) {
      Alert.alert('Error', 'Note is required');
      return;
    }

    try{
      const token = await SecureStore.getItemAsync('userToken');
      if (!token) {
        throw new Error('User token not found');
      }

      const response = await fetch('https://apiv2.pbbedahulu.my.id/cashflow/create', {
        method: 'POST',
        headers: {
            'Authorization': `${token}`,
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            type,
            source,
            purpose,
            payment_method: paymentMethod,
            date,
            nominal: parseFloat(nominal),
            note,
        })
      })

      const data = await response.json();

      if (response.ok) {
        Alert.alert('Success', 'Cashflow data added successfully');
        navigation.navigate('CashflowList')
      } else {
        let errorMessage = data.message || 'Failed to add cashflow data';
        if (response.statusCode === 401) {
          errorMessage = 'Unauthorized access';
          await SecureStore.deleteItemAsync('userToken');
          navigation.replace('Login');
        }
        Alert.alert('Error', errorMessage);
      }
    }catch(err){
        console.log(err)
        Alert.alert('Error', err.message);

    }
  };

  const handleDateChange = (event, selectedDate) => {
    setShowDatePicker(false);
    if (selectedDate) {
        setDate(selectedDate.toISOString().split('T')[0])
    }
  }

  return (
      <KeyboardAvoidingView
        style={{flex: 1}}
        behavior={Platform.OS === 'ios' ? 'padding' : undefined}
        keyboardVerticalOffset={Platform.OS === 'ios' ? 100 : 0}
      >
        <ScrollView contentContainerStyle={styles.scrollContainer}>
            <View style={styles.container}>
              {/* Step 5a: Select Type */}
              <Text style={styles.label}>Type:</Text>
              <Picker
                selectedValue={type}
                onValueChange={(itemValue) => setType(itemValue)}
                style={styles.picker}
              >
                <Picker.Item label="Select Type" value="" />
                <Picker.Item label="Income" value="in" />
                <Picker.Item label="Expense" value="out" />
              </Picker>

              <Text style={styles.label}>Source: </Text>
              <TextInput
                value={source}
                onChangeText={(text) => setSource(text)}
                placeholder="Enter Source"
                style={styles.input}
              />

              <Text style={styles.label}>Purpose: </Text>
              <TextInput
                value={purpose}
                onChangeText={(text) => setPurpose(text)}
                placeholder="Enter Purpose"
                style={styles.input}
              />

              {/* Step 5d: Payment Method */}
              <Text style={styles.label}>Payment Method:</Text>
              <Picker
                selectedValue={paymentMethod}
                onValueChange={(itemValue) => setPaymentMethod(itemValue)}
                style={styles.picker}
              >
                <Picker.Item label="Select Payment Method" value="" />
                <Picker.Item label="Cash" value="Cash" />
                <Picker.Item label="Bank Transfer" value="Bank Transfer" />
                <Picker.Item label="QRIS" value="QRIS" />
              </Picker>

              {/* Step 5e: Date Picker */}
              <Text style={styles.label}>Date</Text>
              <TouchableOpacity onPress={() => setShowDatePicker(true)}>
                <TextInput
                  style={styles.input}
                  placeholder="YYYY-MM-DD"
                  value={date}
                  editable={false}
                />
              </TouchableOpacity>
              {showDatePicker && (
                <DateTimePicker
                    value={new Date()}
                    mode="date"
                    display="default"
                    onChange={handleDateChange}
                />
              )}

              {/* Step 5f: Nominal */}
              <Text style={styles.label}>Nominal:</Text>
              <TextInput
                value={nominal}
                onChangeText={(text) => setNominal(text)}
                keyboardType="numeric"
                placeholder="Enter Nominal"
                style={styles.input}
              />

              {/* Step 5g: Note */}
              <Text style={styles.label}>Note:</Text>
              <TextInput
                style={styles.input}
                value={note}
                onChangeText={(text) => setNote(text)}
                placeholder="Enter Note"
                multiline
              />

              {/* Step 6: Submit Button */}
              <View style={styles.buttonContainer}>
                <TouchableOpacity onPress={handleSubmit} style={styles.submitButton}>
                    <Text style={styles.submitButtonText}>ADD CASHFLOW</Text>
                </TouchableOpacity>
              </View>
            </View>
        </ScrollView>
      </KeyboardAvoidingView>
  );
};

const styles = StyleSheet.create({
  scrollContainer: {
    flexGrow: 1,
  },
  container: {
    flex: 1,
    padding: 16,
    backgroundColor: '#f5f5f5', // Warna latar belakang yang sama dengan EventPlayerScreen
  },
  label: {
    fontSize: 16,
    fontWeight: 'bold',
    marginVertical: 8,
  },
  picker: {
    height: 50,
    borderColor: 'gray',
    borderWidth: 1,
    backgroundColor: '#fff',
    borderRadius: 5,
  },
  input: {
    height: 50,
    borderColor: 'gray',
    borderWidth: 1,
    paddingHorizontal: 10,
    backgroundColor: '#fff',
    borderRadius: 5,
  },
  buttonContainer: {
    marginTop: 20,
    alignItems: 'center',
  },
  submitButton: {
    backgroundColor: '#007BFF',
    paddingVertical: 15,
    paddingHorizontal: 20,
    borderRadius: 5,
    alignSelf: 'stretch'
  },
  submitButtonText: {
    color: '#fff',
    fontWeight: 'bold',
    fontSize: 16,
    textAlign: 'center'
  },
});

export default AddCashflowScreen;
