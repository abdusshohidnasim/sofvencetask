import 'package:flutter/cupertino.dart';

class OnboardingProvider extends ChangeNotifier{
  final PageController _pageControllers= PageController();
   PageController  get Pagecontoller => _pageControllers;

   int _currentPage = 0;
   int get currenpag => _currentPage;

   void OnPageChange(int index){
     _currentPage = index;
     notifyListeners();
}
  @override
  void dispose() {
    Pagecontoller.dispose();
    super.dispose();
  }

}