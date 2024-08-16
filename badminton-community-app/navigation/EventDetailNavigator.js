// navigation/EventDetailNavigator.js
import React from 'react';
import { createMaterialTopTabNavigator } from '@react-navigation/material-top-tabs';
import { createStackNavigator } from '@react-navigation/stack';

import PlayerStackNavigator from './PlayerStackNavigator.js';
import MatchStackNavigator from './MatchStackNavigator.js';

const Tab = createMaterialTopTabNavigator();
const Stack = createStackNavigator();

export const EventDetailNavigator = ({route}) => {
  const {eventId} = route.params; // Mengambil eventId yang dikirim dari EventListScreen

  return (
    <Tab.Navigator>
      <Tab.Screen
        name="Matches"
        component={MatchStackNavigator}
        options={{ title: 'Matches' }}
        initialParams={{ eventId }} // Mengirimkan eventId sebagai param ke MatchStackNavigator
      />
      <Tab.Screen
        name="Players"
        component={PlayerStackNavigator }
        options={{ title: 'Players' }}
        initialParams={{ eventId }} // Mengirimkan eventId sebagai param ke PlayerListScreen
      />
    </Tab.Navigator>
  );
};