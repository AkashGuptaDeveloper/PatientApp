import 'dart:async';
import 'dart:developer';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laskinnovita/Consultant/ConsultantScreen2.dart';
import 'package:laskinnovita/GlobalComponent/GlobalAppColor.dart';
import 'package:laskinnovita/GlobalComponent/GlobalFlag.dart';
import 'package:laskinnovita/GlobalComponent/GlobalImageAssets.dart';
import 'package:laskinnovita/GlobalComponent/GlobalNavigationRoute.dart';
//------------------------------------START-----------------------------------//
class ConsultantScreen extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagConsultantScreen.toString();
  @override
  ConsultantScreenState createState() => new ConsultantScreenState();
}
//-----------------------------------SplashScreenState------------------------//
class ConsultantScreenState extends State<ConsultantScreen> {
  final GlobalKey<ScaffoldState> _SnackBarscaffoldKey =
  GlobalKey<ScaffoldState>();
//-----------------------------------initState--------------------------------//
  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity();
  }
//-----------------------------------------dispose()--------------------------//
  @override
  void dispose() {
    super.dispose();
  }
//------------------------------------Widget build----------------------------//
  @override
  Widget build(BuildContext context) {
//----------------------------------------------------------------------------//
    return Scaffold(
      key: _SnackBarscaffoldKey,
      appBar: new AppBar(
        backgroundColor: GlobalAppColor.AppBarColorCode,
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: Text(
          GlobalFlag.Consultant.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            color: GlobalAppColor.WhiteColorCode,
            fontFamily: GlobalFlag.FontCode,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body:new Center(
        child: ListView(
          children: [
           SizedBox(height: 20,),
           new Container(
             padding: EdgeInsets.only(left: 20,right: 20),
             height: 200,
             width: 300,
             color: Colors.grey[200],
             child: Image.asset(
                 GlobalImageAssets.splash,
                 fit:BoxFit.contain
             ),
           ),
          SizedBox(height: 20,),
          new Container(
            padding: EdgeInsets.only(left: 20,right: 20),
            color: GlobalAppColor.AppBarColorCode,
            child: Container(
              height:50,
              width: 300,
              child: FlatButton.icon(
                onPressed: () {
                  setState(() {});
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (_) => new ConsultantScreen2()));
                },
                icon: Icon(FontAwesomeIcons.save,color: Colors.white,size: 15.0,), //`Icon` to display
                label: Text(GlobalFlag.Continue.toString().toUpperCase(),style: TextStyle(fontFamily: GlobalFlag.FontCode.toString(),fontSize: 15.0, color: Colors.white,fontWeight: FontWeight.bold,)),
              ),
            ),
          ),
          ],
        )
      ),
      backgroundColor: Colors.white,
    );
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
    _SnackBarscaffoldKey.currentState?.removeCurrentSnackBar();
    _SnackBarscaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.start,
        style: TextStyle(
            color: const Color(0xFFFFFFFF),
            fontSize: 12.0,
            fontFamily: GlobalFlag.FontCode),
      ),
      backgroundColor: GlobalAppColor.BLackColorCode,
    ));
  }
}
//---------------------------------------END----------------------------------//
