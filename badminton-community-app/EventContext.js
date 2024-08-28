import React, { createContext, useState, useEffect, useCallback } from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';

export const EventContext = createContext();

export const EventProvider = ({ children }) => {
  const [eventName, setEventName] = useState('');
  const [eventId, setEventId] = useState('');
  const [eventHallId, setEventHallId] = useState('');
  const [shouldRefresh, setShouldRefresh] = useState(false);

  const triggerRefresh = useCallback(() => {
    setShouldRefresh(true);
  }, []);

  const resetRefresh = useCallback(() => {
    setShouldRefresh(false);
  }, []);

  useEffect(() => {
    const loadEvent = async () => {
      try {
        const savedEventName = await AsyncStorage.getItem('eventName');
        const savedEventId = await AsyncStorage.getItem('eventId');
        const savedEventHallId = await AsyncStorage.getItem('eventHallId');

        if (savedEventName) {
          setEventName(savedEventName);
        }
        if (savedEventId) {
          setEventId(parseInt(savedEventId))
        }
        if (savedEventHallId) {
          setEventHallId(parseInt(savedEventHallId))
        }
      } catch (error) {
        console.log('Failed to load event:', error);
      }
    };

    loadEvent();
  }, []);

  const updateEvent = async (id, name, hallId) => {
    try {
      setEventId(id)
      setEventName(name);
      setEventHallId(hallId)
      await AsyncStorage.setItem('eventId', id.toString());
      await AsyncStorage.setItem('eventName', name);
      await AsyncStorage.setItem('eventHallId', hallId.toString());
    } catch (error) {
      console.log('Failed to save event information:', error);
    }
  };

  return (
    <EventContext.Provider value={{ eventId, eventName, eventHallId, updateEvent, shouldRefresh, triggerRefresh, resetRefresh }}>
      {children}
    </EventContext.Provider>
  );
};
