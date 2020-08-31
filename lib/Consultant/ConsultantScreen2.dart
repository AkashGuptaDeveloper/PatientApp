import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laskinnovita/GlobalComponent/GlobalAppColor.dart';
import 'package:laskinnovita/GlobalComponent/GlobalFlag.dart';
import 'package:laskinnovita/GlobalComponent/GlobalNavigationRoute.dart';
import 'package:async/async.dart';
import 'package:laskinnovita/GlobalComponent/GlobalServiceURL.dart';
import 'package:path/path.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:laskinnovita/BookAppointment/BookAppointmentDone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:laskinnovita/Preferences/Preferences.dart';
//------------------------------------START-----------------------------------//
class ConsultantScreen2 extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagConsultantScreen2.toString();
  // ignore: unnecessary_statements, non_constant_identifier_names
  final String SendGetPaymentID;
  // ignore: unnecessary_statements, non_constant_identifier_names
  final String SenGetPaymentsignature;
  // ignore: unnecessary_statements, non_constant_identifier_names
  final String SenGetPaymentorderId;
  ConsultantScreen2({
    Key key,
    // ignore: unnecessary_statements, non_constant_identifier_names
    this.SendGetPaymentID,
    // ignore: unnecessary_statements, non_constant_identifier_names
    this.SenGetPaymentsignature,
    // ignore: unnecessary_statements, non_constant_identifier_names
    this.SenGetPaymentorderId,
  }) : super(key: key);
  @override
  ConsultantScreen2State createState() => new ConsultantScreen2State();
}

