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
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  Razorpay _razorpay;
  String errMessage = GlobalFlag.ErrorSendData;
  String status = '';
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
        iconTheme: IconThemeData(
            color: Colors.white
        ),
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
      body:new Center(
        child: ListView(
          children: [
           SizedBox(height: 20,),
           new Container(
             padding: EdgeInsets.only(left: 20,right: 20),
             height: 200,
             width: 300,
             color: Colors.grey[200],
             child: Image.asset(
                 GlobalImageAssets.splash,
                 fit:BoxFit.contain
             ),
           ),
          SizedBox(height: 20,),
          new Container(
            padding: EdgeInsets.only(left: 20,right: 20),
            color: GlobalAppColor.AppBarColorCode,
            child: Container(
              height:50,
              width: 300,
              child: FlatButton.icon(
                onPressed: () {
                  setState(() {});
                  openCheckout();
                 /* Navigator.of(context).push(new MaterialPageRoute(
                      builder: (_) => new ConsultantScreen2()));*/
                },
                icon: Icon(FontAwesomeIcons.save,color: Colors.white,size: 15.0,), //`Icon` to display
                label: Text(GlobalFlag.Continue.toString().toUpperCase(),style: TextStyle(fontFamily: GlobalFlag.FontCode.toString(),fontSize: 15.0, color: Colors.white,fontWeight: FontWeight.bold,)),
              ),
            ),
          ),
          ],
        )
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
//-----------------------------------------openCheckout()-----------------------------------------------------//
  void openCheckout() async {
    var PckageAmount = 100;
    var TotalAmount = 100.0;
    // print(TotalAmount);
    var options = {
      'key': GlobalServiceURL.RazorPayAPIKey.toString(),
      'amount': TotalAmount * 100,
      'name': "Akash".toString(),
      'description': "Buy".toString(),
      'prefill': {
        'contact': "7987574875".toString(),
        'email': "gupta.akash555@gmail.com".toString()
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }
//-----------------------------------------_handlePaymentSuccess()-----------------------------------------------------//
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIos: 4);
   /* GetPaymentID = response.paymentId;
    OnPayMentSuccessSendToServer();
    _PayMentSuccessAlert();*/
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (_) => new ConsultantScreen2()));
  }

//-----------------------------------------_handlePaymentError()-----------------------------------------------------//
  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIos: 4);
   /* GetPaymentErrorCode = response.message;
    OnPayMentFailedSendToServer();
    _PayMentFailedAlert();*/
  }

//-----------------------------------------_handleExternalWallet()--------------------------------------------------//
  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }
}
//---------------------------------------END----------------------------------//
