import 'package:neodove/Models/LoginModels.dart';

import 'NetworkUtil.dart';

class LoginApi
{
  NetworkUtil _netUtil = new NetworkUtil();

  Future<LoginModels> search(String mobile,String password,String fcm,String appversion,String os,String osversion,String devicemake,String devicemodel



      ) {
    // ignore: non_constant_identifier_names
    String base_token_url = NetworkUtil.base_url + 'login-app';
    return _netUtil.post(base_token_url,
      body: {
        "username":mobile,
        "password":password,
        "fcm_token":fcm,
        "app_version":appversion,
        "os":os,
        "os_version":osversion,
        "device_make":devicemake,
        "device_model":devicemodel,






      }, ).then((dynamic res) {
      LoginModels results = new LoginModels.map(res);
      //results.status = 200;
      return results;
    });
  }
}