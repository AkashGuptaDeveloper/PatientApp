import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laskinnovita/ApptHistory/ApptHistory.dart';
import 'package:laskinnovita/BookAppointment/BookAppointment.dart';
import 'package:laskinnovita/Consultant/ConsultantScreen.dart';
import 'package:laskinnovita/GlobalComponent/GlobalImageAssets.dart';
import 'package:laskinnovita/GlobalComponent/GlobalNavigationRoute.dart';
import 'package:laskinnovita/GlobalComponent/GlobalAppColor.dart';
import 'package:laskinnovita/GlobalComponent/GlobalFlag.dart';
import 'package:laskinnovita/WevView/Blogs/Blogs.dart';
import 'package:laskinnovita/WevView/ContactUs/ContactUs.dart';
import 'package:laskinnovita/WevView/Delivery/Delivery.dart';
import 'package:laskinnovita/WevView/DrAnujPall/DrAnujPall.dart';
import 'package:laskinnovita/WevView/Facebook/Facebook.dart';
import 'package:laskinnovita/WevView/Feedback/Feedbacks.dart';
import 'package:laskinnovita/WevView/Instagram/Instagram.dart';
import 'package:laskinnovita/WevView/LaSkinnovita/LaSkinnovita.dart';
import 'package:laskinnovita/WevView/PayCustomer/PayCustomer.dart';
import 'package:laskinnovita/WevView/Resource/Resource.dart';
import 'package:laskinnovita/WevView/Sec1/Sec1.dart';
import 'package:laskinnovita/WevView/Sec2/Sec2.dart';
import 'package:laskinnovita/WevView/Sec3/Sec3.dart';
import 'package:laskinnovita/WevView/Sec4/Sec4.dart';
import 'package:laskinnovita/WevView/Sec5/Sec5.dart';
import 'package:laskinnovita/WevView/Sec6/Sec6.dart';
import 'package:laskinnovita/WevView/Services/Services.dart';
import 'package:laskinnovita/WevView/Testimonials/Testimonials.dart';
import 'package:laskinnovita/WevView/Youtube/Youtube.dart';

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
  // ignore: non_constant_identifier_names
  var LoginUserToken;
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
      padding: EdgeInsets.all(3.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(4.0)),
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
            color: textColor, fontSize: 16.0, fontWeight: FontWeight.bold),
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
                new Container(
                  padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 5.0,
                  ),
                  child: Text(
                    GlobalFlag.OurPrimium,
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
                  child: OurPrimium(),
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
      ),
    );
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
                // color: GlobalAppColor.AppBarColorCode,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          // height: 15,
                          ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Image.asset(
                              GlobalImageAssets.bookAppointmentImg,
                              fit: BoxFit.contain),
                        ),
                      ),
                      SizedBox(
                          // height: 5,
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
                            color: Colors.black,
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
              // color: GlobalAppColor.AppBarColorCode,
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
                          // height: 15,
                          ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Image.asset(
                              GlobalImageAssets.bookConsultationImg,
                              fit: BoxFit.contain),
                        ),
                      ),
                      SizedBox(
                          // height: 5,
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
                            color: Colors.black,
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
              // color: GlobalAppColor.AppBarColorCode,
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
                          // height: 15,
                          ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Image.asset(
                              GlobalImageAssets.appointmentHistoryImg,
                              fit: BoxFit.contain),
                        ),
                      ),
                      SizedBox(
                          // height: 5,
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
                            color: Colors.black,
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
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_) => new DrAnujPall()));
              },
              child: Container(
                color: GlobalAppColor.WhiteColorCode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        // height: 15,
                        ),
                    Align(
                      alignment: Alignment
                          .center, // Align however you like (i.e .centerRight, centerLeft)
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(GlobalImageAssets.drAnujPallImg,
                            fit: BoxFit.contain),
                      ),
                    ),
                    SizedBox(
                        // height: 10,
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
                          fontSize: 12,
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
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_) => new LaSkinnovita()));
              },
              child: Container(
                color: GlobalAppColor.WhiteColorCode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        // height: 15,
                        ),
                    Align(
                      alignment: Alignment
                          .center, // Align however you like (i.e .centerRight, centerLeft)
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(GlobalImageAssets.laSkinnovitaImg,
                            fit: BoxFit.contain),
                      ),
                    ),
                    SizedBox(
                        // height: 10,
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
                          fontSize: 12,
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
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_) => new Services()));
              },
              child: Container(
                color: GlobalAppColor.WhiteColorCode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        // height: 15,
                        ),
                    Align(
                      alignment: Alignment
                          .center, // Align however you like (i.e .centerRight, centerLeft)
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(GlobalImageAssets.ourServices,
                            fit: BoxFit.contain),
                      ),
                    ),
                    SizedBox(
                        // height: 5,
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
                          fontSize: 12,
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
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_) => new Testimonials()));
              },
              child: Container(
                color: GlobalAppColor.WhiteColorCode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        // height: 15,
                        ),
                    Align(
                      alignment: Alignment
                          .center, // Align however you like (i.e .centerRight, centerLeft)
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(GlobalImageAssets.testimonialImg,
                            fit: BoxFit.contain),
                      ),
                    ),
                    SizedBox(
                        // height: 10,
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
                          fontSize: 12,
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
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_) => new Delivery()));
              },
              child: Container(
                color: GlobalAppColor.WhiteColorCode,
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
                      child: Image.asset(
                        GlobalImageAssets.requestMedicine,
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
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
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
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_) => new PayCustomer()));
              },
              child: Container(
                color: GlobalAppColor.WhiteColorCode,
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
                      child: Image.asset(
                        GlobalImageAssets.pay,
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
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
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
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_) => new ContactUs()));
              },
              child: Container(
                color: GlobalAppColor.WhiteColorCode,
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
                        child: Image.asset(GlobalImageAssets.contact,
                            fit: BoxFit.contain)),
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
                          fontSize: 12,
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
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_) => new Resource()));
              },
              child: Container(
                color: GlobalAppColor.WhiteColorCode,
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
                      child: Image.asset(
                        GlobalImageAssets.resourceImg,
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
                          fontSize: 12,
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
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_) => new Feedbacks()));
              },
              child: Container(
                color: GlobalAppColor.WhiteColorCode,
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
                      child: Image.asset(
                        GlobalImageAssets.feedback,
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
                          fontSize: 12,
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
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (_) => new Blogs()));
              },
              child: Container(
                color: GlobalAppColor.WhiteColorCode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment
                          .center, // Align however you like (i.e .centerRight, centerLeft)
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(GlobalImageAssets.blog,
                            fit: BoxFit.contain),
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
                          fontSize: 12,
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
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_) => new Facebook()));
              },
              child: Container(
                color: GlobalAppColor.WhiteColorCode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment
                          .center, // Align however you like (i.e .centerRight, centerLeft)
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(GlobalImageAssets.facebook,
                            fit: BoxFit.contain),
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
                          fontSize: 12,
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
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_) => new Instagram()));
              },
              child: Container(
                color: GlobalAppColor.WhiteColorCode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment
                          .center, // Align however you like (i.e .centerRight, centerLeft)
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(GlobalImageAssets.instagram,
                            fit: BoxFit.contain),
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
                          fontSize: 12,
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
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (_) => new Youtube()));
              },
              child: Container(
                color: GlobalAppColor.WhiteColorCode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment
                          .center, // Align however you like (i.e .centerRight, centerLeft)
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(GlobalImageAssets.youtube,
                            fit: BoxFit.contain),
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
                          fontSize: 12,
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
          ),
        ],
      ),
    );
  }

