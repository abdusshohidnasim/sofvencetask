import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Features/Onboarding/Screen/onboarding_screens.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ),

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
      home: const Onbording(),
    );
  }
}
