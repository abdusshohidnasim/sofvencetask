import 'package:flutter/material.dart';
import 'package:sofvence_task/Constants/app_colors.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: [
          customize.BackgrountColor1, customize.BackgrountColor2
        ])),
        child: Column(children: [

        ],),
      ),
    );
  }
}
