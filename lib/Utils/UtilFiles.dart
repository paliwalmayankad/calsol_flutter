import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

class UtilFiles{
  static Future<bool> checkNetworkStatus(BuildContext context ) async{
    bool connected=false;
    var connectivityResult = await  Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile) {
      connected=true;

    }

    else if (connectivityResult == ConnectivityResult.wifi) {
      connected=true;

    }
    return connected;

  }
}