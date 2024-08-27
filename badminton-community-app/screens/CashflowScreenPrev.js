// screens/CashflowScreen.js
import React, { useState } from 'react';
import { View, Text, FlatList, Button, TextInput, StyleSheet, Modal, TouchableOpacity } from 'react-native';
import DateTimePicker from '@react-native-community/datetimepicker';
import { Picker } from '@react-native-picker/picker';

const CashflowScreen = () => {
  const [cashflow, setCashflow] = useState([
    { id: '1', type: 'in', source: 'Membership Fee', purpose: '', payment_method: 'cash', date: '2023-01-01', nominal: 100, note: 'January' },
    { id: '2', type: 'out', source: '', purpose: 'Court Rental', payment_method: 'bank transfer', date: '2023-01-01', nominal: 50, note: 'January' },
    // Data awal bisa ditambahkan di sini
  ]);

  const [modalVisible, setModalVisible] = useState(false);
  const [confirmDeleteModalVisible, setConfirmDeleteModalVisible] = useState(false);
  const [itemToDelete, setItemToDelete] = useState(null);
  const [editingItem, setEditingItem] = useState(null);
  const [form, setForm] = useState({
    id: '',
    type: 'in',
    source: '',
    purpose: '',
    payment_method: 'cash',
    date: new Date().toISOString().split('T')[0],
    nominal: '',
    note: ''
  });
  const [showDatePicker, setShowDatePicker] = useState(false);

  const openModal = (item = null) => {
    setEditingItem(item);
    setForm(item ? { ...item } : {
      id: '',
      type: 'in',
      source: '',
      purpose: '',
      payment_method: 'cash',
      date: new Date().toISOString().split('T')[0],
      nominal: '',
      note: ''
    });
    setModalVisible(true);
  };

  const closeModal = () => {
    setModalVisible(false);
    setForm({
      id: '',
      type: 'in',
      source: '',
      purpose: '',
      payment_method: 'cash',
      date: new Date().toISOString().split('T')[0],
      nominal: '',
      note: ''
    });
  };

  const handleSave = () => {
    const { id, type, source, purpose, payment_method, date, nominal, note } = form;

    if (type === 'in' && !source) {
      alert('Source is required for income.');
      return;
    }
    if (type === 'out' && !purpose) {
      alert('Purpose is required for expense.');
      return;
    }
    if (!payment_method || !date || !nominal || !note) {
      alert('All fields are required.');
      return;
    }

    if (editingItem) {
      // Update existing item
      setCashflow(cashflow.map(item => (item.id === editingItem.id ? form : item)));
    } else {
      // Create new item
      setCashflow([...cashflow, { ...form, id: Date.now().toString() }]);
    }
    closeModal();
  };

  const handleDelete = (id) => {
    setCashflow(cashflow.filter(item => item.id !== id));
    closeConfirmDeleteModal();
  };

  const openConfirmDeleteModal = (item) => {
    setItemToDelete(item);
    setConfirmDeleteModalVisible(true);
  };

  const closeConfirmDeleteModal = () => {
    setItemToDelete(null);
    setConfirmDeleteModalVisible(false);
  };

  const renderItem = ({ item }) => (
    <View style={styles.item}>
      <Text>Type: {item.type}</Text>
      <Text>Source: {item.source}</Text>
      <Text>Purpose: {item.purpose}</Text>
      <Text>Payment Method: {item.payment_method}</Text>
      <Text>Date: {item.date}</Text>
      <Text>Nominal: {item.nominal}</Text>
      <Text>Note: {item.note}</Text>
      <View style={styles.itemButtons}>
        <Button title="Edit" onPress={() => openModal(item)} />
        <Button title="Delete" onPress={() => openConfirmDeleteModal(item)} color="red" />
      </View>
    </View>
  );

  const handleDateChange = (event, selectedDate) => {
    const currentDate = selectedDate || new Date(form.date);
    setShowDatePicker(false);
    setForm({ ...form, date: currentDate.toISOString().split('T')[0] });
  };

  return (
    <View style={styles.container}>
      <Button title="Add Cashflow" onPress={() => openModal()} />
      <FlatList
        data={cashflow}
        renderItem={renderItem}
        keyExtractor={item => item.id}
      />
      <Modal visible={modalVisible} animationType="slide">
        <View style={styles.modalContent}>
          <Picker
            selectedValue={form.type}
            onValueChange={(itemValue) => setForm({ ...form, type: itemValue })}
            style={styles.input}
          >
            <Picker.Item label="Income" value="in" />
            <Picker.Item label="Expense" value="out" />
          </Picker>
          <TextInput
            placeholder="Source"
            value={form.source}
            onChangeText={(text) => setForm({ ...form, source: text })}
            style={styles.input}
          />
          <TextInput
            placeholder="Purpose"
            value={form.purpose}
            onChangeText={(text) => setForm({ ...form, purpose: text })}
            style={styles.input}
          />
          <Picker
            selectedValue={form.payment_method}
            onValueChange={(itemValue) => setForm({ ...form, payment_method: itemValue })}
            style={styles.input}
          >
            <Picker.Item label="Cash" value="cash" />
            <Picker.Item label="Bank Transfer" value="bank transfer" />
            <Picker.Item label="QRIS" value="QRIS" />
          </Picker>
          <TouchableOpacity onPress={() => setShowDatePicker(true)}>
            <TextInput
              placeholder="Date"
              value={form.date}
              editable={false}
              style={styles.input}
            />
          </TouchableOpacity>
          {showDatePicker && (
            <DateTimePicker
              value={new Date(form.date)}
              mode="date"
              display="default"
              onChange={handleDateChange}
            />
          )}
          <TextInput
            placeholder="Nominal"
            value={form.nominal}
            onChangeText={(text) => setForm({ ...form, nominal: text })}
            keyboardType="numeric"
            style={styles.input}
          />
          <TextInput
            placeholder="Note"
            value={form.note}
            onChangeText={(text) => setForm({ ...form, note: text })}
            style={styles.input}
          />
          <Button title="Save" onPress={handleSave} />
          <TouchableOpacity onPress={closeModal} style={styles.closeButton}>
            <Text style={styles.closeButtonText}>Cancel</Text>
          </TouchableOpacity>
        </View>
      </Modal>

      {/* Modal Konfirmasi Delete */}
      <Modal visible={confirmDeleteModalVisible} transparent={true} animationType="slide">
        <View style={styles.confirmModal}>
          <View style={styles.confirmModalContent}>
            <Text>Are you sure you want to delete this item?</Text>
            <View style={styles.confirmModalButtons}>
              <Button title="Cancel" onPress={closeConfirmDeleteModal} />
              <Button title="Delete" onPress={() => handleDelete(itemToDelete.id)} color="red" />
            </View>
          </View>
        </View>
      </Modal>
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
  itemButtons: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  modalContent: {
    flex: 1,
    justifyContent: 'center',
    padding: 16,
  },
  input: {
    height: 40,
    borderColor: 'gray',
    borderWidth: 1,
    marginBottom: 12,
    padding: 8,
  },
  closeButton: {
    marginTop: 16,
    alignItems: 'center',
  },
  closeButtonText: {
    color: 'red',
  },
  confirmModal: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'rgba(0,0,0,0.5)',
  },
  confirmModalContent: {
    backgroundColor: 'white',
    padding: 20,
    borderRadius: 10,
    width: '80%',
  },
  confirmModalButtons: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginTop: 20,
  },
});

export default CashflowScreen;
