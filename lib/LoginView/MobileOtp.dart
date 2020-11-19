//--------------------------Import-Library------------------------------------//
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laskinnovita/GlobalComponent/GlobalAppColor.dart';
import 'package:laskinnovita/GlobalComponent/GlobalFlag.dart';
import 'package:laskinnovita/GlobalComponent/GlobalImageAssets.dart';
import 'package:laskinnovita/GlobalComponent/GlobalNavigationRoute.dart';
import 'package:laskinnovita/GlobalComponent/GlobalServiceURL.dart';
import 'package:laskinnovita/HomeScreen/HomeScreen.dart';
import 'package:laskinnovita/Preferences/Preferences.dart';
import 'package:laskinnovita/Signup/Signup.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:sms_autofill/sms_autofill.dart';
//------------------------------------START-----------------------------------//
class MobileOtp extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagMobileOtp.toString();
  // ignore: unnecessary_statements, non_constant_identifier_names
  final String LoginTransactionId;
  // ignore: unnecessary_statements, non_constant_identifier_names
  final String LoginMobile;
  // ignore: non_constant_identifier_names
  final String LoginSendName;
  final String LoginGetSmsKey;
  MobileOtp({
    Key key,
    // ignore: unnecessary_statements, non_constant_identifier_names
    this.LoginTransactionId,
    // ignore: unnecessary_statements, non_constant_identifier_names
    this.LoginMobile,
    // ignore: non_constant_identifier_names
    this.LoginSendName,
    this.LoginGetSmsKey,
  }) : super(key: key);
  @override
  MobileOtpState createState() => new MobileOtpState();
}
//-----------------------------------SplashScreenState------------------------//
class MobileOtpState extends State<MobileOtp> {
  // ignore: non_constant_identifier_names
  TextEditingController controller = TextEditingController();
  int pinLength = 6;
  bool hasError = false;
  // ignore: non_constant_identifier_names
  final GlobalKey<ScaffoldState> _SnackBarscaffoldKey =
  GlobalKey<ScaffoldState>();
  // ignore: non_constant_identifier_names
  var RecivedConfirmPin;
  // ignore: non_constant_identifier_names
  var RecivedMessage;
  // ignore: non_constant_identifier_names
  var RecivedToken;
  // ignore: non_constant_identifier_names
  ProgressDialog pr;
  var status;
  // ignore: non_constant_identifier_names
  String errMessage = GlobalFlag.ErrorSendData.toString();
  // ignore: non_constant_identifier_names
  var LoginTrueFalse;
  String _code;
  String signature = "{{ app signature }}";
  bool GetOtp = false;
  bool LoginSubmit = false;
//-----------------------------------------API--------------------------------//
  // ignore: non_constant_identifier_names
  String OTP_ServiceUrl =
  GlobalServiceURL.OTPUrl.toString();
//-----------------------------------initState--------------------------------//
  @override
  void initState() {
    super.initState();
    signature =widget.LoginGetSmsKey;
    GetOtp = true;
    LoginSubmit = false;
  }
//-----------------------------------------dispose()---------------------------//
  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }
//------------------------------------Widget build----------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _SnackBarscaffoldKey,
      body: Form(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FormPinPut(),
                SizedBox(height:5.0,),
                Visibility(
                  visible:LoginSubmit,
                  child:FormLogin(),
                ),
                Visibility(
                  visible:GetOtp,
                  child:FormGetOtp(),
                ),
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
              /*width: 300,
                height: 300,*/
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
//---------------------------------------------------FormPinPut---------------//
  // ignore: non_constant_identifier_names
  Widget FormPinPut() {
    return new Column(
      children: <Widget>[
        new Container(
          child: Center(
            child:PinFieldAutoFill(
              decoration: UnderlineDecoration(
                textStyle: TextStyle(fontSize: 20, color: Colors.black),
                colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
              ),
              currentCode: _code,
              onCodeSubmitted: (code) {},
              onCodeChanged: (code) {
                if (code.length == 6) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  GetOtp = false;
                  LoginSubmit = true;
                }
              },
            ),
          ),
        ),
      ],
    );
  }
//-------------------------------------------_checkInternetConnectivity-------//
  void _checkInternetConnectivity() async {
    WaitSnackBar(GlobalFlag.PleaseWait);
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog(GlobalFlag.InternetNotConnected);
    } else {
      setState(() {
        OTPService(signature);
        /*// ignore: unnecessary_statements
        RecivedConfirmPin;
        if(RecivedConfirmPin == null){
          _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
          PinBlankSnackBar(GlobalFlag.PleaseEnterPin);
        }else{
          setState(() {
            OTPService(RecivedConfirmPin);
          });
        }*/
      });

    }
  }
