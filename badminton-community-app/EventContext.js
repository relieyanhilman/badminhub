import React, { createContext, useState, useEffect } from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';

export const EventContext = createContext();

export const EventProvider = ({ children }) => {
  const [eventName, setEventName] = useState('');

  useEffect(() => {
    const loadEventName = async () => {
      try {
        const savedEventName = await AsyncStorage.getItem('eventName');
        if (savedEventName) {
          setEventName(savedEventName);
        }
      } catch (error) {
        console.log('Failed to load event name:', error);
      }
    };

    loadEventName();
  }, []);

  const updateEventName = async (name) => {
    try {
      setEventName(name);
      await AsyncStorage.setItem('eventName', name);
    } catch (error) {
      console.log('Failed to save event name:', error);
    }
  };

  return (
    <EventContext.Provider value={{ eventName, updateEventName }}>
      {children}
    </EventContext.Provider>
  );
};
