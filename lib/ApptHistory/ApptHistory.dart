import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laskinnovita/BookAppointment/BookAppointment.dart';
import 'package:laskinnovita/Consultant/ConsultantScreen.dart';
import 'package:laskinnovita/GlobalComponent/GlobalNavigationRoute.dart';
import 'package:laskinnovita/GlobalComponent/GlobalAppColor.dart';
import 'package:laskinnovita/GlobalComponent/GlobalFlag.dart';
import 'package:laskinnovita/GlobalComponent/GlobalImageAssets.dart';
import 'package:laskinnovita/GlobalComponent/GlobalNavigationRoute.dart';
//------------------------------------START-----------------------------------//
class ApptHistory extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagApptHistory.toString();
  @override
  ApptHistoryState createState() => new ApptHistoryState();
}
//-----------------------------------SplashScreenState------------------------//
class ApptHistoryState extends State<ApptHistory> {
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
//------------------------------------Widget build----------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _SnackBarscaffoldKey,
      appBar: new AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: GlobalAppColor.AppBarColorCode,
        title: Text(
          GlobalFlag.HistoryAppointment.toString(),
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
      body: Container(
        child: new Stack(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(top: 0.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5.0,
                  ),
                  new Card(
                    color: GlobalAppColor.AppBarColorCode,
                    margin: new EdgeInsets.only(
                        left: 10.0,
                        right: 12.0,
                        top: 8.0,
                        bottom: 3.0),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(15.0)),
                    elevation: 5.0,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 0.0, top: 0.0),
                      child: new Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        verticalDirection:
                        VerticalDirection.down,
                        children: <Widget>[
                          SizedBox(height: 8.0),
//-----------------------------------------Title-----------------------------//
                          new Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10),
                            child: new Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  new Text(
                                    "Service Name".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontFamily:
                                      GlobalFlag
                                          .FontCode
                                          .toString(),
                                    ),
                                  ),
                                  new Text(
                                    "Consultant"
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.normal,
                                      fontFamily:
                                      GlobalFlag
                                          .FontCode
                                          .toString(),
                                    ),
                                  ),
                                ]),
                          ),
                          Divider(
                              height: 12,
                              thickness: 0.1,
                              color: Colors.white),
//----------------------------------------description-------------------------//
                          new Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10),
                            child: new Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  new Text(
                                    "Patient Name".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontFamily:
                                      GlobalFlag
                                          .FontCode
                                          .toString(),
                                    ),
                                  ),
                                  new Text(
                                    "Ankur Jain"
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.normal,
                                      fontFamily:
                                      GlobalFlag
                                          .FontCode
                                          .toString(),
                                    ),
                                  ),
                                ]),
                          ),
                          Divider(
                              height: 12,
                              thickness: 0.1,
                              color: Colors.white),
//----------------------------------------description-------------------------//
                          new Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10),
                            child: new Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  new Text(
                                    "Date".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontFamily:
                                      GlobalFlag
                                          .FontCode
                                          .toString(),
                                    ),
                                  ),
                                  new Text(
                                    "12-09-2020"
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.normal,
                                      fontFamily:
                                      GlobalFlag
                                          .FontCode
                                          .toString(),
                                    ),
                                  ),
                                ]),
                          ),
                          Divider(
                              height: 12,
                              thickness: 0.1,
                              color: Colors.white),
//----------------------------------------description-------------------------//
                          new Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10),
                            child: new Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  new Text(
                                    "Time".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontFamily:
                                      GlobalFlag
                                          .FontCode
                                          .toString(),
                                    ),
                                  ),
                                  new Text(
                                    "12:20 PM"
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.normal,
                                      fontFamily:
                                      GlobalFlag
                                          .FontCode
                                          .toString(),
                                    ),
                                  ),
                                ]),
                          ),
//----------------------------------------Type/Color Percentage-Mode----------//
                          Divider(
                              height: 12,
                              thickness: 0.1,
                              color: Colors.white),
//----------------------------------------------------------------------------//
                          SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: GlobalAppColor.AppBarColorCode,
        child:Container(
          height:50,
          child: FlatButton.icon(
            onPressed: () {
              setState(() {});
              /*_sendToServer();*/
            },
            icon: Icon(FontAwesomeIcons.plus,color: Colors.white,size: 15.0,), //`Icon` to display
            label: Text(GlobalFlag.Prescription.toString(),style: TextStyle(fontFamily: GlobalFlag.FontCode.toString(),fontSize: 15.0, color: Colors.white,fontWeight: FontWeight.bold,)),
          ),
        ),
      ),
      backgroundColor: Colors.white,
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
