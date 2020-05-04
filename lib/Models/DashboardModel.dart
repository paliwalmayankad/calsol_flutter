class DashboardModel{
  bool  Success;
  String errorMessage;



  int lead_another_duration;
  int lead_call_automatic_duration;
  bool lead_call_automatic_enabled;
  List<campaigns> getcampaigns;
  String org_name;
  String token;
  String user_name;
  String user_role;


  DashboardModel.map(dynamic obj){
    if(obj!=null)
    {
      this.Success=obj["success"];


      if(Success==true) {
        //this.data=obj['data'];
        this.lead_another_duration = obj['data']["lead_another_duration"];
        this.lead_call_automatic_duration = obj['data']["lead_call_automatic_duration"];
        this.lead_call_automatic_enabled = obj['data']["lead_call_automatic_enabled"];
        this.getcampaigns=(obj['data']['campaigns']as List).map((i)=>campaigns.fromJson(i)).toList();

      }
      else{
        this.errorMessage=obj["errorMessage"];
      }
    }

  }


}

class campaigns {
  String campaign_name;
  int total_leads;
  var pending;
  campaigns();

  campaigns.fromJson(Map jsonMap)
      : campaign_name = jsonMap['campaign_name'],
        total_leads=jsonMap['total_leads'],
        pending = jsonMap['pending']


  ;

}