//--------------------------Import-Library------------------------------------//
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laskinnovita/GlobalComponent/GlobalAppColor.dart';
import 'package:laskinnovita/GlobalComponent/GlobalFlag.dart';
import 'package:laskinnovita/GlobalComponent/GlobalImageAssets.dart';
import 'package:laskinnovita/GlobalComponent/GlobalNavigationRoute.dart';
import 'package:laskinnovita/GlobalComponent/GlobalServiceURL.dart';
import 'package:laskinnovita/LoginView/MobileOtp.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
//------------------------------------START-----------------------------------//
class LoginView extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagLoginView.toString();
  @override
  LoginViewState createState() => new LoginViewState();
}
//-----------------------------------SplashScreenState------------------------//
class LoginViewState extends State<LoginView> {
  // ignore: non_constant_identifier_names
  TextEditingController LoginMobileController = new TextEditingController();
  // ignore: non_constant_identifier_names
  var GetMobile;
  // ignore: non_constant_identifier_names
  String Mobile;
  // ignore: non_constant_identifier_names
  String status = '';
  // ignore: non_constant_identifier_names
  String errMessage = GlobalFlag.ErrorSendData.toString();
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> _LoginFormkey = new GlobalKey();
  // ignore: non_constant_identifier_names
  bool _validate = false;
  // ignore: non_constant_identifier_names
  final FocusNode myFocusNodeMobile = FocusNode();
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
//-----------------------------------------API--------------------------------//
  // ignore: non_constant_identifier_names
  String LoginUrl_ServiceUrl =
  GlobalServiceURL.LoginApiUrl.toString();
//-----------------------------------initState--------------------------------//
  @override
  void initState() {
    super.initState();
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
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFieldFormates(),
                  FormBtnLogin(),
                  SizedBox(height:15.0,),
                ],
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FormLogo(),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
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
//-------------------------------------------------Email----------------------//
                new Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: new TextFormField(
                    style: TextStyle(color: GlobalAppColor.AppBarColorCode),
                    focusNode: myFocusNodeMobile,
                    controller: LoginMobileController,
                    validator: validateUserMobile,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    onSaved: (String val) {
                      Mobile = val;
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
                      hintText:GlobalFlag.EnterMobileNumber.toString(),
                      hintStyle: TextStyle(
                        fontSize: 12.0,
                        fontFamily: GlobalFlag.FontCode.toString(),
                        color: GlobalAppColor.BLackColorCode,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height:5,
                ),
//-------------------------------------------------Submit---------------------//
              ],
            ),
          ),
        ),
      ],
    );
  }
//--------------------------validateUserMobile--------------------------------//
  String validateUserMobile(String value) {
    String patttern = GlobalFlag.PattternNumber.toString();
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return GlobalFlag.MobileisRequired.toString();
    } else if (value.length != 10) {
      return GlobalFlag.Mobilenumbermust10digits.toString();
    } else if (!regExp.hasMatch(value)) {
      return GlobalFlag.MobileNumbermustbedigits.toString();
    }
    return null;
  }
//------------------------------------FormBtnLogin----------------------------//
  // ignore: non_constant_identifier_names
  Widget FormBtnLogin() {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Container(
          child: SizedBox(
            width: double.infinity, // match_parent
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: GlobalAppColor.AppBarColorCode)),
              onPressed: () {
                setState(() {
                  _LoginSendToServer();
                });
              },
              color: GlobalAppColor.AppBarColorCode,
              textColor: Colors.white,
              child: Text(
                GlobalFlag.Login.toString(),
                style: TextStyle(
                    fontSize: 20.0,
                    color: GlobalAppColor.WhiteColorCode,
                    fontWeight: FontWeight.bold,
                    fontFamily: GlobalFlag.FontCode.toString()),
              ),
            ),
          ),
        ));
  }
//----------------------------------------_LoginSendToServer------------------//
  // ignore: non_constant_identifier_names
  _LoginSendToServer() async {
    if (_LoginFormkey.currentState.validate()) {
      _LoginFormkey.currentState.save();
      setState(() {
        // ignore: non_constant_identifier_names
        GetMobile = LoginMobileController.text.toString();
        _checkInternetConnectivity();
      });
    }
    else {
      setState(() {
        _validate = true;
      });
    }
  }
  //-------------------------------------------------_onBackPressed------------//
  // ignore: non_constant_identifier_names
  Future<bool> _BackPressed() {
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
//-------------------------------------------_checkInternetConnectivity-------//
  void _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog(GlobalFlag.InternetNotConnected);
    }
    else{
      UserLoginService(GetMobile);
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
  Future<void> UserLoginService(GetMobile) async {
    WaitSnackBar(GlobalFlag.PleaseWait);
    setState(() {
      // ignore: unnecessary_statements
      GetMobile;
    });
    try {
      http.post(LoginUrl_ServiceUrl, body: {
        "mobile": GetMobile.toString(),
        "type": "patient".toString(),
      }).then((resultLogin) {
        setStatus(
            resultLogin.statusCode == 200 ? resultLogin.body : errMessage);
       //print(GlobalFlag.Printjsonresp.toString()+"${resultLogin.body.toString()}");
        // ignore: non_constant_identifier_names
        var LoginReciveJsonData = json.decode(resultLogin.body);
        // ignore: non_constant_identifier_names
        var LoginReciveJsonSTATUS = LoginReciveJsonData[GlobalFlag.Jsonstatus];
        LoginReciveJsonSTATUSMSG = LoginReciveJsonData[GlobalFlag.Jsonmsg];
        LoginReciveTransactionId = LoginReciveJsonData[GlobalFlag.transaction_id];
        LoginRecivemobile = LoginReciveJsonData[GlobalFlag.mobile];
//----------------------------------------------------------------------------//
        if(LoginReciveJsonSTATUS ==200){
          _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
          LoginMessageSnackBar(LoginReciveJsonSTATUSMSG);
        }else{
          _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
          LoginMessageSnackBar(LoginReciveJsonSTATUSMSG);
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
//-----------------------------_SendHomeScreen--------------------------------//
  // ignore: non_constant_identifier_names
  Future<void> _SendHomeScreen() async {
    await Future.delayed(Duration(seconds: 2));
     Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new MobileOtp(
         LoginTransactionId:LoginReciveTransactionId,
         LoginMobile:LoginRecivemobile,
     )));
    _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
    // ignore: non_constant_identifier_names
    LoginMobileController.clear();
  }
}
//---------------------------------------END----------------------------------//
