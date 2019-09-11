import 'package:flutter/material.dart';

class CurrentIndexProvide with ChangeNotifier{
  int currentIndex = 0;

  changeCurrentIndex(int nowIndex){
    currentIndex = nowIndex;
    notifyListeners();
  }
}