//-----------------------------------SplashScreenState------------------------//
class ConsultantScreen2State extends State<ConsultantScreen2> {
  // ignore: non_constant_identifier_names
  final GlobalKey<ScaffoldState> _SnackBarscaffoldKey =
      GlobalKey<ScaffoldState>();
//-------------------------------Consultant-----------------------------------//
  // ignore: non_constant_identifier_names
  List<Consultant> _Consultant = Consultant.getCompanies();
  List<DropdownMenuItem<Consultant>> _dropdownMenuItemsConsultant;
  Consultant _selectedConsultant;
  // ignore: non_constant_identifier_names
  TextEditingController DetailsController = new TextEditingController();
  // ignore: non_constant_identifier_names
  final FocusNode myFocusNodeDetails = FocusNode();
  // ignore: unnecessary_statements, non_constant_identifier_names
  var Details;
  File _image;
  ImageProvider provider;
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> _Formkey = new GlobalKey();
  bool _validate = false;
  // ignore: non_constant_identifier_names
  String errMessage = GlobalFlag.ErrorSendData.toString();
  var status;
  // ignore: non_constant_identifier_names
  var ReciveJsonSTATUSMSG;
  // ignore: non_constant_identifier_names
  var ReciveJsonBookingID;
  // ignore: non_constant_identifier_names
  String BookingConsultantUrl_ServiceUrl =
      GlobalServiceURL.ConsultantBookingUrl.toString();
  // ignore: non_constant_identifier_names
  var LoginUserToken;
//-----------------------------------initState--------------------------------//
  @override
  void initState() {
    super.initState();
    /* _checkInternetConnectivity();*/
//-------------------------------------Consultant-----------------------------//
    _dropdownMenuItemsConsultant =
        buildDropdownMenuItemsConsultant(_Consultant);
    _selectedConsultant = _dropdownMenuItemsConsultant[0].value;
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
      body: new Form(
        key: _Formkey,
        autovalidate: _validate,
        child: new ListView(
          children: <Widget>[
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
            new Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: new TextFormField(
                style: TextStyle(color: GlobalAppColor.AppBarColorCode),
                focusNode: myFocusNodeDetails,
                controller: DetailsController,
                validator: validateUserDetails,
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
                      borderSide: BorderSide(width: 1, color: Colors.black)),
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
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Camera(context),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: GlobalAppColor.AppBarColorCode,
        child: Container(
          height: 50,
          child: FlatButton.icon(
            onPressed: () {
              setState(() {});
              BookendToServer(context);
            },
            icon: Icon(
              FontAwesomeIcons.save,
              color: Colors.white,
              size: 15.0,
            ), //`Icon` to display
            label: Text(GlobalFlag.Submit.toString().toUpperCase(),
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
  void _checkInternetConnectivity(BuildContext context) async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog(GlobalFlag.InternetNotConnected, context);
    }
  }

//----------------------------showInSnackBar----------------------------------//
  void _showDialog(String value, BuildContext context) {
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

//------------------------------Camera----------------------------------------//
  // ignore: non_constant_identifier_names
  Widget Camera(BuildContext context) {
    return new Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _openImagePickerModal(context);
          },
          child: Container(
            child: new Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFEF8C2B),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.all(Radius.circular(
                        10.0) //                 <--- border radius here
                    ),
              ),
              height: 200,
              child: Card(
                margin: new EdgeInsets.only(
                    left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: _image == null
                    ? Image.network(GlobalServiceURL.NoImagesUrl.toString())
                    : Image.file(_image),
              ),
            ),
          ),
        ),
      ],
    );
  }

//----------------_openImagePickerModal---------------------------------------//
  // ignore: non_constant_identifier_names
  void _openImagePickerModal(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  GlobalFlag.CameraString,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: GlobalFlag.FontCode.toString(),
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text(
                    GlobalFlag.UseCamera.toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: GlobalFlag.FontCode.toString(),
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0,
                      color: GlobalAppColor.BLackColorCode,
                    ),
                  ),
                  onPressed: () {
                    {
                      Navigator.of(context).pop();
                      _pickImage(ImageSource.camera);
                    }
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text(GlobalFlag.UseGallery.toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: GlobalFlag.FontCode.toString(),
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0,
                        color: GlobalAppColor.BLackColorCode,
                      )),
                  onPressed: () {
                    {
                      Navigator.of(context).pop();
                      _pickImage(ImageSource.gallery);
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

//---------------------------------_pickImage---------------------------------//
  void _pickImage(ImageSource source) async {
    try {
      // ignore: deprecated_member_use
      _image = await ImagePicker.pickImage(
          source: source, maxHeight: 250, maxWidth: 250);
      if (_image == null || _image.path == null) {
        return;
      }
      var tmpDir = await path_provider.getTemporaryDirectory();
      var targetName = DateTime.now().millisecondsSinceEpoch;
      File compressFile = await FlutterImageCompress.compressAndGetFile(
        _image.path,
        "${tmpDir.absolute.path}/$targetName.jpg",
        quality: 10,
        minWidth: 100,
        minHeight: 100,
      );
      if (compressFile != null) {
        this.provider = FileImage(compressFile);
      }
    } catch (e) {}
    setState(() {
      _cropImage();
    });
  }

//--------------------------------_cropImage---------------------------------//
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: GlobalAppColor.AppBarColorCode,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    setState(() {
      _image = cropped;
    });
  }

//----------------MemberAddService--------------------------------------------//
//----------------------------------------_sendToServer-----------------------//
  // ignore: non_constant_identifier_names
  BookendToServer(BuildContext context) async {
    if (_Formkey.currentState.validate()) {
      _Formkey.currentState.save();
      setState(() {
        if (_image != null) {
          BookCounsltantService(_image, context);
          WaitSnackBar(GlobalFlag.PleaseWait, context);
        } else {
          PicFalseSnackBar(GlobalFlag.PleaseUploadPicture, context);
        }
      });
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  //----------------------------ProfilePicFalseSnackBar-------------------------//
  // ignore: non_constant_identifier_names
  void PicFalseSnackBar(String value, BuildContext context) {
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

  //----------------------------WaitSnackBar------------------------------------//
  // ignore: non_constant_identifier_names
  void WaitSnackBar(String value, BuildContext context) {
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

  // ignore: non_constant_identifier_names
  //----------------------------WaitSnackBar------------------------------------//
  // ignore: non_constant_identifier_names
  BookCounsltantService(File _image, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginUserToken = prefs.getString(Preferences.KEY_USER_token).toString();
    _checkInternetConnectivity(context);
    setState(() {
      // ignore: unnecessary_statements
      _selectedConsultant.name;
      // ignore: unnecessary_statements
      widget.SendGetPaymentID;
    });
// open a bytestream
    var stream = new http.ByteStream(
        // ignore: deprecated_member_use
        DelegatingStream.typed(_image.openRead()));
    // get file length
    var length = await _image.length();
    // string to uri
    var uri = Uri.parse(BookingConsultantUrl_ServiceUrl);
    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    request.fields['user_token'] =LoginUserToken.toString();
    request.fields['question'] = DetailsController.text.toString();
    request.fields['type'] = "consultation".toString();
    request.fields['patient'] = _selectedConsultant.name.toString();
    request.fields['payment_id'] = widget.SendGetPaymentID.toString();
    request.fields['payment_status'] = "1".toString();
    // multipart that takes file
    var multipartFile = new http.MultipartFile('photos', stream, length,
        filename: basename(_image.path));
    // add file to multipart
    request.files.add(multipartFile);
    // send
    var response = await request.send();
    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      // ignore: non_constant_identifier_names
      var ReciveJsonData = json.decode(value);
      // ignore: non_constant_identifier_names
      var ReciveJsonSTATUS = ReciveJsonData[GlobalFlag.Jsonstatus];
      ReciveJsonSTATUSMSG = ReciveJsonData[GlobalFlag.Jsonmsg];
      ReciveJsonBookingID = ReciveJsonData[GlobalFlag.appointmentID];
      if (ReciveJsonSTATUS == 200) {
        setState(() {
          _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
          _SendBookAppointmentDone(context);
        });
      } else {
        setState(() {
          _SnackBarscaffoldKey.currentState.hideCurrentSnackBar();
          BookAddedFailedSnackBar(ReciveJsonSTATUSMSG, context);
        });
      }
    });
  }

  //----------------------------BatchAddedFailedSnackBar------------------------//
// ignore: non_constant_identifier_names
  void BookAddedFailedSnackBar(String value, BuildContext context) {
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

//-----------------------------BookAppointmentDone----------------------------//
  // ignore: non_constant_identifier_names
  Future<void> _SendBookAppointmentDone(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    var route = new MaterialPageRoute(
      builder: (BuildContext context) => new BookAppointmentDone(
        SendReciveJsonSTATUSMSG: ReciveJsonSTATUSMSG,
        ReciveJsonBookingID: ReciveJsonBookingID.toString(),
      ),
    );
    Navigator.of(context).push(route);
  }

//----------------------validateDetails------------------------------------//
  String validateUserDetails(String value) {
    String patttern = r'';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return GlobalFlag.DetailsisRequired.toString();
    } else if (!regExp.hasMatch(value)) {
      return GlobalFlag.DetailsmustbeNeed.toString();
    }
    return null;
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
