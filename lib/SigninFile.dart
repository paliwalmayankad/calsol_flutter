import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neodove/API/LeadsDatApi.dart';
import 'package:neodove/API/LoginApi.dart';
import 'package:neodove/DATABASE/DBHelper.dart';
import 'package:neodove/HomeFile.dart';
import 'package:neodove/Models/LoginModels.dart';
import 'package:neodove/MyColors.dart';
import 'package:neodove/UiWidgets.dart';
import 'package:neodove/Utils/PrefrencesManager.dart';
import 'package:neodove/Utils/StringConstants.dart';
import 'package:toast/toast.dart';

import 'DATABASE/Leads.dart';
import 'Models/LeadsModels.dart';
import 'Utils/UtilFiles.dart';

class SigninFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SigninFileState();
  }
}
class SigninFileState extends State<SigninFile>{
  TextEditingController _mobilecontroller,_passwordcontroller;
 DBHelper dbh;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbh=new DBHelper();
    _mobilecontroller=new TextEditingController();
    _passwordcontroller=new TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyColors.purple_color
    ));
    // TODO: implement build
    return Scaffold(backgroundColor: MyColors.bg_color,
      body: Stack(alignment:Alignment.center,children: <Widget>[
           Positioned(
             top: 50,child: Container(alignment:Alignment.center,child: Image.asset("assets/neodove.png",fit: BoxFit.fill,height: 60,)),

           ),
        Center(child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          child: Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.center,
            children: <Widget>[
             Text("Sign In",style: TextStyle(color: MyColors.purple_color,fontWeight: FontWeight.bold,fontSize: 18),),
            SizedBox(height: 5,),
            Container(height: 5,width: 30,color: MyColors.purple_color,),
              SizedBox(height: 10,),
              Card(elevation: 5,color: Colors.white,
                child: Container(padding: EdgeInsets.only(top: 35,bottom: 35,left: 8,right: 8),width: double.infinity,
                child: Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
                  Text("MOBILE NUMBER",style: TextStyle(color: MyColors.light_grey_color,fontSize: 14),),
                  SizedBox(height: 0),
                  TextFormField(
                    cursorColor: MyColors.dark_grey_color,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.start,
                    controller: _mobilecontroller,
                    style: TextStyle(color: MyColors.purple_color,fontSize: 18),
                    decoration: UiWidgets.edittextsdinglelinebackground(
                        "Mobile Number"),
                  ),
                  SizedBox(height: 10),
                  Text("PASSWORD",style: TextStyle(color: MyColors.light_grey_color,fontSize: 14),),

                  TextFormField(
                    obscureText: true,
                    controller: _passwordcontroller,
                    cursorColor: MyColors.dark_grey_color,
                    keyboardType: TextInputType.visiblePassword,
                    textAlign: TextAlign.start,
                    style: TextStyle(color: MyColors.purple_color,fontSize: 18),
                    decoration: UiWidgets.edittextsdinglelinebackground(
                        "Mobile Number"),
                  )



                ],),
                ),
              )

          ],),

        )),),

      ],),

      bottomSheet: getBottomSheet(),

    );
  }

  getBottomSheet() {
    Size size = MediaQuery
        .of(context)
        .size;

return    SizedBox(height:60,width: double.infinity,
  child: RaisedButton(
    child: new Text(
        "SIGN IN",
        style: new TextStyle(
          color: Colors.white,
        )
    ),
    colorBrightness: Brightness.dark,
    onPressed: () {
      String mobile=_mobilecontroller.text.toString();
      String password=_passwordcontroller.text.toString();
      if(mobile.length<0||mobile.isEmpty||mobile==" "){
Toast.show("Enter Mobile ", context,duration: Toast.LENGTH_SHORT,gravity:Toast.BOTTOM );
      }
      else if(password.length<0||password.isEmpty||password==" "){
        Toast.show("Enter Password ", context,duration: Toast.LENGTH_SHORT,gravity:Toast.BOTTOM );
      }
      else{

_loginmyfile(mobile,password);
      }

      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeFile()));
    },
    color: MyColors.purple_color,
  ),

);
  }

  Future<void> _loginmyfile( mobile,password) async{
    if (true == await UtilFiles.checkNetworkStatus(context)) {

      try {
UiWidgets.showprogressdialogcomplete(context,true);
          LoginApi _userupdateprofileapi = new LoginApi();





          LoginModels result = await _userupdateprofileapi.search(mobile,password,"fcmtoken","1.0","os","os_version","device_make","device_model");

          if (result.Success == true) {

PrefrencesManager.setBool(StringContants.LOGIN, true);
PrefrencesManager.setString(StringContants.USERID, result.user_id);
PrefrencesManager.setString(StringContants.ORGID, result.org_id);
PrefrencesManager.setString(StringContants.ORGNAME, result.org_name);
PrefrencesManager.setString(StringContants.TOKEN, result.token);
PrefrencesManager.setString(StringContants.USERNAME, result.user_name);
PrefrencesManager.setString(StringContants.USERROLE, result.user_role);

_getLeadsData();

          }
          else {
            UiWidgets.showprogressdialogcomplete(context,false);
            Toast.show(result.errorMessage, context,duration: Toast.LENGTH_SHORT,gravity:Toast.BOTTOM );
          }

      }


      catch (e) {
        UiWidgets.showprogressdialogcomplete(context,false);
print(e);
      }



    }
    else
    {
      Toast.show("Network not available.", context,duration: Toast.LENGTH_SHORT,gravity:Toast.BOTTOM );
    }
  }
  Future<void> _getLeadsData() async{
    try{
      if (true == await UtilFiles.checkNetworkStatus(context))
      {
        LeadsDatApi dashapi=new LeadsDatApi();

        LeadsModels leadsmodel= await dashapi.search();
        if(leadsmodel.Success==true){
          dbh=new DBHelper();
          List<dynamic> my_leads=leadsmodel.my_leads;
          List<dynamic> schedule_leads=leadsmodel.schedule_leads;

          try{
            for(int i=0;i<my_leads.length;i++) {
              Map<dynamic, dynamic> map = my_leads[i];

              Leads lm = new Leads();
              lm.lead_id = map['lead_id'];
              lm.leadlist = json.encode(my_leads[i]);
              lm.btninfo = "";
              lm.style = "";
              lm.followupdate = "0";
              lm.currentdate =
                  UiWidgets.getcurrentdateasrequireformat("dd-MM-yyyy hh:mm");
              await  dbh.add(lm);

            }
            for(int i=0;i<schedule_leads.length;i++) {
              Map<dynamic, dynamic> map = schedule_leads[i];

              Leads lm = new Leads();
              lm.lead_id = map['lead_id'];
              lm.leadlist = json.encode(schedule_leads[i]);
              lm.btninfo = "";
              lm.style = "";
              lm.followupdate = map["followup_date"] .toString();
              lm.currentdate =
                  UiWidgets.getcurrentdateasrequireformat("dd-MM-yyyy hh:mm");
              await  dbh.add(lm);

            }
var list= await dbh.getLeadss();
            UiWidgets.showprogressdialogcomplete(context,false);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeFile()));

          }
          catch(e)
          {
            print(e);
          }






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


}
