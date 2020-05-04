import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neodove/CaptureInfoFile.dart';
import 'package:neodove/DisposeLeadFile.dart';
import 'package:neodove/LeadInfoFile.dart';

import 'MyColors.dart';

class TabOptionFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TabOptionFileState();
  }
}
class TabOptionFileState extends State<TabOptionFile>with SingleTickerProviderStateMixin{
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyColors.purple_color
    ));
    return Scaffold(
      appBar: getAppbar(),
      body: TabBarView(
        children: [
         new LeadInfoFile(),
          new CaptureInfoFile(),
          new DisposeLeadFile(),
        ],
        controller: _tabController,),


    );
  }

  getAppbar() {
    double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;


    return PreferredSize(
        preferredSize: Size.fromHeight(80+statusbarHeight),

        // here the desired height
        child:AppBar( backgroundColor:MyColors.purple_color, // this will hide Drawer hamburger icon
            actions: <Widget>[Container()],
            automaticallyImplyLeading: false,
            bottom: TabBar(
              indicatorColor: Colors.white,
              unselectedLabelColor: MyColors.light_grey_color,
            labelColor: Colors.white,
            controller: _tabController,

            tabs: [
              new Tab(child: Text("LEAD INFO"),),
              new Tab(child: Text("CAPTURE INFO"),),
              new Tab(child: Text("DISPOSE LEAD"),
              )
            ],),
            flexibleSpace:
            Container( alignment: Alignment.center,
              padding: new EdgeInsets.only(top: statusbarHeight),

              child:Column(children: <Widget>[              Row(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.center,children: <Widget>[
              Expanded(child:  Text("Leads Details",textAlign:TextAlign.end,style: TextStyle(color: Colors.white),)),
            Expanded(child:Container( alignment: Alignment.centerRight, child:   RaisedButton(
                  child: new Text(
                      "Break",
                      style: new TextStyle(
                        color: Colors.black,
                      )
                  ),
                  colorBrightness: Brightness.dark,
                  onPressed: () {
                  _showdialog(context);
                  },
                  color: Colors.white,
                ))),

              ],),


              ],),

            )));
  }

  void _showdialog(BuildContext context) {

    int _groupValue = 0;
    showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      int selectedRadio = 0;
      return AlertDialog(
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Are you sure, You want to break? ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),textAlign: TextAlign.start,),
              SizedBox(height: 4,),
              RadioListTile(
              value: 0,
                activeColor: Colors.black,
              groupValue: _groupValue,
              onChanged:  (newValue) => setState(() => _groupValue = newValue),
              title: Text("Tea/Snacks",style: TextStyle(color: Colors.black)),
            ),
            RadioListTile(
              value: 1,
              activeColor: Colors.black,
              groupValue:_groupValue,
              onChanged:  (newValue) => setState(() => _groupValue = newValue),
              title: Text("Lunch",style: TextStyle(color: Colors.black)),
            ),
            RadioListTile(
              value:2,
              activeColor: Colors.black,
              groupValue:_groupValue,
              onChanged:  (newValue) => setState(() => _groupValue = newValue),
              title: Text("Office Work",style: TextStyle(color: Colors.black)),
            ),
                RadioListTile(
                  value:3,
                  groupValue:_groupValue,
                  activeColor: Colors.black,

                  onChanged:  (newValue) => setState(() => _groupValue = newValue),
                  title: Text("Day Completed",style: TextStyle(color: Colors.black)),
                ),
                RadioListTile(
                  value:4,
                  groupValue:_groupValue,
                  activeColor: Colors.black,
                  onChanged:  (newValue) => setState(() => _groupValue = newValue),
                  title: Text("Other",style: TextStyle(color: Colors.black)),
                ),
               SizedBox(
                   width: double.infinity,
                   child: FlatButton(
                  onPressed: () {
Navigator.of(context).pop();
                  },
                  child: new Container(alignment: Alignment.centerRight,child: Text("Ok",style: TextStyle(color: MyColors.purple_color),textAlign: TextAlign.end,)),
                ))
              ],
            );
          },
        ),
      );
    });}
}