import 'package:neodove/Models/LeadsModels.dart';
import 'package:neodove/Utils/PrefrencesManager.dart';
import 'package:neodove/Utils/StringConstants.dart';

import 'NetworkUtil.dart';

class LeadsDatApi{
  NetworkUtil _netUtil = new NetworkUtil();

  Future<LeadsModels> search() {
    // ignore: non_constant_identifier_names
    String base_token_url = NetworkUtil.base_url + 'agent_app/my-leads';

    Map<String,String> maps={
      "token":PrefrencesManager.getString(StringContants.TOKEN)

    };
    return _netUtil.get(base_token_url,
      headers: maps,
    ).then((dynamic res) {
      LeadsModels results = new LeadsModels.map(res);
      //results.status = 200;
      return results;
    });
  }
}