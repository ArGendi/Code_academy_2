import 'package:code_academy_2/constants.dart';
import 'package:code_academy_2/models/user.dart';
import 'package:code_academy_2/screens/form_screen.dart';
import 'package:code_academy_2/screens/home_screen.dart';
import 'package:code_academy_2/screens/not_found_screen.dart';
import 'package:code_academy_2/screens/profile_screen.dart';
import 'package:code_academy_2/screens/update_screen.dart';
import 'package:code_academy_2/screens/user_input_screen.dart';
import 'package:flutter/material.dart';

class MyRoutes{
  static Route? generateRoute(RouteSettings settings){
    switch(settings.name){
      case formPath: return MaterialPageRoute(builder: (context) => FormScreen());
      case startPath: return MaterialPageRoute(builder: (context) => HomeScreen());
      case profilePath: return MaterialPageRoute(builder: (context) => ProfileScreen());
      case userInputPath: return MaterialPageRoute(builder: (context) => UserInputScreen());
      case updateScreenPath:
        var args = settings.arguments as User;
        return MaterialPageRoute(builder: (context) => UpdateScreen(editUser: args,));
      default: return MaterialPageRoute(builder: (context) => NotFoundScreen());
    }
  }
}