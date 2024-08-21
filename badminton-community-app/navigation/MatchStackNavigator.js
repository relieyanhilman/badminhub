// navigation/MatchStackNavigator.js
import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';

import MatchListScreen from '../screens/Match/MatchListScreen';
import AddMatchScreen from '../screens/Match/AddMatchScreen';
import EditMatchScreen from '../screens/Match/EditMatchScreen';

const Stack = createStackNavigator();

const MatchStackNavigator = ({route}) => {
  const {dayId} = route.params;
  return (
    <Stack.Navigator>
      <Stack.Screen
        name="MatchList"
        component={MatchListScreen}
        options={{ title: 'Match List', headerShown: false }} // Menyembunyikan header Stack.Navigator
        initialParams={{ dayId }}
      />
      <Stack.Screen
        name="EditMatch"
        component={EditMatchScreen}
        options={{ title: 'Edit Match' }}
      />
      <Stack.Screen
        name="AddMatch"
        component={AddMatchScreen}
        options={{ title: 'Add New Match' }}
        initialParams={{ dayId }}
      />

    </Stack.Navigator>
  );
};

export default MatchStackNavigator;