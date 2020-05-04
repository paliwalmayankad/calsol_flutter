import 'package:neodove/Models/DashboardModel.dart';
import 'package:neodove/Utils/PrefrencesManager.dart';
import 'package:neodove/Utils/StringConstants.dart';

import 'NetworkUtil.dart';

class DashBoardLeadsApi
{
  NetworkUtil _netUtil = new NetworkUtil();

  Future<DashboardModel> search() {
    // ignore: non_constant_identifier_names
    String base_token_url = NetworkUtil.base_url + 'agent_app/dashboard';

    Map<String,String> maps={
      "token":PrefrencesManager.getString(StringContants.TOKEN)

    };
    return _netUtil.get(base_token_url,
      headers: maps,
       ).then((dynamic res) {
      DashboardModel results = new DashboardModel.map(res);
      //results.status = 200;
      return results;
    });
  }
}