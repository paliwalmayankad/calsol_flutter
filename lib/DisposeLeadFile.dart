import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'package:webview_flutter/webview_flutter.dart';

import 'Utils/PrefrencesManager.dart';
import 'Utils/StringConstants.dart';

class DisposeLeadFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DisposeLeadFileState();
  }
}
class DisposeLeadFileState extends State<DisposeLeadFile>{
  String leadurl;
  String mobile;
  bool mainstate=false;
  /*final Completer<WebViewController> _controller =
  Completer<WebViewController>();*/
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
      body: Container(width: double.infinity,height: double.infinity,
        child: _callwebview(),
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
        leadurl=valueMap['disposition_form_url']+"&my-leads=true";
        print(leadurl);
        mobile=valueMap['mobile_number'];
        mainstate=true;

      });
    }
    catch(e)
    {
      print(e);
    }
  }

  _callwebview() {
    return Container(child:mainstate==true?
    WebView(
      initialUrl: leadurl+"&my-leads=true",
      onPageStarted: (wecont){
      },
      onWebViewCreated: (webViewController) {
        setState(() {

        });




      },
      javascriptMode: JavascriptMode.unrestricted,

      javascriptChannels: <JavascriptChannel>[
        JavascriptChannel(name: 'btn', onMessageReceived: (JavascriptMessage msg)
        { String token=PrefrencesManager.getString(StringContants.TOKEN);

        // awebViewController.evaluateJavascript("btn.getUserAuthToken().value='$token'");

        print("errormsg"+msg.toString());
        ;
        },

        )

      ].toSet(),
      onWebResourceError: (error){
        print("webresourcseerror"+error.description);
      },
      onPageFinished: (webViewController) async {



      },
    ):SizedBox(),);

  }
}