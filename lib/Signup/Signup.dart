//--------------------------Import-Library------------------------------------//
import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:laskinnovita/GlobalComponent/GlobalAppColor.dart';
import 'package:laskinnovita/GlobalComponent/GlobalFlag.dart';
import 'package:laskinnovita/GlobalComponent/GlobalImageAssets.dart';
import 'package:laskinnovita/GlobalComponent/GlobalNavigationRoute.dart';
import 'package:laskinnovita/GlobalComponent/GlobalServiceURL.dart';
import 'package:laskinnovita/HomeScreen/HomeScreen.dart';
import 'package:laskinnovita/LoginView/LoginView.dart';
import 'package:laskinnovita/Preferences/Preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
//------------------------------------START-----------------------------------//
class Signup extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagSignup.toString();
  // ignore: non_constant_identifier_names
  final String RecivedToken;
  Signup({
    Key key,
    // ignore: unnecessary_statements, non_constant_identifier_names
    this.RecivedToken,
  }) : super(key: key);
  @override
  SignupState createState() => new SignupState();
}
//-----------------------------------SplashScreenState------------------------//
class SignupState extends State<Signup> {
  // ignore: non_constant_identifier_names
  TextEditingController LoginNameController = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController LoginEmailController = new TextEditingController();
  // ignore: non_constant_identifier_names
  String Name,Email;
  // ignore: non_constant_identifier_names
  String status = '';
  // ignore: non_constant_identifier_names
  String errMessage = GlobalFlag.ErrorSendData.toString();
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> _LoginFormkey = new GlobalKey();
  // ignore: non_constant_identifier_names
  bool _validate = false;
  // ignore: non_constant_identifier_names
  final FocusNode myFocusNodeName = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  // ignore: non_constant_identifier_names
  final GlobalKey<ScaffoldState> _SnackBarscaffoldKey =
  GlobalKey<ScaffoldState>();
  // ignore: non_constant_identifier_names
  ProgressDialog pr;
  // ignore: non_constant_identifier_names
  var LoginReciveJsonSTATUSMSG;
  // ignore: non_constant_identifier_names
  var LoginReciveTransactionId;
  // ignore: non_constant_identifier_names
  var LoginRecivemobile;
  // ignore: non_constant_identifier_names
  String _Date = "Select Date";
  // ignore: non_constant_identifier_names
  var LoginUserToken;
  // ignore: non_constant_identifier_names
  var SignupReciveJsonSTATUSMSG;
  //-------------------------------Service---------------------------------------//
  // ignore: non_constant_identifier_names
  List<Gender> _Gender = Gender.getCompanies();
  List<DropdownMenuItem<Gender>> _dropdownMenuItemsGender;
  Gender _selectedGender;
//-----------------------------------------API--------------------------------//
  // ignore: non_constant_identifier_names
  String SignuUrl_ServiceUrl =
  GlobalServiceURL.SignupUrl.toString();
//-----------------------------------initState--------------------------------//
  @override
  void initState() {
    super.initState();
    print(widget.RecivedToken);
//-------------------------------------Gender--------------------------------//
    _dropdownMenuItemsGender = buildDropdownMenuItemsGender(_Gender);
    _selectedGender = _dropdownMenuItemsGender[0].value;
  }
//---------------------------------buildDropdownMenuItemsGender--------------//
  List<DropdownMenuItem<Gender>> buildDropdownMenuItemsGender(List gender) {
    List<DropdownMenuItem<Gender>> items = List();
    for (Gender gender in gender) {
      items.add(
        DropdownMenuItem(
          value: gender,
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(
              gender.name,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: GlobalFlag.FontCode.toString(),
                color: GlobalAppColor.BLackColorCode,
              ),
            ),
          ),
        ),
      );
    }
    return items;
  }
//-----------------------------------onChangeDropdownItemGender--------------//
  onChangeDropdownItemGender(Gender selectedGender) {
    setState(() {
      _selectedGender = selectedGender;
      // ignore: unnecessary_statements
      _selectedGender.name;
    });
  }
//-----------------------------------------dispose()---------------------------//
  @override
  void dispose() {
    super.dispose();
  }
