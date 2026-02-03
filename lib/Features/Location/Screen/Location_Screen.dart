import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sofvence_task/Constants/Sizebox.dart';
import 'package:sofvence_task/Constants/app_colors.dart';
import 'package:sofvence_task/common%20Widgets/Button/Button.dart';
import 'package:geolocator/geolocator.dart';


import '../../Alarm/alarm_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? address ;


  Future<void> getLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          address = "Location Permission Denied!";
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks.first;



      String? district = place.subAdministrativeArea?.isNotEmpty == true
          ? place.subAdministrativeArea
          : (place.administrativeArea?.isNotEmpty == true
          ? place.administrativeArea
          : null);



      String? country =
      place.country?.isNotEmpty == true ? place.country : "Unknown";

      /// CUSTOM DISPLAY → Upazila বাদ দিয়ে District + Division + Country
      if (district != null && country != null) {
        address = "$country $district,";
        debugPrint(" $district");
      } else if (district != null) {
        address = " $country $district,";
      }
      else {

        address = "${position.latitude}, ${position.longitude}";
      }

      setState(() {});
    } catch (e) {
      setState(() {
        address = "Error: ${e.toString()}";
      });
    }
  }






  @override
  Widget build(BuildContext context) {
    double Screenhight = MediaQuery.of(context).size.height;
    double Screenwith = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: Screenhight,
        width: Screenwith,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [customize.BackgrountColor1, customize.BackgrountColor2],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 60,
            bottom: 60,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              Text(
                "Welcome! Your Smart Travel Alarm",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: customize.TextColors),
              ),
              20.h,
              Text(
                "Stay on schedule and enjoy every moment of your journey",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: customize.TextColors),
              ),
              30.h,
              Container(
                height: Screenhight / 2.5,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/Location.png"),
                    fit: BoxFit.cover,
                  ),
                ),

              ),
              20.h,
              Spacer(),
              InkWell(
                onTap: (){getLocation();},
                child: Container(
                  height: 50,
                  width: Screenwith,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    border: Border.all(color: Color(0xffB4A7B9), width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(address ?? "Use Current Location ",style: TextStyle(
                          fontSize: 20,
                          color: Colors.white),),
                      Icon(Icons.location_on,color: Colors.white,)
                    ],
                  ),
                ),
              ),
              20.h,
              Button(
                context: context,
                buttonname: "Hoame",
                ontabe: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AlarmScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
