//--------------------------Import-Library------------------------------------//
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laskinnovita/ApptHistory/ApptHistory.dart';
import 'package:laskinnovita/BookAppointment/BookAppointment.dart';
import 'package:laskinnovita/Consultant/ConsultantScreen.dart';
import 'package:laskinnovita/Consultant/ConsultantScreen2.dart';
import 'package:laskinnovita/HomeScreen/HomeScreen.dart';
import 'package:laskinnovita/SplashScreen/SplashScreen.dart';

final routes = {
  '/Splash': (BuildContext context) => new SplashScreen(),
  '/': (BuildContext context) => new SplashScreen(),
  SplashScreen.tag: (context) => SplashScreen(),
  HomeScreen.tag: (context) => HomeScreen(),
  BookAppointment.tag: (context) => BookAppointment(),
  ConsultantScreen.tag: (context) => ConsultantScreen(),
  ConsultantScreen2.tag: (context) => ConsultantScreen2(),
  ApptHistory.tag: (context) => ApptHistory(),
};
//-------------------------------END------------------------------------------//