//----------------------------LoginTrueSnackBar-------------------------------//
  // ignore: non_constant_identifier_names
  void PinBlankSnackBar(String value) {
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
//------------------------------FetchTimeFromServer--------------------------//
  // ignore: non_constant_identifier_names, missing_return
  Future<void> OTPService(signature) async {
    setState(() {
      // ignore: unnecessary_statements
      widget.LoginMobile;
      // ignore: unnecessary_statements
      widget.LoginTransactionId;
      // ignore: unnecessary_statements
      signature;
    });
    //we have to wait to get the data so we use 'await'
    http.Response response = await http.get(
      //Uri.encodeFull removes all the dashes or extra characters present in our Uri
        Uri.encodeFull(OTP_ServiceUrl + "?otp="+signature+"&mobile="+widget.LoginMobile+"&transaction_id="+widget.LoginTransactionId),
        headers: {
          //if your api require key then pass your key here as well e.g "key": "my-long-key"
          "Accept": "application/json"
        });
    // ignore: non_constant_identifier_names
    var LoginReciveJsonData = json.decode(response.body);
    print(LoginReciveJsonData);
    // ignore: non_constant_identifier_names
    var LoginReciveJsonSTATUS = LoginReciveJsonData[GlobalFlag.Jsonstatus];
    // ignore: non_constant_identifier_names
    LoginTrueFalse = LoginReciveJsonData[GlobalFlag.Jsonlogin];
    // ignore: non_constant_identifier_names
    RecivedMessage = LoginReciveJsonData[GlobalFlag.Jsonmsg];
    RecivedToken = LoginReciveJsonData[GlobalFlag.Jsonuser_token];
    new Preferences().storeDataAtLogin(LoginReciveJsonData);
//----------------------------------------------------------------------------//
    if(LoginReciveJsonSTATUS ==200){
      _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
      OTPMessageSnackBar(RecivedMessage);
    }else{
      _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
      OTPFalseMessageSnackBar(RecivedMessage);
    }
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
//------------------------------------FormBtnPinLogin--------------------------//
  // ignore: non_constant_identifier_names
  Widget FormLogin() {
    return Container(
        padding: EdgeInsets.only(left: 100.0, right: 100.0),
        child: Container(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: GlobalAppColor.AppBarColorCode)),
            onPressed: () {
              setState(() {
                if (_code.length == 6) {
                  print("ss");
                  _checkInternetConnectivity();
                }else{
                  print("false");
                }
                /*_checkInternetConnectivity();*/
              });
            },
            color: GlobalAppColor.AppBarColorCode,
            textColor: Colors.white,
            child: Text(
              "Verify OTP".toString(),
              style: TextStyle(
                  fontSize: 20.0,
                  color: GlobalAppColor.WhiteColorCode,
                  fontWeight: FontWeight.bold,
                  fontFamily: GlobalFlag.FontCode.toString()),
            ),
          ),
        ));
  }
//------------------------------------FormBtnPinLogin--------------------------//
  // ignore: non_constant_identifier_names
  Widget FormGetOtp() {
    return Container(
        padding: EdgeInsets.only(left: 100.0, right: 100.0),
        child: Container(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: GlobalAppColor.AppBarColorCode)),
            onPressed: () {
              setState(() {
                _code = signature;
              });
            },
            color: GlobalAppColor.AppBarColorCode,
            textColor: Colors.white,
            child: Text(
              "Get OTP".toString(),
              style: TextStyle(
                  fontSize: 20.0,
                  color: GlobalAppColor.WhiteColorCode,
                  fontWeight: FontWeight.bold,
                  fontFamily: GlobalFlag.FontCode.toString()),
            ),
          ),
        ));
  }
//----------------------------WaitSnackBar------------------------------------//
  // ignore: non_constant_identifier_names
  void OTPMessageSnackBar(String value) {
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
      CheckLogin();
    });
  }
//----------------------------WaitSnackBar------------------------------------//
  // ignore: non_constant_identifier_names
  void OTPFalseMessageSnackBar(String value) {
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
//------------------------------CheckLoginType--------------------------------//\
  // ignore: non_constant_identifier_names
  void CheckLogin()async{
    // ignore: unnecessary_statements
    LoginTrueFalse;
    if(LoginTrueFalse ==true){
      await Future.delayed(Duration(seconds: 2));
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (_) => new HomeScreen()));
    }
    else{
      await Future.delayed(Duration(seconds: 2));
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (_) => new Signup(
        RecivedToken:RecivedToken,
        LoginSendName:widget.LoginSendName,
      )));
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