//------------------------------------Widget build----------------------------//
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(
      message: GlobalFlag.PleaseWait.toString(),
    );
    return new WillPopScope(
      onWillPop:_BackPressed,
      child: Scaffold(
        key: _SnackBarscaffoldKey,
        body: Form(
          key: _LoginFormkey,
          autovalidate: _validate,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(height:30.0,),
              FormLogo(),
              SizedBox(height:30.0,),
              TextFieldFormates(),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20,),
                child: new Container(
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      border: new Border.all(
                          color: GlobalAppColor.AppBarColorCode, width: 1.0)),
                  child: SizedBox(
                    width: double.infinity,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _selectedGender,
                        items: _dropdownMenuItemsGender,
                        onChanged: onChangeDropdownItemGender,
                      ),
                    ),),
                ),
              ),
              SizedBox(height:15.0,),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20,),
                child: new Container(
                  padding: EdgeInsets.only(left: 5.0,top: 10, bottom: 10),
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      border: new Border.all(
                          color: GlobalAppColor.AppBarColorCode, width: 1.0)),
                  child: GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Text(_Date,style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: GlobalFlag.FontCode.toString(),
                      color: GlobalAppColor.BLackColorCode,
                    ),),
                  ),
                ),
              ),
              SizedBox(height:15.0,),
            ],
          ),
        ),
//----------------------------------bottomNavigationBar-----------------------//
        bottomNavigationBar: BottomAppBar(
          color: GlobalAppColor.AppBarColorCode,
          child: Container(
              height: 40,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    _LoginSendToServer();
                  });
                },
                color: GlobalAppColor.AppBarColorCode,
                textColor: Colors.white,
                child: Text(
                  GlobalFlag.NameSubmit.toString(),
                  style: TextStyle(
                      fontSize: 15.0,
                      color: GlobalAppColor.WhiteColorCode,
                      fontWeight: FontWeight.bold,
                      fontFamily: GlobalFlag.FontCode.toString()),
                ),
              )),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
//------------------------------_selectStartTimeFrom--------------------------//
  Future<void> _selectDate(BuildContext context) async {
    DatePicker.showDatePicker(context,
        theme: DatePickerTheme(
          containerHeight: 210.0,
        ),
        showTitleActions: true, onConfirm: (date) {
          _Date = '${date.year}-${date.month}-${date.day}';
          setState(() {
            print(_Date);
          });
        }, currentTime: DateTime.now(), locale: LocaleType.en);
    setState(() {
      // ignore: unnecessary_statements
      /*GetFromTimeWithoutSpace;*/
      _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
    });
  }
//-----------------------------------------------------FormLogo---------------//
  // ignore: non_constant_identifier_names
  Widget FormLogo() {
    return new Column(
      children: <Widget>[
        new Container(
          child: new Container(
            child: Image.asset(
              GlobalImageAssets.splash,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
//------------------------------TextFieldFormates-----------------------------//
  // ignore: non_constant_identifier_names
  Widget TextFieldFormates() {
    return new Column(
      children: <Widget>[
        new Container(
          child: new Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
//-------------------------------------------------EnterName------------------//
                new Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: new TextFormField(
                    style: TextStyle(color: GlobalAppColor.AppBarColorCode),
                    focusNode: myFocusNodeName,
                    controller: LoginNameController,
                    validator: validateUserName,
                    textInputAction: TextInputAction.done,
                    onSaved: (String val) {
                      Name = val;
                    },
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: GlobalAppColor.AppBarColorCode),
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
                          borderSide: BorderSide(width: 1, color: Colors.black)),
                      errorStyle: TextStyle(fontSize: 10.0, color: Colors.black),
                      hintText:GlobalFlag.EnterName.toString(),
                      hintStyle: TextStyle(
                        fontSize: 12.0,
                        fontFamily: GlobalFlag.FontCode.toString(),
                        color: GlobalAppColor.BLackColorCode,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height:15,
                ),
//-------------------------------------------------EnterEmail-----------------//
                new Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: new TextFormField(
                    style: TextStyle(color: GlobalAppColor.AppBarColorCode),
                    focusNode: myFocusNodeEmail,
                    controller: LoginEmailController,
                    validator: validateUserEmail,
                    textInputAction: TextInputAction.done,
                    onSaved: (String val) {
                      Email = val;
                    },
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: GlobalAppColor.AppBarColorCode),
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
                          borderSide: BorderSide(width: 1, color: Colors.black)),
                      errorStyle: TextStyle(fontSize: 10.0, color: Colors.black),
                      hintText:GlobalFlag.EnterEmail.toString(),
                      hintStyle: TextStyle(
                        fontSize: 12.0,
                        fontFamily: GlobalFlag.FontCode.toString(),
                        color: GlobalAppColor.BLackColorCode,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height:15,
                ),
//-------------------------------------------------Submit---------------------//
              ],
            ),
          ),
        ),
      ],
    );
  }
//--------------------------validateUserName--------------------------------//
  String validateUserName(String value) {
    String patttern = r'';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return GlobalFlag.NameisRequired.toString();
    } else if (!regExp.hasMatch(value)) {
      return GlobalFlag.NamemustbeNeed.toString();
    }
    return null;
  }
