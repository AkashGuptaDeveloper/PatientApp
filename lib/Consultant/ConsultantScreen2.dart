import 'dart:async';
import 'dart:developer';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laskinnovita/GlobalComponent/GlobalAppColor.dart';
import 'package:laskinnovita/GlobalComponent/GlobalFlag.dart';
import 'package:laskinnovita/GlobalComponent/GlobalNavigationRoute.dart';
//------------------------------------START-----------------------------------//
class ConsultantScreen2 extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagConsultantScreen2.toString();
  @override
  ConsultantScreen2State createState() => new ConsultantScreen2State();
}
//-----------------------------------SplashScreenState------------------------//
class ConsultantScreen2State extends State<ConsultantScreen2> {
  final GlobalKey<ScaffoldState> _SnackBarscaffoldKey =
  GlobalKey<ScaffoldState>();
//-------------------------------Consultant-----------------------------------//
  List<Consultant> _Consultant = Consultant.getCompanies();
  List<DropdownMenuItem<Consultant>> _dropdownMenuItemsConsultant;
  Consultant _selectedConsultant;
  // ignore: non_constant_identifier_names
  TextEditingController DetailsController = new TextEditingController();
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> _LoginFormkey = new GlobalKey();
  // ignore: non_constant_identifier_names
  final FocusNode myFocusNodeDetails = FocusNode();
  var Details;
//-----------------------------------initState--------------------------------//
  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity();
//-------------------------------------Consultant-----------------------------//
    _dropdownMenuItemsConsultant = buildDropdownMenuItemsConsultant(_Consultant);
    _selectedConsultant = _dropdownMenuItemsConsultant[0].value;
  }
//---------------------------------buildDropdownMenuItemsService--------------//
  List<DropdownMenuItem<Consultant>> buildDropdownMenuItemsConsultant(List consultant) {
    List<DropdownMenuItem<Consultant>> items = List();
    for (Consultant consultant in consultant) {
      items.add(
        DropdownMenuItem(
          value: consultant,
          child: Container(
            margin: EdgeInsets.only(left:5),
            child: Text(consultant.name,style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: GlobalFlag.FontCode,
              fontWeight: FontWeight.w600,
            ),),
          ),
        ),
      );
    }
    return items;
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
      body:new ListView(
        children: <Widget>[
//----------------------------Consultant--------------------------------------//
          Container(
            padding: EdgeInsets.only(left: 10,right: 10,top:10),
            child: Text(
              GlobalFlag.Consultant.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: GlobalFlag.FontCode,
                fontWeight: FontWeight.w600,),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10,right: 10,top:10),
            child: new Container(
              decoration: new BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(0.0)),
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
            padding: EdgeInsets.only(left: 10,right: 10,top:10),
            child: Text(
              GlobalFlag.Details.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: GlobalFlag.FontCode,
                fontWeight: FontWeight.w600,),
            ),
          ),
          new Container(
            padding: EdgeInsets.only(left:10, right: 10,top:10),
            child: new TextFormField(
              style: TextStyle(color: GlobalAppColor.AppBarColorCode),
              focusNode: myFocusNodeDetails,
              controller: DetailsController,
              /*validator: validateUserMobile,*/
              textInputAction: TextInputAction.done,
              maxLines: 3,
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
                    borderSide:
                    BorderSide(width: 1, color: Colors.black)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.grey)),
                errorStyle: TextStyle(fontSize: 10.0, color: Colors.grey),
                hintText: GlobalFlag.EnterDetails.toString(),
                hintStyle: TextStyle(
                  fontSize: 14.0,
                  fontFamily: GlobalFlag.FontCode.toString(),
                  color: GlobalAppColor.BLackColorCode,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: GlobalAppColor.AppBarColorCode,
        child:Container(
          height:50,
          child: FlatButton.icon(
            onPressed: () {
              setState(() {});
              /*_sendToServer();*/
            },
            icon: Icon(FontAwesomeIcons.save,color: Colors.white,size: 15.0,), //`Icon` to display
            label: Text(GlobalFlag.Submit.toString().toUpperCase(),style: TextStyle(fontFamily: GlobalFlag.FontCode.toString(),fontSize: 15.0, color: Colors.white,fontWeight: FontWeight.bold,)),
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
      Service(2, 'Family'),
      Service(3, 'Friends'),
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
