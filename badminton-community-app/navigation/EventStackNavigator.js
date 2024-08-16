// navigation/EventTabsNavigator.js
import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';
import EventListScreen from '../screens/Event/EventListScreen';
import AddEventScreen from '../screens/Event/AddEventScreen';
import EditEventScreen from '../screens/Event/EditEventScreen';
import {EventDetailNavigator} from './EventDetailNavigator';
import EventDayListScreen from '../screens/EventDay/EventDayListScreen';
import AddEventDayScreen from '../screens/EventDay/AddEventDayScreen';

const Stack = createStackNavigator();

const EventStackNavigator = () => {
  return (
    <Stack.Navigator>
      <Stack.Screen
        name="EventList"
        component={EventListScreen}
        options={{ title: 'Event List' }}
      />
      <Stack.Screen
        name="EventDayList"
        component={EventDayListScreen}
        options={{ title: 'Event Days' }}
      />
      <Stack.Screen
        name="AddEventDay"
        component={AddEventDayScreen}
        options={{ title: 'Add Event Day' }}
      />
      <Stack.Screen
        name="EventDetail"
        component={EventDetailNavigator}
        options={{ title: 'Event Detail' }}
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
    </Stack.Navigator>
  );
};

export default EventStackNavigator;
