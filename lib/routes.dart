//--------------------------Import-Library------------------------------------//
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laskinnovita/ApptHistory/ApptHistory.dart';
import 'package:laskinnovita/BookAppointment/BookAppointment.dart';
import 'package:laskinnovita/BookAppointment/BookAppointmentDone.dart';
import 'package:laskinnovita/Consultant/ConsultantScreen.dart';
import 'package:laskinnovita/Consultant/ConsultantScreen2.dart';
import 'package:laskinnovita/HomeScreen/HomeScreen.dart';
import 'package:laskinnovita/SplashScreen/SplashScreen.dart';
import 'package:laskinnovita/WevView/Blogs/Blogs.dart';
import 'package:laskinnovita/WevView/ContactUs/ContactUs.dart';
import 'package:laskinnovita/WevView/Delivery/Delivery.dart';
import 'package:laskinnovita/WevView/DrAnujPall/DrAnujPall.dart';
import 'package:laskinnovita/WevView/Facebook/Facebook.dart';
import 'package:laskinnovita/WevView/Instagram/Instagram.dart';
import 'package:laskinnovita/WevView/LaSkinnovita/LaSkinnovita.dart';
import 'package:laskinnovita/WevView/PayCustomer/PayCustomer.dart';
import 'package:laskinnovita/WevView/Resource/Resource.dart';
import 'package:laskinnovita/WevView/Services/Services.dart';
import 'package:laskinnovita/WevView/Testimonials/Testimonials.dart';
import 'package:laskinnovita/WevView/Feedback/Feedbacks.dart';
import 'package:laskinnovita/WevView/Youtube/Youtube.dart';

final routes = {
  '/Splash': (BuildContext context) => new SplashScreen(),
  '/': (BuildContext context) => new SplashScreen(),
  SplashScreen.tag: (context) => SplashScreen(),
  HomeScreen.tag: (context) => HomeScreen(),
  BookAppointment.tag: (context) => BookAppointment(),
  ConsultantScreen.tag: (context) => ConsultantScreen(),
  ConsultantScreen2.tag: (context) => ConsultantScreen2(),
  ApptHistory.tag: (context) => ApptHistory(),
  BookAppointmentDone.tag: (context) => BookAppointmentDone(),
  DrAnujPall.tag: (context) => DrAnujPall(),
  LaSkinnovita.tag: (context) => LaSkinnovita(),
  Services.tag: (context) => Services(),
  Testimonials.tag: (context) => Testimonials(),
  Delivery.tag: (context) => Delivery(),
  PayCustomer.tag: (context) => PayCustomer(),
  ContactUs.tag: (context) => ContactUs(),
  Resource.tag: (context) => Resource(),
  Feedbacks.tag: (context) => Feedbacks(),
  Blogs.tag: (context) => Blogs(),
  Facebook.tag: (context) => Facebook(),
  Instagram.tag: (context) => Instagram(),
  Youtube.tag: (context) => Youtube(),
};
//-------------------------------END------------------------------------------//
