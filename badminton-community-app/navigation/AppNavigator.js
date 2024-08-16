// AppNavigator.js
import React, {useRef} from 'react';

import { TouchableOpacity } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import LoginScreen from '../screens/LoginScreen';
import LogoutScreen from '../screens/LogoutScreen'
import DashboardScreen from '../screens/DashboardScreen';
import CashflowScreen from '../screens/CashflowScreen';
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
      })}
  >
    <Tab.Screen name="Dashboard" component={DashboardScreen} options={{ title: 'Dashboard' }} />
    <Tab.Screen name="Cashflow" component={CashflowScreen} options={{ title: 'Cashflow' }}/>
    <Tab.Screen name="Events" component={EventStackNavigator} options={{ title: 'Events', headerShown: false }}/>
    <Tab.Screen name="Logout">
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