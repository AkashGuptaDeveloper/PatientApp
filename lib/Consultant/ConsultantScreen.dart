import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laskinnovita/Consultant/ConsultantScreen2.dart';
import 'package:laskinnovita/GlobalComponent/GlobalAppColor.dart';
import 'package:laskinnovita/GlobalComponent/GlobalFlag.dart';
import 'package:laskinnovita/GlobalComponent/GlobalImageAssets.dart';
import 'package:laskinnovita/GlobalComponent/GlobalNavigationRoute.dart';
import 'package:laskinnovita/GlobalComponent/GlobalServiceURL.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:laskinnovita/Preferences/Preferences.dart';
//------------------------------------START-----------------------------------//
class ConsultantScreen extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagConsultantScreen.toString();
  @override
  ConsultantScreenState createState() => new ConsultantScreenState();
}
//-----------------------------------SplashScreenState------------------------//
class ConsultantScreenState extends State<ConsultantScreen> {
  // ignore: non_constant_identifier_names
  final GlobalKey<ScaffoldState> _SnackBarscaffoldKey =
      GlobalKey<ScaffoldState>();
  // ignore: non_constant_identifier_names
  Razorpay _razorpay;
  // ignore: non_constant_identifier_names
  String errMessage = GlobalFlag.ErrorSendData;
  String status = '';
  // ignore: non_constant_identifier_names
  var GetPaymentID;
  // ignore: non_constant_identifier_names
  var GetPaymentsignature;
  // ignore: non_constant_identifier_names
  var GetPaymentorderId;
  // ignore: non_constant_identifier_names
  var LoginUserToken;
  var name;
  var contact;
  var email;
//------------------------------------API-------------------------------------//
  // ignore: non_constant_identifier_names
  String UserViewProfile_ServiceUrl =
  GlobalServiceURL.ProfileView.toString();
//-----------------------------------initState--------------------------------//
  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
//-----------------------------------------dispose()--------------------------//
  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }
//------------------------------------Widget build----------------------------//
  @override
  Widget build(BuildContext context) {
//----------------------------------------------------------------------------//
    return Scaffold(
      key: _SnackBarscaffoldKey,
      appBar: new AppBar(
        backgroundColor: GlobalAppColor.AppBarColorCode,
        iconTheme: IconThemeData(color: Colors.white),
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
      body: new Center(
          child: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          new Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 200,
            width: 300,
            color: Colors.grey[200],
            child: Image.asset(GlobalImageAssets.splash, fit: BoxFit.contain),
          ),
          SizedBox(
            height: 20,
          ),
          new Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            color: GlobalAppColor.AppBarColorCode,
            child: Container(
              height: 50,
              width: 300,
              child: FlatButton.icon(
                onPressed: () {
                  setState(() {});
                  openCheckout();
                  /* Navigator.of(context).push(new MaterialPageRoute(
                      builder: (_) => new ConsultantScreen2()));*/
                },
                icon: Icon(
                  FontAwesomeIcons.save,
                  color: Colors.white,
                  size: 15.0,
                ), //`Icon` to display
                label: Text(GlobalFlag.Continue.toString().toUpperCase(),
                    style: TextStyle(
                      fontFamily: GlobalFlag.FontCode.toString(),
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
        ],
      )),
      backgroundColor: Colors.white,
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
//-----------------------------------------openCheckout()---------------------//
  void openCheckout() async {
    setState(() {
      // ignore: unnecessary_statements
      name;
      // ignore: unnecessary_statements
      email;
      // ignore: unnecessary_statements
      contact;
    });
    var options = {
      'key': GlobalServiceURL.RazorPayAPIKey.toString(),
      'amount': 1000,
      'name': name.toString(),
      'description': "Buy".toString(),
      'prefill': {
        'contact': contact.toString(),
        'email': email.toString()
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      /*  debugPrint(e);*/
    }
  }
//-----------------------------------------_handlePaymentSuccess()------------//
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIos: 4);
    GetPaymentID = response.paymentId;
    GetPaymentsignature = response.signature;
    GetPaymentorderId = response.orderId;
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (_) => new ConsultantScreen2(
              SendGetPaymentID: GetPaymentID,
              SenGetPaymentsignature: GetPaymentsignature,
              SenGetPaymentorderId: GetPaymentorderId,
            )));
  }
//-----------------------------------------_handlePaymentError()--------------//
  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIos: 4);
  }
//-----------------------------------------_handleExternalWallet()------------//
  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
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
//------------------------------------------setStatus-------------------------//
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
}
//---------------------------------------END----------------------------------//
