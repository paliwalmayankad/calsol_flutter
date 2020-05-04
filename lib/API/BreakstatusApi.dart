import 'package:neodove/Models/CommonModels.dart';
import 'package:neodove/Utils/PrefrencesManager.dart';
import 'package:neodove/Utils/StringConstants.dart';

import 'NetworkUtil.dart';

class BreakstatusApi{
  NetworkUtil _netUtil = new NetworkUtil();

  Future<CommonModels> search(String activity,) {
    // ignore: non_constant_identifier_names
    String base_token_url = NetworkUtil.base_url + 'agent_app/activity';

    Map<String,String> maps={
      "token":PrefrencesManager.getString(StringContants.TOKEN)

    };
    return _netUtil.put(base_token_url,
      headers: maps,body: {"activity":activity,
          "fcm_token":PrefrencesManager.getString(StringContants.TOKEN),
          "reason":"","app_version":""


        }
    ).then((dynamic res) {
      CommonModels results = new CommonModels.map(res);
      //results.status = 200;
      return results;
    });
  }
}
