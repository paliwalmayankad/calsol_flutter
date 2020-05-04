import 'dart:async';
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


import 'package:neodove/UiWidgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'package:webview_flutter/webview_flutter.dart';

import 'Utils/PrefrencesManager.dart';
import 'Utils/StringConstants.dart';

class CaptureInfoFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CaptureInfoFileState();
  }
}

class CaptureInfoFileState  extends State<CaptureInfoFile>{
  String leadurl;
  String mobile;
  bool mainstate=false;
  WebViewController awebViewController ;
  InAppWebViewController webView;
  String url = "";
  double progress = 0;



  // final flutterWebviewPlugin = new FlutterWebviewPlugin();

  ///// ORIGINAL CODE
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getleaddetail();
    _webViewHandler();


    /* flutterWebviewPlugin.lightningLinkStream.listen((message){
      print(message);
    });*/
    try {
      //  final _webView = new InteractiveWebView();

      //  _webView.loadUrl("https://www.google.com");

      /* flutterWebviewPlugin.launch(leadurl);

     flutterWebviewPlugin.onStateChanged.listen((state) async {
       if (state.type == WebViewState.finishLoad) {
         String script = 'window.addEventListener("btn", receiveMessage, false);' +
             'function receiveMessage(event) {InterfaceName.methodName(event.data);}';
         flutterWebviewPlugin.evalJavascript(script);
       }
       if(state.type==WebViewState.)
     });*/
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return

      Scaffold(
        body: Container(width: double.infinity,height: double.infinity,
          child:
          _callwebview(),
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
        leadurl=valueMap['details_form_url'];
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


    // TODO(iskakaushik): Remove this when collection literals makes it to stable.


    WebView(
      initialUrl: leadurl,
      onPageStarted: (wecont){
        String token=PrefrencesManager.getString(StringContants.TOKEN);

        // awebViewController.evaluateJavascript("btn.getUserAuthToken().value='$token'");
      },
      onWebViewCreated: (webViewController) {
        setState(() {
          awebViewController = webViewController;
        });

        String token=PrefrencesManager.getString(StringContants.TOKEN);


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

        String token=PrefrencesManager.getString(StringContants.TOKEN);
        try {
          String passjs="""
    btn.getUserAuthToken() {
   return  $token ;
   }
""";
          awebViewController.evaluateJavascript(passjs);
        }
        catch(e){
          print(e);
        }
      },
    )

        :SizedBox(),);


  }





  getUserAuthToken(){
    return PrefrencesManager.getString(StringContants.TOKEN);
  }





  void _webViewHandler()
  {
    // webView.setOptions(options: )

    try {
      const platform = const MethodChannel('flutter_webview_plugin');

      platform.setMethodCallHandler((call) {
        if (call.method == "getUserAuthToken")
        {

        } });
    }catch(e){
      print(e);
    }
  }




}

class CallInterFace {
}

class sdf {
}