//--------------------------validateUserEmail--------------------------------//
  String validateUserEmail(String value) {
    String pattern = GlobalFlag.PattternEmail.toString();
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return GlobalFlag.EmailRequired.toString();
    } else if (!regExp.hasMatch(value)) {
      return GlobalFlag.InvalidEmail.toString();
    } else {
      return null;
    }
  }
//----------------------------------------_LoginSendToServer------------------//
  // ignore: non_constant_identifier_names
  _LoginSendToServer() async {
    if (_LoginFormkey.currentState.validate()) {
      _LoginFormkey.currentState.save();
      setState(() {
        if(_Date == "Select Date"){
          SelectDateSnackBar(GlobalFlag.SelectDate);
        }else{
          _checkInternetConnectivity();
        }
      });
    }
    else {
      setState(() {
        _validate = true;
      });
    }
  }
//----------------------------WaitSnackBar------------------------------------//
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
//-------------------------------------------------_onBackPressed-------------//
  // ignore: missing_return, non_constant_identifier_names
  Future<bool> _BackPressed () async{
    removeData(context);
  }
//-----------------   removeData----------------------------------------------//
  removeData(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(Preferences.KEY_USER_status);
    prefs.remove(Preferences.KEY_USER_token);
    prefs.remove(Preferences.KEY_USER_msg);
    Navigator.of(context).pushNamed(LoginView.tag);
  }
//-------------------------------------------_checkInternetConnectivity-------//
  void _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog(GlobalFlag.InternetNotConnected);
    }
    else{
      UserSignupService();
      WaitSnackBar(GlobalFlag.PleaseWait);
    }
  }
//----------------------------showInSnackBar----------------------------------//
  void _showDialog(String value) {
    pr.hide();
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
//------------------------------------------setStatus-------------------------//
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
//----------------------------WaitSnackBar------------------------------------//
  // ignore: non_constant_identifier_names
  void WaitSnackBar(String value) {
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
//---------------------------------UserLoginService---------------------------//
  // ignore: non_constant_identifier_names
  Future<void> UserSignupService() async {
   // WaitSnackBar(GlobalFlag.PleaseWait);
    setState(() {
      // ignore: unnecessary_statements
      _selectedGender.name;
      // ignore: unnecessary_statements
      _Date;
    });
    try {
      http.post(SignuUrl_ServiceUrl, body: {
        "user_token":widget.RecivedToken.toString(),
        "name":LoginNameController.text.toString(),
        "email":LoginEmailController.text.toString(),
        "gender":_selectedGender.name.toString(),
        "dob":_Date,
      }).then((result) {
        setStatus(
            result.statusCode == 200 ? result.body : errMessage);
        print(GlobalFlag.Printjsonresp.toString()+"${result.body.toString()}");
        print("user_token"+widget.RecivedToken.toString(),);
        // ignore: non_constant_identifier_names
        var SignupReciveJsonData = json.decode(result.body);
        // ignore: non_constant_identifier_names
        var SignupReciveJsonSTATUS = SignupReciveJsonData[GlobalFlag.Jsonstatus];
        SignupReciveJsonSTATUSMSG = SignupReciveJsonData["msg"];
        new Preferences().storeDataAtLogin(SignupReciveJsonData);
//----------------------------------------------------------------------------//
        if(SignupReciveJsonSTATUS ==200){
          _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
          LoginMessageSnackBar(SignupReciveJsonSTATUSMSG);
        }else{
          _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
          MessageSnackBar(SignupReciveJsonSTATUSMSG);
        }
//----------------------------------------------------------------------------//
      }).catchError((error) {
        setStatus(error);
      });
    } catch (e) {
      pr.hide();
    }
  }
//----------------------------LoginTrueSnackBar-------------------------------//
  // ignore: non_constant_identifier_names
  void LoginMessageSnackBar(String value) {
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
    _SendHomeScreen();
  }
//----------------------------LoginTrueSnackBar-------------------------------//
  // ignore: non_constant_identifier_names
  void MessageSnackBar(String value) {
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
//-----------------------------_SendHomeScreen--------------------------------//
  // ignore: non_constant_identifier_names
  Future<void> _SendHomeScreen() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new HomeScreen(
    )));
    _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
    // ignore: non_constant_identifier_names
    LoginNameController.clear();
    LoginEmailController.clear();
  }
}
//---------------------------------------END----------------------------------//
//--------------------Service-------------------------------------------------//
class Gender {
  int id;
  String name;
  Gender(this.id, this.name);
  static List<Gender> getCompanies() {
    return <Gender>[
      Gender(1, 'Male'),
      Gender(2, 'Female'),
    ];
  }
}
