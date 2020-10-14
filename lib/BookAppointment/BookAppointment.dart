import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laskinnovita/BookAppointment/BookAppointmentDone.dart';
import 'package:laskinnovita/GlobalComponent/GlobalAppColor.dart';
import 'package:laskinnovita/GlobalComponent/GlobalFlag.dart';
import 'package:laskinnovita/GlobalComponent/GlobalNavigationRoute.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:laskinnovita/GlobalComponent/GlobalServiceURL.dart';
import 'package:laskinnovita/Model/CheckAvilityModel.dart';
import 'package:laskinnovita/Model/TimeAvilityModel.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:laskinnovita/Preferences/Preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
//------------------------------------START-----------------------------------//
class BookAppointment extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagBookAppointment.toString();
  @override
  BookAppointmentState createState() => new BookAppointmentState();
}
//-----------------------------------SplashScreenState------------------------//
class BookAppointmentState extends State<BookAppointment> {
  // ignore: non_constant_identifier_names
  final GlobalKey<ScaffoldState> _SnackBarscaffoldKey =
      GlobalKey<ScaffoldState>();
  // ignore: non_constant_identifier_names
  var GetSelectedDate = "";
  // ignore: non_constant_identifier_names
  var GetSelectedTime = "";
// ignore: non_constant_identifier_names
  TextEditingController ServiceController = new TextEditingController();
  final FocusNode myFocusService = FocusNode();
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> _Formkey = new GlobalKey();
  // ignore: non_constant_identifier_names
  bool _validate = false;
  // ignore: non_constant_identifier_names
  String errMessage = GlobalFlag.ErrorSendData.toString();
  var status;
//-------------------------------Service---------------------------------------//
  // ignore: non_constant_identifier_names
  List<Service> _Service = Service.getCompanies();
  List<DropdownMenuItem<Service>> _dropdownMenuItemsService;
  Service _selectedService;
//-------------------------------Consultant-----------------------------------//
  // ignore: non_constant_identifier_names
  List<Consultant> _Consultant = Consultant.getCompanies();
  List<DropdownMenuItem<Consultant>> _dropdownMenuItemsConsultant;
  Consultant _selectedConsultant;
  // ignore: non_constant_identifier_names
  TextEditingController DetailsController = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController NameController = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController mobileController = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController emailController = new TextEditingController();
  // ignore: non_constant_identifier_names
  final FocusNode myFocusNodeDetails = FocusNode();
  // ignore: non_constant_identifier_names
  final FocusNode myFocusNodeName = FocusNode();
  // ignore: non_constant_identifier_names
  final FocusNode myFocusNodemobile = FocusNode();
  // ignore: non_constant_identifier_names
  final FocusNode myFocusNodeemail = FocusNode();
  // ignore: non_constant_identifier_names
  var Details,name,email,mobile;
  // ignore: non_constant_identifier_names
  List<Availability> _Availability = [];
  // ignore: non_constant_identifier_names
  List<TimeAvailabilityList> _TimeAvailability = [];
  // ignore: non_constant_identifier_names
  var Avilable;
  // ignore: non_constant_identifier_names
  var AvilableTime;
  // ignore: non_constant_identifier_names
  bool TimeShow = false;
  // ignore: non_constant_identifier_names
  var TimeAbilableResult;
  // ignore: non_constant_identifier_names
  var DateAbilableResult;
  // ignore: non_constant_identifier_names
  var SelectDate;
  // ignore: non_constant_identifier_names
  var SelectTime;
  // ignore: non_constant_identifier_names
  ProgressDialog pr;
  // ignore: non_constant_identifier_names
  var ReciveJsonSTATUSMSG;
  // ignore: non_constant_identifier_names
  var ReciveJsonBookingID;
  // ignore: non_constant_identifier_names
  var Model;
  // ignore: non_constant_identifier_names
  int _selectedDateIndex;
  // ignore: non_constant_identifier_names
  int _selectedTimeIndex;
  // ignore: non_constant_identifier_names
  var Message;
  // ignore: non_constant_identifier_names
  var TimeModel;
  // ignore: non_constant_identifier_names
  var LoginUserToken;
  // ignore: non_constant_identifier_names
  bool Others = false;
  // ignore: non_constant_identifier_names
  var GetPaymentID;
  // ignore: non_constant_identifier_names
  var GetPaymentsignature;
  // ignore: non_constant_identifier_names
  var GetPaymentorderId;
  var contact;
//------------------------------------API-------------------------------------//
  // ignore: non_constant_identifier_names
  String AvailabilityUrl_ServiceUrl =
      GlobalServiceURL.AvailabilityUrl.toString();
  // ignore: non_constant_identifier_names
  String TimeAvailabilityUrl_ServiceUrl =
      GlobalServiceURL.TimeAvailabilityUrl.toString();
  // ignore: non_constant_identifier_names
  String BookingUrl_ServiceUrl = GlobalServiceURL.BookingUrl.toString();
  // ignore: non_constant_identifier_names
  String UserViewProfile_ServiceUrl =
  GlobalServiceURL.ProfileView.toString();
//-----------------------------------initState--------------------------------//
  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity();
    FetchDateFromServer();
//-------------------------------------Service--------------------------------//
    _dropdownMenuItemsService = buildDropdownMenuItemsService(_Service);
    _selectedService = _dropdownMenuItemsService[0].value;
//-------------------------------------Consultant-----------------------------//
    _dropdownMenuItemsConsultant =
        buildDropdownMenuItemsConsultant(_Consultant);
    _selectedConsultant = _dropdownMenuItemsConsultant[0].value;
  }
