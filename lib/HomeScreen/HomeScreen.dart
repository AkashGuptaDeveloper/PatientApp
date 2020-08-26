import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laskinnovita/ApptHistory/ApptHistory.dart';
import 'package:laskinnovita/BookAppointment/BookAppointment.dart';
import 'package:laskinnovita/Consultant/ConsultantScreen.dart';
import 'package:laskinnovita/GlobalComponent/GlobalNavigationRoute.dart';
import 'package:laskinnovita/GlobalComponent/GlobalAppColor.dart';
import 'package:laskinnovita/GlobalComponent/GlobalFlag.dart';
//------------------------------------START-----------------------------------//
class HomeScreen extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagHomeScreen.toString();
  @override
  HomeScreenState createState() => new HomeScreenState();
}
//-----------------------------------SplashScreenState------------------------//
class HomeScreenState extends State<HomeScreen> {
  // ignore: non_constant_identifier_names
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
  //-------------------------------------------------_onBackPressed------------//
  // ignore: non_constant_identifier_names
  Future<bool> _BackPressed(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(
          GlobalFlag.Areyousure,
          style: TextStyle(
            fontSize: 13.0,
            color: GlobalAppColor.BLackColorCode,
            fontWeight: FontWeight.bold,
            fontFamily: GlobalFlag.FontCode.toString(),
          ),
        ),
        content: new Text(
          GlobalFlag.exitanApp,
          style: TextStyle(
            fontSize: 13.0,
            color: GlobalAppColor.BLackColorCode,
            fontWeight: FontWeight.bold,
            fontFamily: GlobalFlag.FontCode.toString(),
          ),
        ),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: roundedButton(
              GlobalFlag.No,
              const Color(0xFF63C0Cf),
              const Color(0xFFFFFFFF),
            ),
          ),
          new GestureDetector(
            onTap: () => exit(0),
            child: roundedButton(GlobalFlag.Yes, const Color(0xFF63C0Cf),
                const Color(0xFFFFFFFF)),
          ),
        ],
      ),
    ) ??
        false;
  }
//---------------------------------------roundedButton------------------------//
  // ignore: non_constant_identifier_names
  Widget roundedButton(String buttonLabel, Color bgColor, Color textColor) {
    var loginBtn = new Container(
      padding: EdgeInsets.all(5.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFFFFFFFF),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }
//------------------------------------Widget build----------------------------//
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _BackPressed(context),
    child: Scaffold(
      key: _SnackBarscaffoldKey,
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: GlobalAppColor.AppBarColorCode,
        title: Text(
          GlobalFlag.Welcome.toString(),
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
      body: new Container(
        child: new Form(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                child: Text(
                  GlobalFlag.QuickAction,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: GlobalFlag.FontCode,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              new Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: QuickAction(),
              ),
              new Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Divider(
                  color: GlobalAppColor.AppBarColorCode,
                  thickness: 0.5,
                ),
              ),
              new Container(
                padding: EdgeInsets.only(left: 16.0, top: 5.0, right: 16.0),
                child: Text(
                  GlobalFlag.AboutUs,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: GlobalFlag.FontCode,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              new Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
                child: AboutUs(),
              ),
              new Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Divider(
                  color: Colors.grey[600],
                  thickness: 0.5,
                ),
              ),
              new Container(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 5.0,
                ),
                child: Text(
                  GlobalFlag.Support,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: GlobalFlag.FontCode,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              new Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
                child: Support(),
              ),
              new Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Divider(
                  color: Colors.grey[600],
                  thickness: 0.5,
                ),
              ),
              new Container(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 5.0,
                ),
                child: Text(
                  GlobalFlag.WhatsNews,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: GlobalFlag.FontCode,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              new Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
                child: WhatsNews(),
              ),
              new Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Divider(
                  color: Colors.grey[600],
                  thickness: 0.5,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    ),);
  }
//------------------------------QuickAction-----------------------------------//
  // ignore: non_constant_identifier_names
  Widget QuickAction() {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (_) => new BookAppointment()));
                });
              },
              child: new Container(
                color: GlobalAppColor.AppBarColorCode,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Icon(
                          FontAwesomeIcons.calendarAlt,
                          size: 35,
                          color: GlobalAppColor.WhiteColorCode,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.BookAppt,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                //Put your child widget here.
              ),
            ),
          ),
          Expanded(
            child: new Container(
              color: GlobalAppColor.AppBarColorCode,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (_) => new ConsultantScreen()));
                  });
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Icon(
                          FontAwesomeIcons.handshake,
                          size: 35,
                          color: GlobalAppColor.WhiteColorCode,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.OnlineConsultant,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              //Put your child widget here.
            ),
          ),
          Expanded(
            child: new Container(
              color: GlobalAppColor.AppBarColorCode,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (_) => new ApptHistory()));
                  });
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Icon(
                          FontAwesomeIcons.history,
                          color: GlobalAppColor.WhiteColorCode,
                          size: 35,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.ApptHistory,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              //Put your child widget here.
            ),
          )
        ],
      ),
    );
  }
