// screens/CashflowScreen.js
import React, { useState, useEffect } from 'react';
import { View, Text, FlatList, ActivityIndicator, Button, TextInput, StyleSheet, TouchableOpacity } from 'react-native';
import DateTimePicker from '@react-native-community/datetimepicker';
import { Picker } from '@react-native-picker/picker';
import * as SecureStore from 'expo-secure-store';

const CashflowScreen = () => {
  const [cashflow, setCashflow] = useState([]);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedType, setSelectedType] = useState('');

  useEffect(() => {
    fetchCashflow();
  }, [])

  const fetchCashflow = async (page = 1, perPage = 10, search = '', type = '') => {
    if (page > totalPages && page !== 1) return; // Stop fetching if we're past the last page

    if (page === 1) {
      setLoading(true);
      setCashflow([]);  // Reset cashflows on new search
    } else {
      setLoadingMore(true);
    }

    try{
      const token = await SecureStore.getItemAsync('userToken');
      if (!token) {
        throw new Error('User token not found');
      }

      //ambil variabel community_id dari API get profile
      const response = await fetch('https://apiv2.pbbedahulu.my.id/profile', {
        method: 'GET',
        headers: {
            'Authorization': `${token}`,
            'Content-Type': 'application/json',
        },
      });

      const dataCommunityId = await response.json();

      if (response.ok){
        communityId = dataCommunityId.data.community.id

        //fetch list cashflow
        const cashflowResponse = await fetch('https://apiv2.pbbedahulu.my.id/cashflow', {
            method: 'POST',
            headers: {
                'Authorization': `${token}`,
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ page, perPage, search, type })
        })

       const dataCashflowUnstructed = await cashflowResponse.json();

       if(cashflowResponse.ok){
         dataCashflow = dataCashflowUnstructed.data
         const mergedCashflow = page === 1
          ? dataCashflow
          : [...cashflow, ...dataCashflow].filter((v, i, a) => a.findIndex(t => (t.id === v.id)) === i);

         setCashflow(mergedCashflow);
         setTotalPages(dataCashflowUnstructed.pagination.totalPages);
         setCurrentPage(dataCashflowUnstructed.pagination.currentPage);
       } else{
          console.error('Failed to fetch cashflow:', data.message);
       }
      }
    }catch (err) {
      console.error('Error fetching cashflow:', err);
    }finally{
      setLoading(false);
      setLoadingMore(false);
    }
  }

  const handleSearchSubmit = () => {
    setCurrentPage(1);  // Reset page number
    fetchCashflow(1, 10, searchQuery, selectedType);  // Fetch with search query from page 1
  };

  const handleTypeFilter = (type) => {
     setSelectedType(type);  // Set tipe (in atau out)
     setCurrentPage(1);      // Reset halaman saat mengubah filter
     fetchCashflow(1, 10, searchQuery, type);  // Fetch ulang data berdasarkan filter baru
  };

const renderItem = ({ item }) => {
  const isInflow = item.type === 'in'; // Cek apakah transaksi adalah pemasukan
  const itemStyle = [styles.item, isInflow ? styles.inflow : styles.outflow];

  return (
    <View style={itemStyle}>
      {/* Baris Header: Nominal dan Tanggal */}
      <View style={styles.headerRow}>
        <Text style={styles.nominalText}>
          {isInflow ? '+' : '-'} Rp{item.nominal.toLocaleString('id-ID')}
        </Text>
        <Text style={styles.dateText}>{item.date}</Text>
      </View>

      {/* Bagian Detail Transaksi (source, purpose, payment) dalam satu baris vertikal */}
      <View style={styles.itemDetails}>
        <Text style={styles.detailText}>
          <Text style={styles.labelText}>Source: </Text>{item.source || 'N/A'}
        </Text>
        <Text style={styles.detailText}>
          <Text style={styles.labelText}>Purpose: </Text>{item.purpose || 'N/A'}
        </Text>
        <Text style={styles.detailText}>
          <Text style={styles.labelText}>Payment Method: </Text>{item.payment_method}
        </Text>
      </View>

      {/* Catatan */}
      {item.note ? (
        <Text style={styles.detailText}>
          <Text style={styles.labelText}>Note: </Text>{item.note}
        </Text>
      ) : null}
    </View>
  );
};

  return (
    <View style={styles.container}>
      <TextInput
        style={styles.searchInput}
        placeholder="Search by source, payment method, or note..."
        value={searchQuery}
        onChangeText={setSearchQuery}
        onSubmitEditing={handleSearchSubmit}
      />
      <Button title="Add Cashflow" onPress={() => openModal()} />

      <View style={styles.filterContainer}>
       <TouchableOpacity
         style={[styles.filterButton, selectedType === '' && styles.activeFilter]}
         onPress={() => handleTypeFilter('')}
       >
         <Text style={styles.filterText}>All</Text>
       </TouchableOpacity>
       <TouchableOpacity
         style={[styles.filterButton, selectedType === 'in' && styles.activeFilter]}
         onPress={() => handleTypeFilter('in')}
       >
         <Text style={styles.filterText}>In</Text>
       </TouchableOpacity>
       <TouchableOpacity
         style={[styles.filterButton, selectedType === 'out' && styles.activeFilter]}
         onPress={() => handleTypeFilter('out')}
       >
         <Text style={styles.filterText}>Out</Text>
       </TouchableOpacity>
      </View>

      {loading? (
        <ActivityIndicator size="large" color="#0000ff" />
      ) : (
      <FlatList
        data={cashflow}
        renderItem={renderItem}
        keyExtractor={item => item.id}
        onEndReached={() => fetchCashflow(currentPage + 1, 10, searchQuery, selectedType)}
        onEndReachedThreshold={0.5}
        ListFooterComponent={loadingMore ? <ActivityIndicator size="small" color="#0000ff" /> : null}
      />
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
    backgroundColor: '#f7f7f7',
  },
  searchInput: {
    height: 40,
    borderColor: 'gray',
    borderWidth: 1,
    borderRadius: 5,
    paddingHorizontal: 8,
    marginBottom: 16,
  },
  filterContainer: {
     flexDirection: 'row',
     justifyContent: 'flex-start',
     marginBottom: 10,
     marginTop: 5,
     columnGap: 5,
  },
   filterButton: {
     padding: 10,
     borderRadius: 5,
     backgroundColor: '#ccc',
   },
   activeFilter: {
     backgroundColor: '#007bff',  // Sesuaikan warna yang diinginkan
   },
   filterText: {
     color: '#fff',
     fontWeight: 'bold',
   },
  item: {
    backgroundColor: '#fff',
    padding: 16,
    borderRadius: 8,
    marginVertical: 8,
    shadowColor: '#000',
    shadowOpacity: 0.1,
    shadowOffset: { width: 0, height: 2 },
    shadowRadius: 4,
    elevation: 2,
    borderLeftWidth: 5,
  },
  inflow: {
    borderLeftColor: '#4CAF50', // Hijau untuk pemasukan
  },
  outflow: {
    borderLeftColor: '#F44336', // Merah untuk pengeluaran
  },
  headerRow: {
    flexDirection: 'row', // Nominal dan tanggal dalam satu baris
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 8,
  },
  nominalText: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#000',
  },
  dateText: {
    color: '#555',
    fontSize: 14,
  },
  itemDetails: {
    marginTop: 8,
  },
  detailText: {
    color: '#555',
    fontSize: 14,
    marginBottom: 2,
  },
  labelText: {
    fontWeight: 'bold', // Menambahkan teks bold untuk label atribut
  },
});



export default CashflowScreen;
