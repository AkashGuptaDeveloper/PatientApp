import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laskinnovita/Consultant/ViewPDF.dart';
import 'package:laskinnovita/GlobalComponent/GlobalNavigationRoute.dart';
import 'package:laskinnovita/GlobalComponent/GlobalAppColor.dart';
import 'package:laskinnovita/GlobalComponent/GlobalFlag.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:laskinnovita/GlobalComponent/GlobalServiceURL.dart';
import 'package:laskinnovita/Model/ApptHistoryModel.dart';

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
  // ignore: non_constant_identifier_names
  String errMessage = GlobalFlag.ErrorSendData.toString();
  var status;
  // ignore: non_constant_identifier_names
  List<History> _History = [];
//------------------------------------API-------------------------------------//
  // ignore: non_constant_identifier_names
  String ListOfApptHistoryUrl_ServiceUrl =
      GlobalServiceURL.ApptHistoryListUrl.toString();
//-----------------------------------initState--------------------------------//
  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity();
    FetchDateFromServer();
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
        iconTheme: IconThemeData(color: Colors.white),
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
      body: new Container(
        child: new ListView.builder(
          itemCount: _History == null ? 0 : _History.length,
          itemBuilder: (context, index) {
            return new Container(
              child: Container(
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
                            color: GlobalAppColor.WhiteColorCode,
                            margin: new EdgeInsets.only(
                                left: 10.0, right: 12.0, top: 8.0, bottom: 3.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                            elevation: 5.0,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 0.0, top: 0.0),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                verticalDirection: VerticalDirection.down,
                                children: <Widget>[
//-----------------------------------------Service-----------------------------//
                                  Container(
                                    color: GlobalAppColor.AppBarColorCode,
                                    child: new Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0,
                                          right: 10,
                                          top: 10,
                                          bottom: 10),
                                      child: Container(
                                        child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              new Text(
                                                GlobalFlag.Service,
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: GlobalFlag
                                                      .FontCode.toString(),
                                                ),
                                              ),
                                              new Text(
                                                _History[index]
                                                    .appointment
                                                    .service,
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: GlobalFlag
                                                      .FontCode.toString(),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                      height: 12,
                                      thickness: 0.1,
                                      color: Colors.white),
//----------------------------------------Bookingfor-------------------------//
                                  new Padding(
                                    padding:
                                        EdgeInsets.only(left: 10.0, right: 10),
                                    child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          new Text(
                                            GlobalFlag.Bookingfor,
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: GlobalFlag.FontCode
                                                  .toString(),
                                            ),
                                          ),
                                          new Text(
                                            _History[index].patientType,
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: GlobalFlag.FontCode
                                                  .toString(),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  Divider(
                                      height: 12,
                                      thickness: 0.1,
                                      color: Colors.grey[900]),
//----------------------------------------AppointmentID-----------------------//
                                  new Padding(
                                    padding:
                                        EdgeInsets.only(left: 10.0, right: 10),
                                    child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          new Text(
                                            GlobalFlag.AppointmentID
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: GlobalFlag.FontCode
                                                  .toString(),
                                            ),
                                          ),
                                          new Text(
                                            _History[index]
                                                .appointment
                                                .appointmentId,
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: GlobalFlag.FontCode
                                                  .toString(),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  Divider(
                                      height: 12,
                                      thickness: 0.1,
                                      color: Colors.grey[900]),
//----------------------------------------AppointmentDate---------------------//
                                  new Padding(
                                    padding:
                                        EdgeInsets.only(left: 10.0, right: 10),
                                    child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          new Text(
                                            GlobalFlag.AppointmentDate,
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: GlobalFlag.FontCode
                                                  .toString(),
                                            ),
                                          ),
                                          new Text(
                                            _History[index].appointment.date,
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: GlobalFlag.FontCode
                                                  .toString(),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  Divider(
                                      height: 12,
                                      thickness: 0.1,
                                      color: Colors.grey[900]),
//----------------------------------------AppointmentTime---------------------//
                                  new Padding(
                                    padding:
                                        EdgeInsets.only(left: 10.0, right: 10),
                                    child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          new Text(
                                            GlobalFlag.AppointmentTime
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: GlobalFlag.FontCode
                                                  .toString(),
                                            ),
                                          ),
                                          new Text(
                                            _History[index].appointment.time,
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: GlobalFlag.FontCode
                                                  .toString(),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  Divider(
                                      height: 12,
                                      thickness: 0.1,
                                      color: Colors.grey[900]),
//----------------------------------------BookingTime-------------------------//
                                  new Padding(
                                    padding:
                                        EdgeInsets.only(left: 10.0, right: 10),
                                    child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          new Text(
                                            GlobalFlag.BookingTime
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: GlobalFlag.FontCode
                                                  .toString(),
                                            ),
                                          ),
                                          new Text(
                                            _History[index].bookingTime,
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: GlobalFlag.FontCode
                                                  .toString(),
                                            ),
                                          ),
                                        ]),
                                  ),
//----------------------------------------------------------------------------//
                                  Divider(
                                      height: 12,
                                      thickness: 0.1,
                                      color: Colors.grey[900]),
                                  new Padding(
                                    padding:
                                    EdgeInsets.only(left: 10.0, right: 10),
                                    child:Container(
                                      color: GlobalAppColor.AppBarColorCode,
                                      height: 30,
                                      child: FlatButton.icon(
                                        onPressed: () {
                                          setState(() {
                                            // ignore: unnecessary_statements
                                            _History[index].appointment.appointmentId;
                                          });
                                           Navigator.of(context).push(new MaterialPageRoute(
                                          builder: (_) => new ViewPDF(
                                            SendappointmentId:_History[index].appointment.appointmentId,
                                          )));
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.arrowAltCircleRight,
                                          color: Colors.white,
                                          size: 15.0,
                                        ), //`Icon` to display
                                        label: Text(GlobalFlag.View.toString().toUpperCase(),
                                            style: TextStyle(
                                              fontFamily: GlobalFlag.FontCode.toString(),
                                              fontSize: 15.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    ),
                                  ),
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
            );
          },
        ),
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

//------------------------------FetchDateFromServer--------------------------//
  // ignore: non_constant_identifier_names
  Future<void> FetchDateFromServer() async {
    try {
      http.post(ListOfApptHistoryUrl_ServiceUrl.toString(), body: {
        "user_token": GlobalFlag.ServiceToken,
        "type": "appointment",
        // ignore: non_constant_identifier_names
      }).then((result) {
        setStatus(result.statusCode == 200 ? result.body : errMessage);
        // ignore: non_constant_identifier_names
        /*print(GlobalFlag.Printjsonresp.toString() +
            "${result.body.toString()}");*/
        // ignore: non_constant_identifier_names
        var ReciveBatchList = json.decode(result.body);
        // ignore: non_constant_identifier_names
        var DateavailabilityList = ReciveBatchList["history"];
        setState(() {
          for (Map i in DateavailabilityList) {
            _History.add(History.fromJson(i));
          }
        });
        // ignore: non_constant_identifier_names
      }).catchError((error) {
        setStatus(error);
      });
    } catch (e) {
      _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
    }
  }

//------------------------------------------setStatus-------------------------//
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
}
//---------------------------------------END----------------------------------//
