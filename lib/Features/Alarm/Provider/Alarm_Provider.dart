import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sofvence_task/Features/Alarm/Screen/Alarm_Model.dart';


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AlarmProvider extends ChangeNotifier {

  final List<AlarmModel> _alarmItems = [];

  List<AlarmModel> get alarmItems => _alarmItems;
  AlarmProvider( ){
    loadAlarms();
  }


  void addAlarm(TimeOfDay pickedTime) async {
    final now = DateTime.now();
    final dt= DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);

    final alarmDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    final newAlarm = AlarmModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      time: DateFormat.jm().format(alarmDateTime),
      date: DateFormat("EEE d MMM yyyy").format(now),
    );

    _alarmItems.add(newAlarm);
    notifyListeners();
  }

  /// Toggle alarm on/off
  void toggleAlarm(int index) {
    _alarmItems[index].isActive = !_alarmItems[index].isActive;
    notifyListeners();
    saveToStorage();
  }

  /// Delete alarm
  void deleteAlarm(int index) {
    _alarmItems.removeAt(index);
    notifyListeners();
    saveToStorage();
  }

  void saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    // Alarm list-ke string-e convert kore save korche
    List<String> alarmStrings = _alarmItems.map((a) => jsonEncode({
      'id': a.id,
      'time': a.time,
      'date': a.date,
      'isActive': a.isActive
    })).toList();

    await prefs.setStringList('saved_alarms', alarmStrings);
  }
  Future<void> loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final alarmStrings = prefs.getStringList('saved_alarms');

    if (alarmStrings != null) {
      _alarmItems.clear();
      _alarmItems.addAll(
        alarmStrings.map((s) {
          final map = jsonDecode(s);
          return AlarmModel(
            id: map['id'],
            time: map['time'],
            date: map['date'],
            isActive: map['isActive'],
          );
        }),
      );
      notifyListeners();
    }
  }
}
