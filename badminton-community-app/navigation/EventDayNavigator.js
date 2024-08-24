// navigation/EventDetailNavigator.js
import React, {useContext, useEffect} from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { createMaterialTopTabNavigator } from '@react-navigation/material-top-tabs';
import { createStackNavigator } from '@react-navigation/stack';
import { EventContext } from '../EventContext';

import EventDayListScreen from '../screens/EventDay/EventDayListScreen';
import EventPlayerScreen from '../screens/EventDay/EventPlayerScreen';

const Tab = createMaterialTopTabNavigator();
const Stack = createStackNavigator();

const EventDayNavigator = ({navigation, route}) => {
  const {eventName} = useContext(EventContext)

  useEffect(() => {
    navigation.setOptions({
      headerTitle: () => (
        <View style={styles.headerTitleContainer}>
          <Text style={styles.headerTitle} numberOfLines={1} ellipsizeMode="tail">
            {eventName}
          </Text>
        </View>
      ),
    });
  }, [navigation, eventName]);

  return (
    <Tab.Navigator>
      <Tab.Screen
        name="EventDayList"
        component={EventDayListScreen}
        options={{ title: 'Event Days' }}
      />
      <Tab.Screen
        name="EventPlayers"
        component={EventPlayerScreen }
        options={{ title: 'Event Players' }}
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
});

export default EventDayNavigator;