import 'package:flutter/cupertino.dart';

class OnboardingProvider extends ChangeNotifier{
  final PageController _pageControllers= PageController();
   PageController  get Pagecontoller => _pageControllers;

}