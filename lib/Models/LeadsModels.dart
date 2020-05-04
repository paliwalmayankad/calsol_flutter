class LeadsModels{
  bool  Success;
  String errorMessage;
  List<dynamic> my_leads;
  List<dynamic> schedule_leads;
  LeadsModels.map(dynamic obj){
    if(obj!=null) {
      this.Success = obj["success"];


      if (Success == true) {
        //this.data=obj['data'];
        this.my_leads =  (obj['data']['my_leads']);
        this.schedule_leads =  (obj['data']['schedule_leads']);

      }
      else {
        this.errorMessage = obj["errorMessage"];
      }
    }}
}