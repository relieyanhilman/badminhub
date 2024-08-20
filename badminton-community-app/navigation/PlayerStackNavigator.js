// navigation/PlayerStackNavigator.js
import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';
import PlayerListScreen from '../screens/Player/PlayerListScreen';
import AddPlayerScreen from '../screens/Player/AddPlayerScreen';
import EditPlayerScreen from '../screens/Player/EditPlayerScreen';

const Stack = createStackNavigator();

const PlayerStackNavigator = ({route}) => {
  const {dayId} = route.params;
  return (
    <Stack.Navigator>
      <Stack.Screen
        name="PlayerList"
        component={PlayerListScreen}
        options={{ title: 'Player List', headerShown: false  }}
        initialParams={{ dayId }} // Mengirimkan eventId sebagai param ke PlayerListScreen
      />
      <Stack.Screen
        name="AddPlayer"
        component={AddPlayerScreen}
        options={{ title: 'Create Player' }}
      />
      <Stack.Screen
        name="EditPlayer"
        component={EditPlayerScreen}
        options={{ title: 'Edit Player' }}
      />
    </Stack.Navigator>
  );
};

export default PlayerStackNavigator;