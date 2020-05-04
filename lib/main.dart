import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neodove/HomeFile.dart';
import 'package:neodove/MyColors.dart';
import 'package:neodove/SigninFile.dart';
import 'package:neodove/Utils/StringConstants.dart';

import 'Utils/PrefrencesManager.dart';

void main() { runApp(MyApp());}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}

class SplashScreenState extends State<MyApp>{
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyColors.bg_color
    ));
    return MaterialApp(
        navigatorKey: _navigator,
        home:  Container(height: double.infinity,width: double.infinity,color: MyColors.bg_color,padding:
      EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
    child: Center(child: Image.asset("assets/neodove.png"),),
    ));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PrefrencesManager.init();
    loadData();

  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    if(PrefrencesManager.getBool(StringContants.LOGIN)==true){
      _navigator.currentState.pushReplacement(MaterialPageRoute(builder: (context) => HomeFile()));
    }
    else{
      _navigator.currentState.pushReplacement(MaterialPageRoute(builder: (context) => SigninFile()));
    }


  //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SigninFile()));


  }}