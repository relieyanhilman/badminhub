// navigation/EventTabsNavigator.js
import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';
import EventListScreen from '../screens/Event/EventListScreen';
import AddEventScreen from '../screens/Event/AddEventScreen';
import EditEventScreen from '../screens/Event/EditEventScreen';
import EventDayNavigator from './EventDayNavigator';
import EventDetailNavigator from './EventDetailNavigator';

import AddEventDayScreen from '../screens/EventDay/AddEventDayScreen'
import EditEventDayScreen from '../screens/EventDay/EditEventDayScreen'

import AddMatchScreen from '../screens/Match/AddMatchScreen.js'
import EditMatchScreen from '../screens/Match/EditMatchScreen.js'

import AddPlayerScreen from '../screens/Player/AddPlayerScreen.js'

const Stack = createStackNavigator();

const EventStackNavigator = ({route}) => {
  return (
    <Stack.Navigator>
      <Stack.Screen
        name="EventList"
        component={EventListScreen}
        options={{ title: 'Event List' }}
      />
      <Stack.Screen
        name="AddEvent"
        component={AddEventScreen}
        options={{ title: 'Add Event' }}
      />
      <Stack.Screen
        name="EditEvent"
        component={EditEventScreen}
        options={{ title: 'Edit Event' }}
      />

      <Stack.Screen
        name="EventDay"
        component={EventDayNavigator}
        options={{ title: 'Event Days' }}
      />
      <Stack.Screen
        name="AddEventDay"
        component={AddEventDayScreen}
        options={{ title: 'Add Event Day' }}
      />
      <Stack.Screen
        name="EditEventDay"
        component={EditEventDayScreen}
        options={{ title: 'Edit Event Day' }}
      />

      <Stack.Screen
        name="EventDetail"
        component={EventDetailNavigator}
        options={{ title: 'Event Detail' }}
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
      />
      <Stack.Screen
        name="AddPlayer"
        component={AddPlayerScreen}
        options={{ title: 'Create Player' }}
      />

    </Stack.Navigator>
  );
};

export default EventStackNavigator;
