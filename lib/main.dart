import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sofvence_task/Features/Alarm/Provider/Alarm_Provider.dart';
import 'Features/Onboarding/Provider/onbording_provider.dart';
import 'Features/Onboarding/Screen/onboarding_screens.dart';

void main() {
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
