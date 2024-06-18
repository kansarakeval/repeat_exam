import 'package:flutter/material.dart';
import 'package:repeat_exam/screen/edit/view/edit_screen.dart';
import 'package:repeat_exam/screen/home/view/home_screen.dart';
import 'package:repeat_exam/screen/splash/view/splash_screen.dart';

Map<String,WidgetBuilder> app_routes={
  '/': (context)=>const SplashScreen(),
  'home': (context)=> const HomeScreen(),
  'edit': (contex)=> const EditScreen(),
};