//------------------------------OurPrimium-------------------------------------//
  // ignore: non_constant_identifier_names
  Widget OurPrimium() {
    return new Column(
      children: [
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (_) => new Sec1()));
                },
                child: Container(
                  color: GlobalAppColor.WhiteColorCode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          // height: 15,
                          ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(GlobalImageAssets.nepthysRejuve,
                              fit: BoxFit.contain),
                        ),
                      ),
                      SizedBox(
                          // height: 10,
                          ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.Sec1,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
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
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (_) => new Sec2()));
                },
                child: Container(
                  color: GlobalAppColor.WhiteColorCode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          // height: 15,
                          ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(GlobalImageAssets.wosyetVital,
                              fit: BoxFit.contain),
                        ),
                      ),
                      SizedBox(
                          // height: 10,
                          ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.Sec2,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
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
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (_) => new Sec3()));
                },
                child: Container(
                  color: GlobalAppColor.WhiteColorCode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          // height: 15,
                          ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(GlobalImageAssets.aureatSphinx,
                              fit: BoxFit.contain),
                        ),
                      ),
                      SizedBox(
                          // height: 10,
                          ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.Sec3,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
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
            ),
          ],
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (_) => new Sec4()));
                },
                child: Container(
                  color: GlobalAppColor.WhiteColorCode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          // height: 15,
                          ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(GlobalImageAssets.juvetasPeeling,
                              fit: BoxFit.contain),
                        ),
                      ),
                      SizedBox(
                          // height: 10,
                          ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.Sec4,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
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
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (_) => new Sec5()));
                },
                child: Container(
                  color: GlobalAppColor.WhiteColorCode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          // height: 15,
                          ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(GlobalImageAssets.athenaGenenis,
                              fit: BoxFit.contain),
                        ),
                      ),
                      SizedBox(
                          // height: 10,
                          ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.Sec5,
                          // textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
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
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (_) => new Sec6()));
                },
                child: Container(
                  color: GlobalAppColor.WhiteColorCode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          // height: 15,
                          ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(GlobalImageAssets.bodySihouette,
                              fit: BoxFit.contain),
                        ),
                      ),
                      SizedBox(
                          // height: 10,
                          ),
                      Align(
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          GlobalFlag.Sec6,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
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
            ),
          ],
        ),
      ],
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
