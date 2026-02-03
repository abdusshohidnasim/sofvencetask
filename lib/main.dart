import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:sofvence_task/Features/Alarm/Provider/Alarm_Provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'Features/Onboarding/Provider/onbording_provider.dart';
import 'Features/Onboarding/Screen/onboarding_screens.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(settings: initializationSettings);
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => OnboardingProvider()),
          ChangeNotifierProvider(create: (context) => AlarmProvider()),
        ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Onbording(),
    );
  }
}
