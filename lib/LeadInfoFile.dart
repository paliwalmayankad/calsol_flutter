import 'dart:convert';

import 'package:call_number/call_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neodove/MyColors.dart';
import 'package:neodove/Utils/PrefrencesManager.dart';
import 'package:neodove/Utils/StringConstants.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
class LeadInfoFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LeadInfoFileState();
  }
}
class LeadInfoFileState extends State<LeadInfoFile>{
  var datas = List<Widget>();
  String campignname;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getleaddetail();
  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: _createlayout()
        ,),
      bottomSheet:getBottomSheet() ,

    );
  }

  _createlayout() {
    return Container(child: SingleChildScrollView(scrollDirection: Axis.vertical,
      child: Column(children: <Widget>[
        InkWell(
            onTap: (){
              //  _getleaddetail();
              _autodialnumber("1234567890");
            },
            child: Container(
                height: 80,width: double.infinity,
                child: Row(children: <Widget>[
                  Expanded(  flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                      Container(padding: EdgeInsets.all(5),
                        width: double.infinity,alignment: Alignment.center,
                        color: MyColors.light_grey_color,child: Text("Campaign Name",style: TextStyle(color: Colors.black,fontSize: 16),),)   ,
                      Container(
                        width: double.infinity,alignment: Alignment.center,padding: EdgeInsets.all(5),color: Colors.white,child: Text(campignname,style: TextStyle(color: Colors.black,fontSize: 16)),)   ,
                    ],)),
                  Expanded(  flex: 1, child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/neodove.png",fit: BoxFit.fill,height: 30,width: 30,),
                      Text("add")

                    ],))

                ],))),
        SizedBox(height: 5,),
        Container(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: datas
            )

        )],),
    ),);

  }
  getBottomSheet() {
    Size size = MediaQuery
        .of(context)
        .size;

    return    SizedBox(height:60,width: double.infinity,
      child: RaisedButton(
        child: new Text(
            "Call",
            style: new TextStyle(
              color: Colors.white,
            )
        ),
        colorBrightness: Brightness.dark,
        onPressed: () {


          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeFile()));
        },
        color: Colors.greenAccent,
      ),

    );
  }
  void _getleaddetail() {
    try {
      String leaddetailstring = PrefrencesManager.getString(
          StringContants.LEAD_DATA);
      Map valueMap = json.decode(leaddetailstring);
      Map data=valueMap['data'];
      setState(() {
        campignname=valueMap['campaign_name'];
      });
      data.forEach((key, value){
        print('Key: $key, Value: $value');
        datas.add(new Container(padding: EdgeInsets.all(5),child: Text(key.toString()+":"+value.toString(),style: TextStyle(color: Colors.black),),));

      });


      _autodialnumber(data['contact_number']);



    }
    catch(e)
    {
      print(e);
    }

  }

  Future<void> _autodialnumber(data) async {
    try {
      if (PrefrencesManager.getBool(
          StringContants.lead_call_automatic_enabled) == true) {
        int autodialduration = int.parse(PrefrencesManager.getString(
            StringContants.lead_call_automatic_duration));

        // UrlLauncher.launch("tel://"+data);
        //await new CallNumber().callNumber('+91' + data);
      }
    }catch(e)
    {
      print(e);
    }

  }
}