import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sofvence_task/Constants/Sizebox.dart';
import 'package:sofvence_task/Constants/app_colors.dart';
import 'package:sofvence_task/common%20Widgets/Button/Button.dart';
import 'package:sofvence_task/common%20Widgets/Onboarding%20Widgets/onbording_item.dart';

import '../../Location/Screen/Location_Screen.dart';
import '../Provider/onbording_provider.dart';

class Onbording extends StatelessWidget {
  Onbording({super.key});

  @override
  Widget build(BuildContext context) {
    double Screenhight = MediaQuery.of(context).size.height;
    double Screenwith = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: Screenhight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [customize.BackgrountColor1, customize.BackgrountColor2],
          ),
        ),
        child: Consumer<OnboardingProvider>(
          builder: (context, provider, child) {
            return PageView.builder(
              controller: provider.Pagecontoller,
              onPageChanged: provider.OnPageChange,
              itemCount: OnbordingItem().Item.length,
              itemBuilder: (context, indext) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          child: Image.asset(
                            OnbordingItem().Item[indext].image,
                            fit: BoxFit.fill,
                          ),
                          height: Screenhight / 2,
                          width: double.infinity,
                        ),
                        Positioned(
                          top: 50,
                          right: 30,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LocationScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Skip",
                              style: const TextStyle(
                                fontSize: 18,
                                color: customize.TextColors,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    20.h,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Text(
                            OnbordingItem().Item[indext].titel,
                            style: TextStyle(
                              fontSize: 30,
                              color: customize.TextColors,
                            ),
                          ),
                          20.h,
                          Text(
                            OnbordingItem().Item[indext].description,
                            style: TextStyle(
                              fontSize: 14,
                              color: customize.TextColors,
                            ),
                          ),
                          40.h,
                          // Indicator
                          SmoothPageIndicator(
                            controller: provider.Pagecontoller,
                            count: OnbordingItem().Item.length,
                            onDotClicked: (index) {
                              provider.Pagecontoller.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.easeInOut,
                              );
                            },
                            effect: const WormEffect(
                              dotHeight: 10,
                              dotWidth: 10,
                              activeDotColor: customize.ButtonColors,
                            ),
                          ),
                          60.h,

                          // Button
                          Button(
                            context: context,
                            buttonname: "Next",
                            ontabe: () {
                              if (provider.currenpag ==
                                  OnbordingItem().Item.length - 1) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LocationScreen(),
                                  ),
                                );
                              } else {
                                provider.Pagecontoller.nextPage(
                                  duration: Duration(microseconds: 100),
                                  curve: Curves.easeIn,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
