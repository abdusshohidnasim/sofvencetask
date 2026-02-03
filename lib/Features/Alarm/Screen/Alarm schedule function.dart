import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../../main.dart';
class NotificationService {

  static Future<void> scheduleAlarm(int id, DateTime dateTime) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: 'Alarm',
      body: 'Time to wake up!',
      scheduledDate: tz.TZDateTime.from(dateTime, tz.local),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_channel',
          'Alarm Channel',
          channelDescription: 'Alarm notification',
          importance: Importance.max,
          priority: Priority.high,
          fullScreenIntent: true,
          category: AndroidNotificationCategory.alarm,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('alarm'),
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static Future<void> cancelAlarm(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id: id);
  }
}