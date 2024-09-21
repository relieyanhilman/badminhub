// AppNavigator.js
import React, {useRef} from 'react';

import { TouchableOpacity } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import Icon from 'react-native-vector-icons/FontAwesome';
import LoginScreen from '../screens/LoginScreen';
import LogoutScreen from '../screens/LogoutScreen'
import DashboardScreen from '../screens/DashboardScreen';
import CashflowStackNavigator from './CashflowStackNavigator';
import EventStackNavigator from './EventStackNavigator';

const Stack = createStackNavigator();
const Tab = createBottomTabNavigator();

const MainTabs = ({route, navigation}) => {
  const lastTabRef = useRef("Dashboard"); // Menyimpan tab terakhir

  const handleTabPress = (e, routeName) => {
    if (routeName !== 'Logout') {
      lastTabRef.current = routeName;
    }
  };

  return (
  <Tab.Navigator
      screenOptions={({ route }) => ({
        tabBarButton: (props) => (
          <TouchableOpacity
            {...props}
            onPress={(e) => {
              handleTabPress(e, route.name);
              props.onPress(e);
            }}
          />
        ),
        tabBarIcon: ({ focused, color, size }) => {
          let iconName;

          // Tentukan ikon yang akan digunakan berdasarkan nama route
          if (route.name === 'Dashboard') {
            iconName = 'home'; // Ikon Home untuk Dashboard
          } else if (route.name === 'Cashflow') {
            iconName = 'dollar'; // Ikon Dollar untuk Cashflow
          } else if (route.name === 'Events') {
            iconName = 'calendar'; // Ikon Calendar untuk Events
          } else if (route.name === 'Logout') {
            iconName = 'sign-out'; // Ikon Sign-out untuk Logout
          }

          // Return ikon dengan menggunakan FontAwesome
          return <Icon name={iconName} size={size} color={color} />;
        },
        tabBarActiveTintColor: '#007bff', // Warna aktif untuk tab yang sedang dipilih
        tabBarInactiveTintColor: 'gray', // Warna tab yang tidak aktif
        tabBarLabelStyle: { fontSize: 12 }, // Gaya teks label pada tab
      })}
  >
    <Tab.Screen name="Dashboard" component={DashboardScreen} options={{ title: 'Dashboard' }} />
    <Tab.Screen name="Cashflow" component={CashflowStackNavigator} options={{ headerShown: false }}/>
    <Tab.Screen name="Events" component={EventStackNavigator} options={{ title: 'Events', headerShown: false }}/>
    <Tab.Screen name="Logout" options={{headerShown: false }}>
       {props => <LogoutScreen {...props} lastTabRef={lastTabRef} />}
    </Tab.Screen>
  </Tab.Navigator>
  );
}

const AppNavigator = () => (
  <NavigationContainer>
    <Stack.Navigator initialRouteName="Login">
      <Stack.Screen name="Login" component={LoginScreen} options={{headerShown: false}}/>
      <Stack.Screen name="Main" component={MainTabs} options={{ headerShown: false }} />
    </Stack.Navigator>
  </NavigationContainer>
);

export default AppNavigator;