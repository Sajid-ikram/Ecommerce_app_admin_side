
import 'package:flutter/cupertino.dart';

class ScreenProvider extends ChangeNotifier{
  String screenName = "Customers" ;

  void changeScreen(String name){
    screenName = name;
    notifyListeners();
  }

}