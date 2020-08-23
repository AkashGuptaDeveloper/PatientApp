//--------------------------Import-Library------------------------------------//
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laskinnovita/GlobalComponent/GlobalAppColor.dart';
import 'package:laskinnovita/routes.dart';
//---------------------------Create-mainMethod--------------------------------//
void main() => runApp(new MyApp());
Map<int, Color> color = {
  50: Color.fromRGBO(99, 192, 207, .1),
  100: Color.fromRGBO(99, 192, 207, .2),
  200: Color.fromRGBO(99, 192, 207, .3),
  300: Color.fromRGBO(99, 192, 207, .4),
  400: Color.fromRGBO(99, 192, 207, .5),
  500: Color.fromRGBO(99, 192, 207, .6),
  600: Color.fromRGBO(99, 192, 207, .7),
  700: Color.fromRGBO(99, 192, 207, .8),
  800: Color.fromRGBO(99, 192, 207, .9),
  900: Color.fromRGBO(99, 192, 207, 10),
};
//---------------------------------StatelessWidget----------------------------//
class MyApp extends StatelessWidget {
//----------------------------Genrated-Widget build---------------------------//
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor:GlobalAppColor.AppBarColorCode));
    MaterialColor colorCustom = MaterialColor(0xFFffffff, color);
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: colorCustom,
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}
//---------------------------END-----------------------------------------------//