//------------------------------AboutUs---------------------------------------//
  // ignore: non_constant_identifier_names
  Widget AboutUs() {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: new Container(
              color: GlobalAppColor.WhiteColorCode,
              child: GestureDetector(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Icon(
                          FontAwesomeIcons.plus,
                          size: 30,
                          color: GlobalAppColor.AppBarColorCode,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.AnujPall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              //Put your child widget here.
            ),
          ),
          Expanded(
            child: new Container(
              color: GlobalAppColor.WhiteColorCode,
              child: GestureDetector(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Icon(
                          FontAwesomeIcons.clinicMedical,
                          size: 30,
                          color: GlobalAppColor.AppBarColorCode,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.LaSkinnovita,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              //Put your child widget here.
            ),
          ),
          Expanded(
            child: new Container(
              color: GlobalAppColor.WhiteColorCode,
              child: GestureDetector(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Icon(
                          FontAwesomeIcons.commentMedical,
                          size: 30,
                          color: GlobalAppColor.AppBarColorCode,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.serious,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              //Put your child widget here.
            ),
          ),
          Expanded(
            child: new Container(
              color: GlobalAppColor.WhiteColorCode,
              child: GestureDetector(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Icon(
                          FontAwesomeIcons.fileMedical,
                          size: 30,
                          color: GlobalAppColor.AppBarColorCode,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.Testimonials,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              //Put your child widget here.
            ),
          ),
        ],
      ),
    );
  }
//------------------------------Support---------------------------------------//
  // ignore: non_constant_identifier_names
  Widget Support() {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: new Container(
              color: GlobalAppColor.WhiteColorCode,
              child: GestureDetector(
                child: Container(
                  padding:
                      new EdgeInsets.symmetric(horizontal: 6.0, vertical: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment
                            .topLeft, // Align however you like (i.e .centerRight, centerLeft)
                        child: Icon(
                          FontAwesomeIcons.shippingFast,
                          size: 30,
                          color: GlobalAppColor.AppBarColorCode,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.RequestMedicalDelivery,
                          softWrap: true,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 9,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              //Put your child widget here.
            ),
          ),
          Expanded(
            child: new Container(
              color: GlobalAppColor.WhiteColorCode,
              child: GestureDetector(
                child: Container(
                  padding:
                      new EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Icon(
                          FontAwesomeIcons.rupeeSign,
                          size: 30,
                          color: GlobalAppColor.AppBarColorCode,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.PayCustomer,
                          softWrap: true,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 9,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              //Put your child widget here.
            ),
          ),
          Expanded(
            child: new Container(
              color: GlobalAppColor.WhiteColorCode,
              child: GestureDetector(
                child: Container(
                  padding:
                      new EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Icon(
                          FontAwesomeIcons.mobileAlt,
                          size: 30,
                          color: GlobalAppColor.AppBarColorCode,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.ContactUs,
                          softWrap: true,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 9,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              //Put your child widget here.
            ),
          ),
          Expanded(
            child: new Container(
              color: GlobalAppColor.WhiteColorCode,
              child: GestureDetector(
                child: Container(
                  padding:
                      new EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Icon(
                          FontAwesomeIcons.peopleArrows,
                          size: 30,
                          color: GlobalAppColor.AppBarColorCode,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.Resource,
                          softWrap: true,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 9,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              //Put your child widget here.
            ),
          ),
          Expanded(
            child: new Container(
              color: GlobalAppColor.WhiteColorCode,
              child: GestureDetector(
                child: Container(
                  padding:
                      new EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Icon(
                          FontAwesomeIcons.comment,
                          size: 30,
                          color: GlobalAppColor.AppBarColorCode,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.Feedback,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              //Put your child widget here.
            ),
          ),
        ],
      ),
    );
  }
//------------------------------WhatsNews---------------------------------------//
  // ignore: non_constant_identifier_names
  Widget WhatsNews() {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: new Container(
              color: GlobalAppColor.WhiteColorCode,
              child: GestureDetector(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Icon(
                          FontAwesomeIcons.blog,
                          size: 30,
                          color: GlobalAppColor.AppBarColorCode,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.Blog,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              //Put your child widget here.
            ),
          ),
          Expanded(
            child: new Container(
              color: GlobalAppColor.WhiteColorCode,
              child: GestureDetector(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Icon(
                          FontAwesomeIcons.facebook,
                          size: 30,
                          color: GlobalAppColor.AppBarColorCode,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.Facebok,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              //Put your child widget here.
            ),
          ),
          Expanded(
            child: new Container(
              color: GlobalAppColor.WhiteColorCode,
              child: GestureDetector(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Icon(
                          FontAwesomeIcons.instagram,
                          size: 30,
                          color: GlobalAppColor.AppBarColorCode,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.Instagram,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              //Put your child widget here.
            ),
          ),
          Expanded(
            child: new Container(
              color: GlobalAppColor.WhiteColorCode,
              child: GestureDetector(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Icon(
                          FontAwesomeIcons.youtube,
                          size: 30,
                          color: GlobalAppColor.AppBarColorCode,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.Youtube,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              //Put your child widget here.
            ),
          ),
        ],
      ),
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
