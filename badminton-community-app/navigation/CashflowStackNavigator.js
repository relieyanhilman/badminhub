// Step 1: Import necessary dependencies
import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';
import CashflowListScreen from '../screens/Cashflow/CashflowListScreen';  // Import ListCashflow screen
import AddCashflowScreen from '../screens/Cashflow/AddCashflowScreen';    // Import AddCashflow screen

// Step 2: Initialize Stack Navigator
const Stack = createStackNavigator();

// Step 3: Define CashflowNavigator function
function CashflowNavigator() {
  return (
    <Stack.Navigator initialRouteName="CashflowList">

      <Stack.Screen
        name="CashflowList"
        component={CashflowListScreen}
        options={{ headerTitle: "Cashflow List", headerShown: true }}
      />

      <Stack.Screen
        name="AddCashflow"
        component={AddCashflowScreen}
        options={{ headerTitle: "Add Cashflow", headerShown: true }}
      />

    </Stack.Navigator>
  );
}

export default CashflowNavigator;
