import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Features/Onboarding/Provider/onbording_provider.dart';
import 'Features/Onboarding/Screen/onboarding_screens.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => OnboardingProvider()),

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
