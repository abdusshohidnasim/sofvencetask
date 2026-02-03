import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sofvence_task/Constants/Sizebox.dart';
import 'package:sofvence_task/Constants/app_colors.dart';
import 'package:sofvence_task/Features/Alarm/Provider/Alarm_Provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sofvence_task/Features/Alarm/Provider/Alarm_Provider.dart';
import 'package:sofvence_task/Features/Alarm/Screen/Alarm_Model.dart';


class AlarmScreen extends StatelessWidget {
  final String address;
  const AlarmScreen({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (picked != null) {
            // context-safe addAlarm
            context.read<AlarmProvider>().addAlarm(picked, context);
          }
        },
        backgroundColor: customize.ButtonColors,
        child: Icon(Icons.add, color: customize.TextColors, size: 30),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [customize.BackgrountColor1, customize.BackgrountColor2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selected Location",
                style: TextStyle(fontSize: 30, color: customize.TextColors),
              ),
              20.h,
              Container(
                height: 50,
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(29),
                  color: Color(0xff2B2B3D),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on_outlined, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "$address",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              30.h,
              Text(
                "Alarms",
                style: TextStyle(fontSize: 30, color: customize.TextColors),
              ),
              20.h,
              Expanded(
                child: Consumer<AlarmProvider>(
                  builder: (context, provider, child) {
                    if (provider.alarmItems.isEmpty) {
                      return const Center(
                        child: Text(
                          "No alarms set",
                          style: TextStyle(color: Colors.white54),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: provider.alarmItems.length,
                      itemBuilder: (context, index) {
                        final alarm = provider.alarmItems[index];
                        return Dismissible(
                          key: Key(alarm.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (direction) {
                            provider.deleteAlarm(index);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Color(0xff201A43),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              title: Text(
                                alarm.time,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                alarm.date,
                                style: const TextStyle(color: Colors.white54),
                              ),
                              trailing: Switch(
                                value: alarm.isActive,
                                activeColor: customize.ButtonColors,
                                onChanged: (value) => provider.toggleAlarm(index),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}























// class AlarmScreen extends StatelessWidget {
//   final String address;
//   AlarmScreen({super.key, required this.address});
//
//   @override
//   Widget build(BuildContext context) {
//     double Screenhight = MediaQuery.of(context).size.height;
//     double Screenwith = MediaQuery.of(context).size.width;
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(onPressed: ()async{
//         TimeOfDay? Picket = await showTimePicker(context: context, initialTime: TimeOfDay.now());
//         if(Picket!=null){
//           context.read<AlarmProvider>().addAlarm(Picket);
//         }
//       },
//       backgroundColor: customize.ButtonColors,
//         child: Icon(Icons.add,color: customize.TextColors,size: 30,),
//       ),
//       body: Container(
//         height: Screenhight,
//         width: Screenwith,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [customize.BackgrountColor1, customize.BackgrountColor2],
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(
//             top: 40,
//             left: 20,
//             right: 20,
//             bottom: 40,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Selected Location",
//                 style: TextStyle(fontSize: 30, color: customize.TextColors),
//               ),
//               20.h,
//               Container(
//                 height: 50,
//                 width: Screenwith,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(29),
//                   color: Color(0xff2B2B3D),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.location_on_outlined, color: Colors.white),
//                     Text(
//                       " $address",
//                       style: TextStyle(fontSize: 20, color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//               30.h,
//               Text(
//                 "Alarms",
//                 style: TextStyle(fontSize: 30, color: customize.TextColors),
//               ),
//               20.h,
//
//
//
//               Expanded(
//                 child: Consumer<AlarmProvider>(
//                   builder: (context, provider, child) {
//                     if (provider.alarmItems.isEmpty) {
//                       return const Center(child: Text("No alarms set", style: TextStyle(color: Colors.white54)));
//                     }
//                     return ListView.builder(
//                       itemCount: provider.alarmItems.length,
//                       padding: EdgeInsets.zero,
//                       itemBuilder: (context, index) {
//                         final alarm = provider.alarmItems[index];
//                         return Dismissible(
//                           key: Key(alarm.id),
//                           direction: DismissDirection.endToStart,
//                           background: Container(
//                             alignment: Alignment.centerRight,
//                             padding: const EdgeInsets.only(right: 20),
//                             margin: const EdgeInsets.only(bottom: 12),
//                             decoration: BoxDecoration(
//                               color: Colors.redAccent,
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: const Icon(Icons.delete, color: Colors.white),
//                           ),
//                           onDismissed: (direction) {
//                             provider.deleteAlarm(index);
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.only(bottom: 12),
//                             decoration: BoxDecoration(
//                               color: Color(0xff201A43),
//                              // color: Colors.white.withOpacity(0.05),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: ListTile(
//                               contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                               title: Text(alarm.time, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
//                               subtitle: Text(alarm.date, style: const TextStyle(color: Colors.white54)),
//                               trailing: Switch(
//                                 value: alarm.isActive,
//                                 activeColor: const Color(0xff6C63FF),
//                                 onChanged: (value) => provider.toggleAlarm(index),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
