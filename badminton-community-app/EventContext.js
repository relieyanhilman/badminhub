import React, { createContext, useState, useEffect } from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';

export const EventContext = createContext();

export const EventProvider = ({ children }) => {
  const [eventName, setEventName] = useState('');
  const [eventId, setEventId] = useState('');

  useEffect(() => {
    const loadEvent = async () => {
      try {
        const savedEventName = await AsyncStorage.getItem('eventName');
        const savedEventId = await AsyncStorage.getItem('eventId');
        if (savedEventName) {
          setEventName(savedEventName);
        }
        if (savedEventId) {
          setEventId(parseInt(savedEventId))
        }
      } catch (error) {
        console.log('Failed to load event:', error);
      }
    };

    loadEvent();
  }, []);

  const updateEvent = async (id, name) => {
    try {
      setEventId(id)
      setEventName(name);
      await AsyncStorage.setItem('eventId', id.toString());
      await AsyncStorage.setItem('eventName', name);
    } catch (error) {
      console.log('Failed to save event information:', error);
    }
  };

  return (
    <EventContext.Provider value={{ eventId, eventName, updateEvent }}>
      {children}
    </EventContext.Provider>
  );
};
