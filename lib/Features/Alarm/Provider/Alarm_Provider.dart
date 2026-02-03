






import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sofvence_task/Features/Alarm/Screen/Alarm_Model.dart';

import 'package:intl/intl.dart';

import '../Screen/Alarm schedule function.dart';





class AlarmProvider extends ChangeNotifier {
  final List<AlarmModel> _alarmItems = [];
  List<AlarmModel> get alarmItems => _alarmItems;

  AlarmProvider() {
    loadAlarms();
  }

  /// Generate unique 32-bit safe ID
  int generateId() => DateTime.now().millisecondsSinceEpoch % 2147483647;

  /// Add new alarm
  void addAlarm(TimeOfDay pickedTime, BuildContext context) async {
    final now = DateTime.now();

    DateTime alarmDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    // If picked time already passed today, schedule for tomorrow
    if (alarmDateTime.isBefore(now)) {
      alarmDateTime = alarmDateTime.add(Duration(days: 1));
    }

    final id = generateId();

    // Schedule notification
    await NotificationService.scheduleAlarm(id, alarmDateTime);

    // Format time using context (required for TimeOfDay.format)
    final timeString = pickedTime.format(context);

    final newAlarm = AlarmModel(
      id: id.toString(),
      time: timeString,
      date: DateFormat("EEE d MMM yyyy").format(alarmDateTime),
      isActive: true,
    );

    _alarmItems.add(newAlarm);
    notifyListeners();
    saveToStorage();
  }

  /// Toggle alarm ON/OFF
  void toggleAlarm(int index) async {
    final alarm = _alarmItems[index];
    final id = int.parse(alarm.id);

    alarm.isActive = !alarm.isActive;

    if (alarm.isActive) {
      // Parse time string safely
      final parts = alarm.time.split(RegExp(r'[: ]')); // "10:30 AM" => ["10","30","AM"]
      int hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      final isPM = parts[2].toUpperCase() == "PM";

      if (isPM && hour != 12) hour += 12;
      if (!isPM && hour == 12) hour = 0;

      final now = DateTime.now();
      DateTime dateTime = DateTime(now.year, now.month, now.day, hour, minute);
      if (dateTime.isBefore(now)) dateTime = dateTime.add(Duration(days: 1));

      await NotificationService.scheduleAlarm(id, dateTime);
    } else {
      await NotificationService.cancelAlarm(id);
    }

    notifyListeners();
    saveToStorage();
  }

  /// Delete alarm
  void deleteAlarm(int index) async {
    final alarm = _alarmItems[index];
    final id = int.parse(alarm.id);

    await NotificationService.cancelAlarm(id);

    _alarmItems.removeAt(index);
    notifyListeners();
    saveToStorage();
  }

  /// Save alarms to SharedPreferences
  void saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final alarmStrings = _alarmItems.map((a) => jsonEncode({
      'id': a.id,
      'time': a.time,
      'date': a.date,
      'isActive': a.isActive,
    })).toList();
    await prefs.setStringList('saved_alarms', alarmStrings);
  }

  /// Load alarms from SharedPreferences
  Future<void> loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final alarmStrings = prefs.getStringList('saved_alarms');

    if (alarmStrings != null) {
      _alarmItems.clear();
      _alarmItems.addAll(alarmStrings.map((s) {
        final map = jsonDecode(s);
        return AlarmModel(
          id: map['id'],
          time: map['time'],
          date: map['date'],
          isActive: map['isActive'] ?? true,
        );
      }));
      notifyListeners();
    }
  }
}















//
// class AlarmProvider extends ChangeNotifier {
//
//   final List<AlarmModel> _alarmItems = [];
//
//   List<AlarmModel> get alarmItems => _alarmItems;
//   AlarmProvider( ){
//     loadAlarms();
//   }
//
//
//   void addAlarm(TimeOfDay pickedTime) async {
//     final now = DateTime.now();
//     final dt= DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
//
//     final alarmDateTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       pickedTime.hour,
//       pickedTime.minute,
//     );
//     final id = DateTime.now().millisecondsSinceEpoch;
//     await NotificationService.scheduleAlarm(id, alarmDateTime);
//
//     final newAlarm = AlarmModel(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       time: DateFormat.jm().format(alarmDateTime),
//       date: DateFormat("EEE d MMM yyyy").format(now),
//     );
//
//     _alarmItems.add(newAlarm);
//     notifyListeners();
//     saveToStorage();
//   }
//
//   /// Toggle alarm on/off
//   void toggleAlarm(int index) async{
//     final alarm = _alarmItems[index];
//     final id = int.parse(alarm.id);
//
//     _alarmItems[index].isActive = !_alarmItems[index].isActive;
//     if (alarm.isActive) {
//       // আবার চালু → reschedule
//       final time = DateFormat.jm().parse(alarm.time);
//       final now = DateTime.now();
//
//       final dateTime = DateTime(
//         now.year,
//         now.month,
//         now.day,
//         time.hour,
//         time.minute,
//       );
//
//       await NotificationService.scheduleAlarm(id, dateTime);
//     } else {
//       // বন্ধ → cancel
//       await NotificationService.cancelAlarm(id);
//     }
//     notifyListeners();
//     saveToStorage();
//   }
//
//   /// Delete alarm
//   void deleteAlarm(int index) {
//     _alarmItems.removeAt(index);
//     notifyListeners();
//     saveToStorage();
//   }
//
//   void saveToStorage() async {
//     final prefs = await SharedPreferences.getInstance();
//     // Alarm list-ke string-e convert kore save korche
//     List<String> alarmStrings = _alarmItems.map((a) => jsonEncode({
//       'id': a.id,
//       'time': a.time,
//       'date': a.date,
//       'isActive': a.isActive
//     })).toList();
//
//     await prefs.setStringList('saved_alarms', alarmStrings);
//   }
//   Future<void> loadAlarms() async {
//     final prefs = await SharedPreferences.getInstance();
//     final alarmStrings = prefs.getStringList('saved_alarms');
//
//     if (alarmStrings != null) {
//       _alarmItems.clear();
//       _alarmItems.addAll(
//         alarmStrings.map((s) {
//           final map = jsonDecode(s);
//           return AlarmModel(
//             id: map['id'],
//             time: map['time'],
//             date: map['date'],
//             isActive: map['isActive'],
//           );
//         }),
//       );
//       notifyListeners();
//     }
//   }
// }
