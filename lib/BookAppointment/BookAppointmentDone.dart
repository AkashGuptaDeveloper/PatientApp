import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laskinnovita/GlobalComponent/GlobalAppColor.dart';
import 'package:laskinnovita/GlobalComponent/GlobalFlag.dart';
import 'package:laskinnovita/GlobalComponent/GlobalImageAssets.dart';
import 'package:laskinnovita/GlobalComponent/GlobalNavigationRoute.dart';
import 'package:laskinnovita/HomeScreen/HomeScreen.dart';

//----------------------------------------------------------------------------------------------//
class BookAppointmentDone extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagBookAppointmentDone.toString();
  // ignore: non_constant_identifier_names
  final String SendReciveJsonSTATUSMSG;
  // ignore: non_constant_identifier_names
  final String ReciveJsonBookingID;
  BookAppointmentDone({
    Key key,
    // ignore: unnecessary_statements, non_constant_identifier_names
    this.SendReciveJsonSTATUSMSG,
    // ignore: unnecessary_statements, non_constant_identifier_names
    this.ReciveJsonBookingID,
  }) : super(key: key);
  @override
  BookAppointmentDoneState createState() => new BookAppointmentDoneState();
}

//----------------------------------------------------------------------------------------------//
class BookAppointmentDoneState extends State<BookAppointmentDone>
    with SingleTickerProviderStateMixin {
//----------------------------------------------------------------------------------------------//
  @override
  // ignore: must_call_super
  void initState() {
    // ignore: unnecessary_statements
    widget.SendReciveJsonSTATUSMSG;
    // ignore: unnecessary_statements
    widget.ReciveJsonBookingID;
  }

//----------------------------------------------------------------------------------------------------------//
  @override
  void dispose() {
    super.dispose();
  }

//----------------------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: GlobalAppColor.WhiteColorCode,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  widget.SendReciveJsonSTATUSMSG.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: GlobalAppColor.BLackColorCode,
                    fontFamily: GlobalFlag.FontCode,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Your BookingID:  " + widget.ReciveJsonBookingID.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: GlobalAppColor.BLackColorCode,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset(
                  GlobalImageAssets.BookingDone.toString(),
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ],
        ),
//----------------------------------bottomNavigationBar-----------------------//
        bottomNavigationBar: BottomAppBar(
          color: GlobalAppColor.AppBarColorCode,
          child: Container(
              height: 40,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (_) => new HomeScreen()));
                  });
                },
                color: GlobalAppColor.AppBarColorCode,
                textColor: Colors.white,
                child: Text(
                  GlobalFlag.Done.toString(),
                  style: TextStyle(
                      fontSize: 15.0,
                      color: GlobalAppColor.WhiteColorCode,
                      fontWeight: FontWeight.bold,
                      fontFamily: GlobalFlag.FontCode.toString()),
                ),
              )),
        ),
      ),
    );
  }
}
//----------------------------------------------------------------------------------------------//
