
import 'package:flutter/cupertino.dart';

class ScreenProvider extends ChangeNotifier{
  String screenName = "Products" ;

  void changeScreen(String name){
    screenName = name;
    notifyListeners();
  }

}