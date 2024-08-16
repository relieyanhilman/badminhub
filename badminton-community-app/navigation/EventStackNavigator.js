// navigation/EventTabsNavigator.js
import React from 'react';
import { createMaterialTopTabNavigator } from '@react-navigation/material-top-tabs';
import EventListScreen from '../screens/EventListScreen';
import PlayerListScreen from '../screens/PlayerListScreen';
import MatchListScreen from '../screens/MatchListScreen';

const Tab = createMaterialTopTabNavigator();

const EventTabsNavigator = () => {
  return (
    <Tab.Navigator>
      <Tab.Screen
        name="EventList"
        component={EventListScreen}
        options={{ title: 'Event List' }}
      />
      <Tab.Screen
        name="PlayerList"
        component={PlayerListScreen}
        options={{ title: 'Player List' }}
      />
      <Tab.Screen
        name="MatchList"
        component={MatchListScreen}
        options={{ title: 'Match List' }}
      />
    </Tab.Navigator>
  );
};

//const EventStackScreen = () => (
//  <Stack.Navigator>
//    <Stack.Screen
//      name="EventList"
//      component={EventListScreen}
//      options={{ title: 'Event List' }}
//    />
//    <Stack.Screen
//      name="AddEvent"
//      component={AddEventScreen}
//      options={{ title: 'Add New Event' }}
//    />
//    <Stack.Screen
//      name="EditEvent"
//      component={EditEventScreen}
//      options={{ title: 'Edit Event' }}
//    />
//    <Stack.Screen
//      name="Matches"
//      component={MatchListScreen}
//      options={{ title: 'Match List' }}
//    />
//    <Stack.Screen
//      name="Players"
//      component={PlayerListScreen}
//      options={{ title: 'Player List' }}
//    />
//    <Stack.Screen
//      name="AddMatch"
//      component={AddMatchScreen}
//      options={{ title: 'Add New Match' }}
//    />
//    <Stack.Screen
//      name="AddPlayer"
//      component={AddPlayerScreen}
//      options={{ title: 'Add New Player' }}
//    />
//  </Stack.Navigator>
//);

export default EventTabsNavigator;
