// navigation/EventDetailNavigator.js
import React, {useContext, useEffect} from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { createMaterialTopTabNavigator } from '@react-navigation/material-top-tabs';
import { createStackNavigator } from '@react-navigation/stack';
import { EventContext } from '../EventContext';

import PlayerStackNavigator from './PlayerStackNavigator.js';
import MatchStackNavigator from './MatchStackNavigator.js';

const Tab = createMaterialTopTabNavigator();
const Stack = createStackNavigator();

export const EventDetailNavigator = ({navigation, route}) => {
  const {dayId, eventDayName} = route.params;
  const {eventName} = useContext(EventContext)

  useEffect(() => {
    navigation.setOptions({
      headerTitle: () => (
        <View style={styles.headerTitleContainer}>
          <Text style={styles.headerTitle} numberOfLines={1} ellipsizeMode="tail">
            {eventName}
          </Text>
          <Text style={styles.headerSubtitle} numberOfLines={1} ellipsizeMode="tail">
            {eventDayName}
          </Text>
        </View>
      ),
    });
  }, [navigation, eventName, eventDayName]);

  return (
    <Tab.Navigator>
      <Tab.Screen
        name="Matches"
        component={MatchStackNavigator}
        options={{ title: 'Matches' }}
        initialParams={{ dayId }} // Mengirimkan eventId sebagai param ke MatchStackNavigator
      />
      <Tab.Screen
        name="Players"
        component={PlayerStackNavigator }
        options={{ title: 'Players' }}
        initialParams={{ dayId }} // Mengirimkan eventId sebagai param ke PlayerListScreen
      />
    </Tab.Navigator>
  );
};

const styles = StyleSheet.create({
  headerTitleContainer: {
    alignItems: 'center',
    justifyContent: 'center',
  },
  headerTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    textAlign: 'center',
  },
  headerSubtitle: {
    fontSize: 14,
    textAlign: 'center',
    color: '#666',
  },
});