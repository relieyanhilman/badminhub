// App.js

import 'react-native-gesture-handler';
import SplashScreen from 'react-native-splash-screen'
import React from 'react';
import { EventProvider } from './EventContext';
import { StatusBar} from 'react-native';
import { gestureHandlerRootHOC } from 'react-native-gesture-handler';
import AppNavigator from './navigation/AppNavigator';

const App = () => {
  return (
   <EventProvider>
    <StatusBar
       barStyle="light-content"  // Ubah ini sesuai kebutuhan: "light-content" atau "dark-content"
       backgroundColor="#6a51ae" // Sesuaikan warna latar belakang status bar
    />
    <AppNavigator />
   </EventProvider>
  );
};

export default gestureHandlerRootHOC(App);
