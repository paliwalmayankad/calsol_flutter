import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neodove/API/LeadsDatApi.dart';
import 'package:neodove/DATABASE/DBHelper.dart';
import 'package:neodove/DATABASE/Leads.dart';
import 'package:neodove/Models/CommonModels.dart';
import 'package:neodove/Models/DashboardModel.dart';
import 'package:neodove/Models/LeadsModels.dart';
import 'package:neodove/MyColors.dart';
import 'package:neodove/TabOptionFile.dart';
import 'package:neodove/UiWidgets.dart';
import 'package:neodove/Utils/PrefrencesManager.dart';
import 'package:neodove/Utils/StringConstants.dart';
import 'package:toast/toast.dart';

import 'API/BreakstatusApi.dart';
import 'API/DashBoardLeadsApi.dart';
import 'Utils/UtilFiles.dart';

class HomeFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeFileState();
  }
}
class HomeFileState extends State<HomeFile>{
  bool mainstate=false;
  List<campaigns> dashboardleadsinfo;
  DBHelper dbh;
  String workingstatus;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbh=new DBHelper();
    dashboardleadsinfo=new List();
    workingstatus=PrefrencesManager.getString(StringContants.DAY_OPERATION);
    _getDashBoardData();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyColors.purple_color
    ));
    //_getDashBoardData();
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(backgroundColor: MyColors.purple_color,
        title: Text(PrefrencesManager.getString(StringContants.ORGNAME)),



      ),
      drawer:
      buildDrawer(),
      body: Container(color: MyColors.bg_color,width: double.infinity,height: double.infinity,
        padding: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 5),
        child: Column(children: <Widget>[
          Card(elevation: 4,
            child: Container(padding: EdgeInsets.only(top: 20,bottom: 20,left: 15,right: 15),
              child: Row(children: <Widget>[
                Expanded(flex:2,child:Column(children: <Widget>[ Text("Welcome "+PrefrencesManager.getString(StringContants.USERNAME),style: TextStyle(color: Colors.black,fontSize: 20),),
                  SizedBox(height: 2,),
                  PrefrencesManager.getString(StringContants.DAY_OPERATION)!=null?  Text("Your last break "+ PrefrencesManager.getString(StringContants.BREAKTIME),style: TextStyle(color: MyColors.purple_color,fontSize: 16),):SizedBox(),
                ],)),
                Expanded(flex:1,
                    child: InkWell(
                        onTap: (){
                          _updatedayactivity();

                        },

                        child:Container(
                            height:80,
                            margin: EdgeInsets.all(0.0),
                            decoration: BoxDecoration(
                                color:MyColors.purple_color,
                                shape: BoxShape.circle
                            ),child:Container(
                            height: 80,
                            margin: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                            child: Container(alignment: Alignment.center,
                              height: 80,
                              margin: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                  color: MyColors.purple_color,
                                  shape: BoxShape.circle
                              ),
                              child:PrefrencesManager.getString(StringContants.DAY_OPERATION)==null||PrefrencesManager.getString(StringContants.DAY_OPERATION)=="day-start"||PrefrencesManager.getString(StringContants.DAY_OPERATION)==""? Text("Check-in",style: TextStyle(color: Colors.white),):Text(PrefrencesManager.getString(StringContants.DAY_OPERATION)=="break-end"?"Pause":"Resume",style: TextStyle(color: Colors.white),),

                            )
                        )))
                )

              ],),
            ),
          ),
          SizedBox(height: 5,),

          ///// LISTVIEW FOR DETAIL AND LEADS
          _getleadsview(),





        ],),
      ),
    );

  }

  Widget buildDrawer() {

    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.50,
      child:Drawer(
          child:Container(
              margin: EdgeInsets.only(top: 30,bottom: 10,left: 10,right: 10),
              child:SingleChildScrollView(
                  scrollDirection: Axis.vertical,

                  child:Column(mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(padding: EdgeInsets.all(20),child: Image.asset("assets/neodove.png"),),
                      SizedBox(height: 5,),
                      Text(PrefrencesManager.getString(StringContants.USERNAME),style: TextStyle(color: MyColors.purple_color),),
                      SizedBox(height: 15,),
                      InkWell(child:Text('Log Out',style: TextStyle(color: MyColors.purple_color),),)
                    ],
                  )))),
    );
  }

  Future<void> _getDashBoardData() async {

    try{
      if (true == await UtilFiles.checkNetworkStatus(context))
      {
        DashBoardLeadsApi dashapi=new DashBoardLeadsApi();

        DashboardModel dashmodel= await dashapi.search();
        if(dashmodel.Success==true){
          dashboardleadsinfo=dashmodel.getcampaigns;
          PrefrencesManager.setString(StringContants.lead_another_duration, dashmodel.lead_another_duration.toString());
          PrefrencesManager.setString(StringContants.lead_call_automatic_duration, dashmodel.lead_call_automatic_duration.toString());
          PrefrencesManager.setBool(StringContants.lead_call_automatic_enabled, dashmodel.lead_call_automatic_enabled);
          setState(() {
            mainstate=true;
          });

        }
        else{

        }


      }
      else{
        Toast.show("Network not available.", context,duration: Toast.LENGTH_SHORT,gravity:Toast.BOTTOM );
      }


    }
    catch(e)
    {
      print(e);
    }
  }

  _getleadsview() {
    return Container(
      child: mainstate==false? UiWidgets.progressdialogbox():
      Expanded(child:  ListView.builder(
          shrinkWrap: true,

          scrollDirection: Axis.vertical,
          itemCount: dashboardleadsinfo.length,
          itemBuilder: (context,index){
            return
              Card(elevation: 4,
                  child: Container(padding: EdgeInsets.only(top: 20,bottom: 20,left: 15,right: 15),
                      child:Column(children: <Widget>[
                        Text(dashboardleadsinfo[index].campaign_name,style: TextStyle(color: Colors.black,fontSize: 16),),
                        SizedBox(height: 4,),
                        Container(height: 1,color: MyColors.light_grey_color,),
                        SizedBox(height: 4,),
                        Row(children: <Widget>[
                          Expanded(child: Column(children: <Widget>[
                            Text("Total Leads",style: TextStyle(color: MyColors.dark_grey_color),),
                            SizedBox(height: 2,),
                            Text(dashboardleadsinfo[index].total_leads.toString(),style: TextStyle(color: MyColors.dark_grey_color),),
                          ],),),
                          Expanded(child: Column(children: <Widget>[
                            Text("Pending Leads",style: TextStyle(color: MyColors.dark_grey_color),),
                            SizedBox(height: 2,),
                            Text(dashboardleadsinfo[index].pending.toString(),style: TextStyle(color: MyColors.dark_grey_color),),
                          ],),),

                        ],)


                      ],))
              );
          }))
      ,

    );

  }

  Future<void> _updatedayactivity() async {
    try{
      UiWidgets.showprogressdialogcomplete(context, true);
      String myworkday=PrefrencesManager.getString(StringContants.DAY_OPERATION);
      String pass="";
      if(myworkday==null||myworkday.isEmpty||myworkday=="day-start"){
        pass="day-start";
      }
      else   if(myworkday=="break-start"){
        pass="break-end";
      }
      else if(myworkday=="break-end"){
        pass="break-start";
      }
      try{
        if (true == await UtilFiles.checkNetworkStatus(context))
        {
          BreakstatusApi dashapi=new BreakstatusApi();

          CommonModels leadsmodel= await dashapi.search(pass);
          if(leadsmodel.Success==true){

            PrefrencesManager.setString(StringContants.DAY_OPERATION, pass);
//dbh=new DBHelper();
            var list=await dbh.getLeadss();
            if(PrefrencesManager.getString(StringContants.LEAD_DATA)==null){
              String asd= list[0].toString();
              PrefrencesManager.setString(StringContants.LEAD_DATA, list[0].leadlist.toString());
              PrefrencesManager.setBool(StringContants.LEAD_CONNECTED, false);
            }else{
              String asd= list[0].leadlist;
              PrefrencesManager.setString(StringContants.LEAD_DATA, list[0].leadlist.toString());
              PrefrencesManager.setBool(StringContants.LEAD_CONNECTED, false);
            }
            UiWidgets.showprogressdialogcomplete(context, false);
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TabOptionFile()));


          }
          else{
            UiWidgets.showprogressdialogcomplete(context, false);
            Toast.show(leadsmodel.errorMessage, context,duration: Toast.LENGTH_SHORT,gravity:Toast.BOTTOM );

          }


        }
        else{
          UiWidgets.showprogressdialogcomplete(context, false);
          Toast.show("Network not available.", context,duration: Toast.LENGTH_SHORT,gravity:Toast.BOTTOM );
        }
      }
      catch(e)
      {
        UiWidgets.showprogressdialogcomplete(context, false);
        print(e);
      }



    }catch(e)
    {
      print(e);
    }


  }


}