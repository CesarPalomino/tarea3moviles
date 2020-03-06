import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:tarea_dos/models/todo_remainder.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Box _tdBox;//referencia a la caja
  @override
  HomeState get initialState => HomeInitialState();
  HomeBloc() {
    // referencia a la box
    _tdBox = Hive.box("Box");
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is OnLoadRemindersEvent) {
      try {
        List<TodoRemainder> _existingReminders = _loadReminders();
        yield LoadedRemindersState(todosList: _existingReminders);
      } on DatabaseDoesNotExist catch (_) {
        yield NoRemindersState();
      } on EmptyDatabase catch (_) {
        yield NoRemindersState();
      }
    }
    if (event is OnAddElementEvent) {
      _saveTodoReminder(event.todoReminder);
      yield NewReminderState(todo: event.todoReminder);
    }
    if (event is OnReminderAddedEvent) {
      yield AwaitingEventsState();
    }
    if (event is OnRemoveElementEvent) {
      _removeTodoReminder(event.removedAtIndex);
    }
  }

  List<TodoRemainder> _loadReminders() {
    // ver si existen datos TodoRemainder en la box y sacarlos como Lista (no es necesario hacer get ni put)
    // debe haber un adapter para que la BD pueda detectar el objeto
    if(_tdBox.isEmpty)throw EmptyDatabase();
    return _tdBox.values.map((dato) => dato as TodoRemainder).toList();//devueleve los datos de la caja en un mapa
    //este mapa lo convierte en una lista similar al comportamiento de un for:each
  }

  void _saveTodoReminder(TodoRemainder todoReminder) {
    // TODO:add item here
    _tdBox.add(todoReminder);
  }

  void _removeTodoReminder(int removedAtIndex) {
    // TODO:delete item here
    _tdBox.deleteAt(removedAtIndex);
  }
}

class DatabaseDoesNotExist implements Exception {}

class EmptyDatabase implements Exception {}
