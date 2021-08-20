import 'package:flutter/cupertino.dart';

class DrawerProvider extends ChangeNotifier{
  int screenNumber = 3;

  void changeShow(int value){
    screenNumber = value;
    notifyListeners();

  }
}