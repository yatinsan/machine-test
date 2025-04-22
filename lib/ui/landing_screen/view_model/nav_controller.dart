import 'package:flutter/widgets.dart';

class NavController with ChangeNotifier{

  int _selectedNav = 2;

  set setNav(int value){
    _selectedNav = value;
    notifyListeners();
  }

   int get selectedNav =>_selectedNav;

}