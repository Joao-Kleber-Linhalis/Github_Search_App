import 'package:flutter/material.dart';
import 'package:github_search/themes/theme.dart';


//Provider para gerenciar os themes, pegar o atual e trocar.

class ThemeProvider with ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if(_themeData == lightMode){
      themeData = darkMode;
    } else{
      themeData = lightMode;
    }
  }

  bool getTheme(){
    if(_themeData == lightMode){
      return true;
    } else{
      return false;
    }
  }
}