//---------------------------------buildDropdownMenuItemsService--------------//
  List<DropdownMenuItem<Service>> buildDropdownMenuItemsService(List service) {
    List<DropdownMenuItem<Service>> items = List();
    for (Service service in service) {
      items.add(
        DropdownMenuItem(
          value: service,
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(
              service.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: GlobalFlag.FontCode,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }
    return items;
  }
//---------------------------------buildDropdownMenuItemsService--------------//
  List<DropdownMenuItem<Consultant>> buildDropdownMenuItemsConsultant(
      List consultant) {
    List<DropdownMenuItem<Consultant>> items = List();
    for (Consultant consultant in consultant) {
      items.add(
        DropdownMenuItem(
          value: consultant,
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(
              consultant.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: GlobalFlag.FontCode,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }
    return items;
  }
//-----------------------------------onChangeDropdownItemService--------------//
  onChangeDropdownItemService(Service selectedService) {
    setState(() {
      _selectedService = selectedService;
      // ignore: unnecessary_statements
      _selectedService.name;
      if(_selectedService.id == 1){
        Others = false;
      }else if(_selectedService.id == 2){
        Others = true;
      }
    });
  }

//-----------------------------------onChangeDropdownItemConsultant-----------//
  onChangeDropdownItemConsultant(Consultant selectedConsultant) {
    setState(() {
      _selectedConsultant = selectedConsultant;
      // ignore: unnecessary_statements
      _selectedConsultant.name;
    });
  }
//-----------------------------------------dispose()--------------------------//
  @override
  void dispose() {
    super.dispose();
  }
//------------------------------_onSelected-Date------------------------------//
  _onSelectedDate(int index) {
    setState(() => _selectedDateIndex = index);
  }
//------------------------------_onSelected-Time------------------------------//
  _onSelectedTime(int index) {
    setState(() => _selectedTimeIndex = index);
  }
//------------------------------------Widget build----------------------------//
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(
      message: GlobalFlag.PleaseWait.toString(),
    );
//---------------------------------------DateList-----------------------------//
    // ignore: non_constant_identifier_names
    Widget DateList = new Container(
        margin: EdgeInsets.all(5),
        height: 60.0,
        child: new ListView.separated(
          itemCount: _Availability == null ? 0 : _Availability.length,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            TimeModel = _Availability[index].availablity;
            if (_Availability[index].availablity == 1) {
              Avilable = "Slot Available";
            } else {
              Avilable = "Slot Not Available";
            }
            DateAbilableResult = _Availability[index].availablity;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _onSelectedDate(index);
                  _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
                  SelectDate = _Availability[index].date;
                  if (_Availability[index].availablity == 1) {
                    _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
                    DateAvilableSnackBar(GlobalFlag.SlotavailableinthisDate);
                  } else {
                    TimeShow = false;
                    DateNotAvilableSnackBar(
                        GlobalFlag.SlotnotavailableinthisDate);
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _selectedDateIndex != null &&
                            _selectedDateIndex == index
                        ? Color(0xFF63C0Cf)
                        : Color(0xFFF3FDFF),
                    border: Border.all(color: Colors.blueAccent, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: 150.0,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: new Text(
                        _Availability[index].date,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: GlobalFlag.FontCode,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: new Text(
                        Avilable.toString(),
                        style: TextStyle(
                          color: DateAbilableResult == 0
                              ? Colors.red
                              : Colors.green,
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 5,
            );
          },
        ));
//---------------------------------------TimeList-----------------------------//
    // ignore: non_constant_identifier_names
    Widget TimeList = Visibility(
      visible: TimeShow,
      child: new Container(
          margin: EdgeInsets.all(5),
          height: 50.0,
          child: new ListView.separated(
            shrinkWrap: true,
            itemCount: _TimeAvailability == null ? 0 : _TimeAvailability.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (_TimeAvailability[index].available == "1") {
                AvilableTime = "Slot Available";
              } else {
                AvilableTime = "Slot Not Available";
              }
              TimeAbilableResult = _TimeAvailability[index].available;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
                    // ignore: unnecessary_statements
                    _onSelectedTime(index);
                    // ignore: unnecessary_statements
                    _TimeAvailability[index].time;
                    SelectTime = _TimeAvailability[index].time;
                    setState(() {
                      Model = _TimeAvailability[index].available;
                    });
                    if (_TimeAvailability[index].available == "1") {
                      _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
                      TimeAvilableSnackBar(GlobalFlag.SlotavailableinthisTime);
                    } else {
                      TimeNotAvilableSnackBar(
                          GlobalFlag.SlotavailableinthisNotTime);
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: _selectedTimeIndex != null &&
                              _selectedTimeIndex == index
                          ? Color(0xFF63C0Cf)
                          : Color(0xFFF3FDFF),
                      border: Border.all(color: Colors.blueAccent, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: 100.0,
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: new Text(
                            _TimeAvailability[index].time,
                            style: TextStyle(
                              color: _selectedTimeIndex != null &&
                                      _selectedTimeIndex == index
                                  ? Color(0xFF000000)
                                  : Color(0xFF000000),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: new Text(
                            AvilableTime.toString(),
                            style: TextStyle(
                              color: _TimeAvailability[index].available == "1"
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 5,
              );
            },
          )),
    );
//----------------------------------------------------------------------------//
    return Scaffold(
      key: _SnackBarscaffoldKey,
      appBar: new AppBar(
        backgroundColor: GlobalAppColor.AppBarColorCode,
        iconTheme: IconThemeData(color: Colors.white),
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
      body: new Form(
        key: _Formkey,
        // ignore: deprecated_member_use
        autovalidate: _validate,
        child: new ListView(
          children: <Widget>[
//----------------------------AppointmentDate--------------------------------//
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text(
                GlobalFlag.AppointmentDate.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: GlobalFlag.FontCode,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
//--------------------------------DateList------------------------------------//
            DateList,
//----------------------------AppointmentTIme---------------------------------//
            Visibility(
              visible: TimeShow,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Text(
                  GlobalFlag.AppointmentTime.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: GlobalFlag.FontCode,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
//--------------------------------Others--------------------------------------//
            TimeList,
//----------------------------bookingfor--------------------------------------//
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text(
                GlobalFlag.bookingfor.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: GlobalFlag.FontCode,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: new Container(
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    border: new Border.all(
                        color: GlobalAppColor.AppBarColorCode, width: 1.0)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _selectedService,
                    items: _dropdownMenuItemsService,
                    onChanged: onChangeDropdownItemService,
                  ),
                ),
              ),
            ),
//-----------------------------Name-Email-Mobile------------------------------//
            Visibility(
              visible: Others,
              child:Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: new TextFormField(
                  style: TextStyle(color: GlobalAppColor.AppBarColorCode),
                  focusNode: myFocusNodeName,
                  controller: NameController,
                  validator: validateName,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  onSaved: (String val) {
                    name = val;
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
                        borderSide: BorderSide(width: 1, color: Colors.black)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.grey)),
                    errorStyle: TextStyle(fontSize: 10.0, color: Colors.black),
                    hintText: GlobalFlag.Name.toString(),
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      fontFamily: GlobalFlag.FontCode.toString(),
                      color: GlobalAppColor.BLackColorCode,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height:5.0,
            ),
            Visibility(
              visible: Others,
              child:Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: new TextFormField(
                  style: TextStyle(color: GlobalAppColor.AppBarColorCode),
                  focusNode: myFocusNodemobile,
                  controller: mobileController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
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
                        borderSide: BorderSide(width: 1, color: Colors.black)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.grey)),
                    errorStyle: TextStyle(fontSize: 10.0, color: Colors.black),
                    hintText: GlobalFlag.Mobile.toString(),
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      fontFamily: GlobalFlag.FontCode.toString(),
                      color: GlobalAppColor.BLackColorCode,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height:5.0,
            ),
            Visibility(
              visible: Others,
              child:Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: new TextFormField(
                  style: TextStyle(color: GlobalAppColor.AppBarColorCode),
                  focusNode: myFocusNodeemail,
                  controller: emailController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
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
                        borderSide: BorderSide(width: 1, color: Colors.black)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.grey)),
                    errorStyle: TextStyle(fontSize: 10.0, color: Colors.black),
                    hintText: GlobalFlag.Email.toString(),
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      fontFamily: GlobalFlag.FontCode.toString(),
                      color: GlobalAppColor.BLackColorCode,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height:5.0,
            ),
//----------------------------Consultant--------------------------------------//
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text(
                GlobalFlag.Consultant.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: GlobalFlag.FontCode,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: new Container(
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    border: new Border.all(
                        color: GlobalAppColor.AppBarColorCode, width: 1.0)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _selectedConsultant,
                    items: _dropdownMenuItemsConsultant,
                    onChanged: onChangeDropdownItemConsultant,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
//----------------------------Consultant--------------------------------------//
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text(
                GlobalFlag.Details.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: GlobalFlag.FontCode,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: new TextFormField(
                style: TextStyle(color: GlobalAppColor.AppBarColorCode),
                focusNode: myFocusNodeDetails,
                controller: DetailsController,
                validator: validateDetails,
                textInputAction: TextInputAction.done,
                onSaved: (String val) {
                  Details = val;
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
                      borderSide: BorderSide(width: 1, color: Colors.black)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                  errorStyle: TextStyle(fontSize: 10.0, color: Colors.black),
                  hintText: GlobalFlag.EnterDetails.toString(),
                  hintStyle: TextStyle(
                    fontSize: 14.0,
                    fontFamily: GlobalFlag.FontCode.toString(),
                    color: GlobalAppColor.BLackColorCode,
                  ),
                ),
              ),
            ),
            SizedBox(
              height:25.0,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: GlobalAppColor.AppBarColorCode,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//-------------------------------------------------------------------//
            new Expanded(
              child: Container(
                  height: 40,
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        _PayLaterToServer();
                      });
                    },
                    color: GlobalAppColor.AppBarColorCode,
                    textColor: Colors.white,
                    child: Text(
                      GlobalFlag.Submit.toString(),
                      style: TextStyle(
                          fontSize: 15.0,
                          color: GlobalAppColor.WhiteColorCode,
                          fontWeight: FontWeight.bold,
                          fontFamily: GlobalFlag.FontCode.toString()),
                    ),
                  )),
              flex: 1,
            ),
//-----------------------------------------------------------------------------//
          ],
        ),
      ),
    );
  }
//-------------------------------------------_checkInternetConnectivity-------//
  void _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog(GlobalFlag.InternetNotConnected);
    }
    else{
      FetchProfileFromServer();
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
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
//----------------------------Service-----------------------------------------//
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
//------------------------------FetchDateFromServer--------------------------//
  // ignore: non_constant_identifier_names
  Future<void> FetchDateFromServer() async {
    try {
      http.post(AvailabilityUrl_ServiceUrl.toString(), body: {
        // ignore: non_constant_identifier_names
      }).then((resultListOfBatchs) {
        setStatus(resultListOfBatchs.statusCode == 200
            ? resultListOfBatchs.body
            : errMessage);
        // ignore: non_constant_identifier_names
        /* print(GlobalFlag.Printjsonresp.toString() +
            "${resultListOfBatchs.body.toString()}");*/
        // ignore: non_constant_identifier_names
        var ReciveBatchList = json.decode(resultListOfBatchs.body);
        // ignore: non_constant_identifier_names
        var DateavailabilityList = ReciveBatchList["availability"];
        setState(() {
          for (Map i in DateavailabilityList) {
            _Availability.add(Availability.fromJson(i));
          }
        });
        // ignore: non_constant_identifier_names
      }).catchError((error) {
        setStatus(error);
      });
    } catch (e) {
      _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
      /*JsonReciveStatusFalseAlert();*/
    }
  }
//------------------------------FetchTimeFromServer--------------------------//
  // ignore: non_constant_identifier_names, missing_return
  Future<String> FetchTimeFromServer() async {
    setState(() {
      // ignore: unnecessary_statements
      SelectDate;
    });
    //we have to wait to get the data so we use 'await'
    http.Response response = await http.get(
        //Uri.encodeFull removes all the dashes or extra characters present in our Uri
        Uri.encodeFull(TimeAvailabilityUrl_ServiceUrl + "?date=" + SelectDate),
        headers: {
          //if your api require key then pass your key here as well e.g "key": "my-long-key"
          "Accept": "application/json"
        });
    // ignore: non_constant_identifier_names
    var ReciveBatchList = json.decode(response.body);
    // ignore: non_constant_identifier_names
    var TimeavailabilityList = ReciveBatchList["availability"];
    setState(() {
      for (Map i in TimeavailabilityList) {
        _TimeAvailability.add(TimeAvailabilityList.fromJson(i));
        TimeShow = true;
      }
    });
  }
//------------------------------------------setStatus-------------------------//
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
//----------------------------------------_PayLaterToServer-------------------//
  // ignore: non_constant_identifier_names
  Future<void> _PayLaterToServer() async {
    if (_Formkey.currentState.validate()) {
      _Formkey.currentState.save();
      setState(() {
        if (SelectDate == null) {
          SelectDateSnackBar(GlobalFlag.PleaseSelectDate);
        } else {
          if (SelectTime == null) {
            SelectTimeSnackBar(GlobalFlag.PleaseSelectTime);
          } else {
            setState(() {
              // ignore: unnecessary_statements
              Model;
              if (Model == "1") {
                _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
                SendDataPayLaterService();
              } else {
                TimeNotAvilableSnackBar(GlobalFlag.SlotavailableinthisNotTime);
              }
            });
          }
        }
      });
    } else {
      setState(() {
        _validate = true;
      });
    }
  }
//----------------------------SelectDaysSnackBar------------------------------//
  // ignore: non_constant_identifier_names
  void SelectDateSnackBar(String value) {
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
//----------------------------SelectDaysSnackBar------------------------------//
  // ignore: non_constant_identifier_names
  void SelectTimeSnackBar(String value) {
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
//----------------------------SelectDaysSnackBar------------------------------//
  // ignore: non_constant_identifier_names
  void selecteServiceSnackBar(String value) {
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
//----------------------validateDetails------------------------------------//
  String validateDetails(String value) {
    String patttern = r'';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return GlobalFlag.DetailsisRequired.toString();
    } else if (!regExp.hasMatch(value)) {
      return GlobalFlag.DetailsmustbeNeed.toString();
    }
    return null;
  }
//----------------------validateDetails------------------------------------//
  String validateName(String value) {
    String patttern = r'';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return GlobalFlag.NameRequired.toString();
    } else if (!regExp.hasMatch(value)) {
      return GlobalFlag.NamebeNeed.toString();
    }
    return null;
  }
//-------------------------------SendDataService------------------------------//
  // ignore: non_constant_identifier_names
  Future<void> SendDataPayLaterService() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginUserToken = prefs.getString(Preferences.KEY_USER_token).toString();
    _checkInternetConnectivity();
    setState(() {
      // ignore: unnecessary_statements
      SelectDate;
      // ignore: unnecessary_statements
      SelectTime;
      // ignore: unnecessary_statements
      _selectedService.name;
      // ignore: unnecessary_statements
      _selectedConsultant.name;
      // ignore: unnecessary_statements
      NameController.text;
      // ignore: unnecessary_statements
      mobileController.text;
      // ignore: unnecessary_statements
      emailController.text;
    });
    pr.show();
    try {
      http.post(BookingUrl_ServiceUrl, body: {
        "user_token":LoginUserToken.toString(),
        "date": SelectDate.toString(),
        "time": SelectTime.toString(),
        "service": _selectedConsultant.name.toString(),
        "patient": _selectedService.name.toString(),
        "details": DetailsController.text.toString(),
        "type": "appointment".toString(),
        " OtherName": NameController.text.toString(),
        " OtherEmail": mobileController.text.toString(),
        " OtherMobile":emailController.text.toString(),
      }).then((resultAddBatch) {
        setStatus(resultAddBatch.statusCode == 200
            ? resultAddBatch.body
            : errMessage);
//-------------------------Print-Section--------------------------------------//
         print(GlobalFlag.Printjsonresp.toString() +
            "${resultAddBatch.body.toString()}");
//------------------------END-Print-Section-----------------------------------//
        // ignore: non_constant_identifier_names
        var ReciveJsonData = json.decode(resultAddBatch.body);
        // ignore: non_constant_identifier_names
        var ReciveJsonSTATUS = ReciveJsonData[GlobalFlag.Jsonstatus];
        ReciveJsonSTATUSMSG = ReciveJsonData[GlobalFlag.Jsonmsg];
        ReciveJsonBookingID = ReciveJsonData[GlobalFlag.appointmentID];
        if (ReciveJsonSTATUS == 200) {
          setState(() {
            pr.hide();
            _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
            _SendBookAppointmentDone();
          });
        } else {
          setState(() {
            pr.hide();
            _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
            BookAddedFailedSnackBar(ReciveJsonSTATUSMSG);
          });
        }
//----------------------------------------------------------------------------//
      }).catchError((error) {
        setStatus(error);
      });
    } catch (e) {
      pr.hide();
      _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
    }
  }
//-----------------------------BookAppointmentDone----------------------------//
  // ignore: non_constant_identifier_names
  Future<void> _SendBookAppointmentDone() async {
    await Future.delayed(Duration(seconds: 2));
    var route = new MaterialPageRoute(
      builder: (BuildContext context) => new BookAppointmentDone(
        SendReciveJsonSTATUSMSG: ReciveJsonSTATUSMSG,
        ReciveJsonBookingID: ReciveJsonBookingID.toString(),
      ),
    );
    Navigator.of(context).push(route);
  }
//----------------------------BatchAddedFailedSnackBar------------------------//
// ignore: non_constant_identifier_names
  void BookAddedFailedSnackBar(String value) {
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
//----------------------------BatchAddedFailedSnackBar------------------------//
// ignore: non_constant_identifier_names
  void DateNotAvilableSnackBar(String value) {
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
//----------------------------DateAvilableSnackBar----------------------------//
// ignore: non_constant_identifier_names
  void DateAvilableSnackBar(String value) {
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
    setState(() {
      _TimeAvailability.clear();
      FetchTimeFromServer();
    });
  }
//----------------------------DateAvilableSnackBar----------------------------//
// ignore: non_constant_identifier_names
  void TimeNotAvilableSnackBar(String value) {
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
//----------------------------DateAvilableSnackBar----------------------------//
// ignore: non_constant_identifier_names
  void TimeAvilableSnackBar(String value) {
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
    setState(() {
      // ignore: unnecessary_statements
      SelectTime;
      // ignore: unnecessary_statements
      Model;
    });
  }
//-------------------------------SendDataPayNowFromService--------------------//
  // ignore: non_constant_identifier_names
  Future<void> SendDataPayNowFromService() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginUserToken = prefs.getString(Preferences.KEY_USER_token).toString();
    _checkInternetConnectivity();
    setState(() {
      // ignore: unnecessary_statements
      SelectDate;
      // ignore: unnecessary_statements
      SelectTime;
      // ignore: unnecessary_statements
      _selectedService.name;
      // ignore: unnecessary_statements
      _selectedConsultant.name;
      // ignore: unnecessary_statements
      NameController.text;
      // ignore: unnecessary_statements
      mobileController.text;
      // ignore: unnecessary_statements
      emailController.text;
    });
    pr.show();
    try {
      http.post(BookingUrl_ServiceUrl, body: {
        "user_token":LoginUserToken.toString(),
        "date": SelectDate.toString(),
        "time": SelectTime.toString(),
        "service": _selectedConsultant.name.toString(),
        "patient": _selectedService.name.toString(),
        "details": DetailsController.text.toString(),
        "type": "appointment".toString(),
        " OtherName": NameController.text.toString(),
        " OtherEmail": mobileController.text.toString(),
        " OtherMobile":emailController.text.toString(),
      }).then((resultAddBatch) {
        setStatus(resultAddBatch.statusCode == 200
            ? resultAddBatch.body
            : errMessage);
//-------------------------Print-Section--------------------------------------//
        /*  print(GlobalFlag.Printjsonresp.toString() +
            "${resultAddBatch.body.toString()}");*/
//------------------------END-Print-Section-----------------------------------//
        // ignore: non_constant_identifier_names
        var ReciveJsonData = json.decode(resultAddBatch.body);
        // ignore: non_constant_identifier_names
        var ReciveJsonSTATUS = ReciveJsonData[GlobalFlag.Jsonstatus];
        ReciveJsonSTATUSMSG = ReciveJsonData[GlobalFlag.Jsonmsg];
        ReciveJsonBookingID = ReciveJsonData[GlobalFlag.appointmentID];
        if (ReciveJsonSTATUS == 200) {
          setState(() {
            pr.hide();
            _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
            _SendBookAppointmentDone();
          });
        } else {
          setState(() {
            pr.hide();
            _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
            BookAddedFailedSnackBar(ReciveJsonSTATUSMSG);
          });
        }
//----------------------------------------------------------------------------//
      }).catchError((error) {
        setStatus(error);
      });
    } catch (e) {
      pr.hide();
      _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
    }
  }
//------------------------------FetchProfileFromServer-------------------------//
  // ignore: non_constant_identifier_names
  Future<void> FetchProfileFromServer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginUserToken = prefs.getString(Preferences.KEY_USER_token).toString();
    try {
      http.post(UserViewProfile_ServiceUrl.toString(), body: {
        "user_token": LoginUserToken,
        // ignore: non_constant_identifier_names
      }).then((result) {
        setStatus(result.statusCode == 200 ? result.body : errMessage);
        // ignore: non_constant_identifier_names
        /*  print(GlobalFlag.Printjsonresp.toString() +
            "${result.body.toString()}");*/
        // ignore: non_constant_identifier_names
        var ReciveData = json.decode(result.body);
        // ignore: non_constant_identifier_names
        var Status = ReciveData[GlobalFlag.Jsonstatus];
        setState(() {
          if(Status == 200){
            // ignore: non_constant_identifier_names
            var RecivedData = ReciveData["data"];
            // ignore: non_constant_identifier_names
            name = RecivedData["name"];
            // ignore: non_constant_identifier_names
            email = RecivedData["email"];
            // ignore: non_constant_identifier_names
            contact = RecivedData["mobile"];
            setState(() {
              // ignore: unnecessary_statements
              name;
              // ignore: unnecessary_statements
              email;
              // ignore: unnecessary_statements
              contact;
            });
          }else{
            _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
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
}
//---------------------------------------END----------------------------------//
//--------------------Service-------------------------------------------------//
class Service {
  int id;
  String name;
  Service(this.id, this.name);
  static List<Service> getCompanies() {
    return <Service>[
      Service(1, 'Self'),
      Service(2, 'Other'),
    ];
  }
}
//--------------------Consultant----------------------------------------------//
class Consultant {
  int id;
  String name;
  Consultant(this.id, this.name);
  static List<Consultant> getCompanies() {
    return <Consultant>[
      Consultant(1, 'Consultation'),
      Consultant(2, 'Laser Hair Reduction'),
      Consultant(3, 'Chemical Peeling'),
      Consultant(4, 'Hair Injection'),
      Consultant(5, 'Botox Cosmetic'),
      Consultant(6, 'Dermal Filters'),
      Consultant(7, 'PRP'),
      Consultant(8, 'MesotherapyHIFU'),
      Consultant(9, 'Hethena TST Laser Toning'),
      Consultant(10, 'MNRF'),
    ];
  }
}
//----------------------------------------------------------------------------//
