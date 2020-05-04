class Leads{
  int id;
  String lead_id;
  String leadlist;
  String btninfo;
  String style;
  String followupdate;
  String currentdate;
  Leads();
  /*Leads(this.id,
      this.lead_id,
      this.leadlist,
      this.btninfo,
      this.style,
      this.followupdate,
      this.currentdate,);*/

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'lead_id': lead_id,
      'leadlist': leadlist,
      'btninfo': btninfo,
      'style': style,
      'followupdate': followupdate,
      'currentdate': currentdate,
    };
    return map;
  }

  Leads.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    lead_id = map['lead_id'];
    leadlist = map['leadlist'];
    btninfo = map['btninfo'];
    style = map['style'];
    followupdate = map['followupdate'];
    currentdate = map['currentdate'];
  }

}