import 'package:flutter/material.dart';

import '../../Constants/app_colors.dart';

class Button extends StatelessWidget {
   Button({super.key,required context, required this.buttonname,required this.ontabe});
   String buttonname;
   VoidCallback ontabe;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: customize.ButtonColors,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: InkWell(
        onTap: ontabe,
        child: Center(
          child:  Text(
           buttonname,
            style: TextStyle(
              fontSize: 18,
              color: customize.TextColors,
            ),
          ),
        ),
      ),
    );
  }
}
