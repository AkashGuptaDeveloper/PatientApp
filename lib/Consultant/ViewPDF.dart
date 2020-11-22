import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laskinnovita/GlobalComponent/GlobalAppColor.dart';
import 'package:laskinnovita/GlobalComponent/GlobalFlag.dart';
import 'package:laskinnovita/GlobalComponent/GlobalNavigationRoute.dart';
import 'package:laskinnovita/GlobalComponent/GlobalServiceURL.dart';
import 'package:simple_pdf_viewer/simple_pdf_viewer.dart';
import 'package:flutter_share/flutter_share.dart';
//------------------------------------START-----------------------------------//
class ViewPDF extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagViewPDF.toString();
  // ignore: non_constant_identifier_names
  final String SendappointmentId;
  ViewPDF({
    Key key,
    // ignore: unnecessary_statements, non_constant_identifier_names
    this.SendappointmentId,
  }) : super(key: key);
  @override
  ViewPDFState createState() => new ViewPDFState();
}
//-----------------------------------SplashScreenState------------------------//
class ViewPDFState extends State<ViewPDF> {
  // ignore: non_constant_identifier_names
  final GlobalKey<ScaffoldState> _SnackBarscaffoldKey =
  GlobalKey<ScaffoldState>();
  // ignore: non_constant_identifier_names
  String errMessage = GlobalFlag.ErrorSendData.toString();
  var status;
  // ignore: non_constant_identifier_names
  String PDFViewUrl_ServiceUrl =
  GlobalServiceURL.ViewPDF.toString();
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
//----------------------------------------------------------------------------//
    return Scaffold(
      key: _SnackBarscaffoldKey,
      appBar: new AppBar(
        backgroundColor: GlobalAppColor.AppBarColorCode,
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: Text(
          GlobalFlag.PDFView.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            color: GlobalAppColor.WhiteColorCode,
            fontFamily: GlobalFlag.FontCode,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          new Stack(
            children: <Widget>[
              new IconButton(
                padding: new EdgeInsets.all(15.0),
                icon: new Icon(Icons.close, color: Colors.white,),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
        centerTitle: true,
      ),
      body:SimplePdfViewerWidget(
        completeCallback: (bool result){
          print("completeCallback,result:$result");
        },
        initialUrl: PDFViewUrl_ServiceUrl+"?"+"appointment_id"+"="+widget.SendappointmentId,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: GlobalAppColor.AppBarColorCode,
        child: Container(
          height: 50,
          child: FlatButton.icon(
            onPressed: () {
              setState(() {
                share();
              });
            },
            icon: Icon(
              FontAwesomeIcons.paperPlane,
              color: Colors.white,
              size: 15.0,
            ), //`Icon` to display
            label: Text(GlobalFlag.Share.toString(),
                style: TextStyle(
                  fontFamily: GlobalFlag.FontCode.toString(),
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
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
//------------------------------------------setStatus-------------------------//
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }
}
//---------------------------------------END----------------------------------//
