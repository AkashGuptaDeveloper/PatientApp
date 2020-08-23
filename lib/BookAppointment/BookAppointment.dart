import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:laskinnovita/GlobalComponent/GlobalAppColor.dart';
import 'package:laskinnovita/GlobalComponent/GlobalFlag.dart';
import 'package:laskinnovita/GlobalComponent/GlobalNavigationRoute.dart';
//------------------------------------START-----------------------------------//
class BookAppointment extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagBookAppointment.toString();
  @override
  BookAppointmentState createState() => new BookAppointmentState();
}
//-----------------------------------SplashScreenState------------------------//
class BookAppointmentState extends State<BookAppointment> {
  final GlobalKey<ScaffoldState> _SnackBarscaffoldKey =
  GlobalKey<ScaffoldState>();
  // ignore: non_constant_identifier_names
  var _SelectedDate = "Date Not Set";
  var _SelectedTime = "Time Not Set";
  var GetSelectedDate = "";
  var GetSelectedTime = "";
// ignore: non_constant_identifier_names
  TextEditingController ServiceController = new TextEditingController();
  final FocusNode myFocusService = FocusNode();
  var Service;
  GlobalKey<FormState> _Formkey = new GlobalKey();
  // ignore: non_constant_identifier_names
  bool _validate = false;
//-----------------------------------initState--------------------------------//
  @override
  void initState() {
    super.initState();
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
        backgroundColor: GlobalAppColor.AppBarColorCode,
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: Text(
          GlobalFlag.BookAppointment.toString(),
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
          key: _Formkey,
          autovalidate: _validate,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              AddForm(),
            ],
          ),
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

//----------------------------------------AddForm-----------------------------//
  // ignore: non_constant_identifier_names
  Widget AddForm() {
    return new Column(
      children: <Widget>[
        Container(
          child: new Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
//---------------------------------------TextFormField------------------------//
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
//----------------------------AppointmentDate--------------------------------//
                      Container(
                        child: Text(
                          GlobalFlag.AppointmentDate.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w600,),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  GlobalFlag.SelectDate.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: GlobalFlag.FontCode,
                                    fontWeight: FontWeight.normal,),
                                ),
                              ),
                              new Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(0))),
                                child: GestureDetector(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: Text(_SelectedDate),
                                ),
                                margin: EdgeInsets.only(left: 100),
                              ),
                            ]
                        ),
                      ),
                      new Container(
                        child: Divider(
                          color: Colors.grey[600], thickness: 0.5,),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
//----------------------------AppointmentTIme--------------------------------//
                      Container(
                        child: Text(
                          GlobalFlag.AppointmentTime.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w600,),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  GlobalFlag.SelectTime.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: GlobalFlag.FontCode,
                                    fontWeight: FontWeight.normal,),
                                ),
                              ),
                              new Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(0))),
                                child: GestureDetector(
                                  onTap: () {
                                    _selectTime(context);
                                  },
                                  child: Text(_SelectedTime),
                                ),
                                margin: EdgeInsets.only(left: 100),
                              ),
                            ]
                        ),
                      ),
                      new Container(
                        child: Divider(color: Colors.grey[600],
                          thickness: 0.5,),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
//----------------------------Service-----------------------------------------//
                      Container(
                        child: Text(
                          GlobalFlag.AppointmentService.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: GlobalFlag.FontCode,
                            fontWeight: FontWeight.w600,),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      new Container(
                        child: new TextFormField(
                          style: TextStyle(color: GlobalAppColor.AppBarColorCode),
                          focusNode: myFocusService,
                          controller: ServiceController,
                          /*validator: validateUserMobile,*/
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          onSaved: (String val) {
                            Service = val;
                          },
                          decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(width: 1, color: Colors.red),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(width: 1, color: Colors.orange),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1, color: GlobalAppColor.AppBarColorCode),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                  width: 1,
                                )),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                BorderSide(width: 1, color: Colors.black)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1, color: Colors.grey)),
                            errorStyle: TextStyle(fontSize: 10.0, color: Colors.grey),
                            hintText: GlobalFlag.EnterService.toString(),
                            hintStyle: TextStyle(
                              fontSize: 12.0,
                              fontFamily: GlobalFlag.FontCode.toString(),
                              color: GlobalAppColor.BLackColorCode,
                            ),
                          ),
                        ),
                      ),
                      new Container(
                        child: Divider(color: Colors.grey[600],
                          thickness: 0.5,),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
//------------------------------_selectDate------------------------------------//
  Future<void> _selectDate(BuildContext context) async {
    DatePicker.showDatePicker(context,
        theme: DatePickerTheme(
          containerHeight: 210.0,
        ),
        showTitleActions: true,
        minTime: DateTime(2000, 1, 1),
        maxTime: DateTime(2022, 12, 31),
        onConfirm: (date) {
          /* print('confirm $date');*/
          _SelectedDate = '${date.year} - ${date.month} - ${date.day}';
          setState(() {
            GetSelectedDate = _SelectedDate;
            print(GetSelectedDate.replaceAll(' ', ''));
          });
        },
        currentTime: DateTime.now(),
        locale: LocaleType.en);
    setState(() {
      // ignore: unnecessary_statements
      GetSelectedDate;
    });
  }
//------------------------------_selectTime------------------------------------//
  Future<void> _selectTime(BuildContext context) async {
    DatePicker.showTimePicker(context,
        theme: DatePickerTheme(
          containerHeight: 210.0,
        ),
        showTitleActions: true,
        onConfirm: (time) {
          /*print('confirm $time');*/
          _SelectedTime = '${time.hour} : ${time.minute} : ${time.second}';
          setState(() {
            GetSelectedTime = _SelectedTime;
            print(GetSelectedTime.replaceAll(' ', ''));
          });
        },
        currentTime: DateTime.now(),
        locale: LocaleType.en);
    setState(() {
      // ignore: unnecessary_statements
      GetSelectedTime;
    });
  }
}
//---------------------------------------END----------------------------------//
