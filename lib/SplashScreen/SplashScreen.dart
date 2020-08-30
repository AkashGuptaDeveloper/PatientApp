//--------------------------Import-Library------------------------------------//
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laskinnovita/GlobalComponent/GlobalAppColor.dart';
import 'package:laskinnovita/GlobalComponent/GlobalFlag.dart';
import 'package:laskinnovita/GlobalComponent/GlobalImageAssets.dart';
import 'package:laskinnovita/GlobalComponent/GlobalNavigationRoute.dart';
import 'package:laskinnovita/HomeScreen/HomeScreen.dart';
import 'package:laskinnovita/LoginView/LoginView.dart';

//------------------------------------START-----------------------------------//
class SplashScreen extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagSplashScreen.toString();
  @override
  SplashScreenState createState() => new SplashScreenState();
}

//-----------------------------------SplashScreenState------------------------//
class SplashScreenState extends State<SplashScreen> {
  Timer timer;
  // ignore: non_constant_identifier_names
  final GlobalKey<ScaffoldState> _SnackBarscaffoldKey =
      GlobalKey<ScaffoldState>();
//-----------------------------------handleTimeout----------------------------//
  void handleTimeout() async {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (_) => new LoginView()));
  }

//-----------------------------------startTimeout-----------------------------//
  startTimeout() async {
    var duration = const Duration(seconds: 1);
    return new Timer(duration, handleTimeout);
  }

//-----------------------------------initState--------------------------------//
  @override
  void initState() {
    _checkInternetConnectivity();
    // ignore: unnecessary_statements
    super.initState();
    startTimeout();
  }

//-------------------------------------------_checkInternetConnectivity-------//
  void _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog(GlobalFlag.InternetNotConnected);
    }
  }

//----------------------------showInSnackBar----------------------------------//
  void _showDialog(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _SnackBarscaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.start,
        style: TextStyle(
            color: const Color(0xFFFFFFFF),
            fontSize: 12.0,
            fontFamily: GlobalFlag.FontCode),
      ),
      backgroundColor: GlobalAppColor.AppBarColorCode,
      duration: Duration(minutes: 10),
    ));
  }

//-----------------------------------------dispose()---------------------------//
  @override
  void dispose() {
    super.dispose();
    startTimeout();
  }

//------------------------------------Widget build----------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _SnackBarscaffoldKey,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              GlobalAppColor.WhiteColorCode,
              GlobalAppColor.WhiteColorCode
            ])),
        child: Center(
          child: new Container(
            child: Image.asset(GlobalImageAssets.splash, fit: BoxFit.contain),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
//---------------------------------------END----------------------------------//
