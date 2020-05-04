class LoginModels{
  bool  Success;
  String errorMessage;



  int org_status;
  String user_id;
  String org_id;
  String org_name;
  String token;
  String user_name;
  String user_role;


  LoginModels.map(dynamic obj){
    if(obj!=null)
    {
      this.Success=obj["success"];


      if(Success==true) {
        //this.data=obj['data'];
        this.user_id = obj['data']["user_id"];
        this.org_id = obj['data']["org_id"];
        this.org_name = obj['data']["org_name"];
        this.token = obj['data']["token"];
        this.org_status = obj['data']["org_status"];
        //this.token = obj['data']["token"];
        this.user_name = obj['data']["user_name"];
        this.user_role = obj['data']["user_role"];

      }
      else{
        this.errorMessage=obj["errorMessage"];
      }
    }

  }

}
class UserData{
  int id;
  String name;
  String photo;
  String Email;
  String Status;
  String address;
  String City;
  String State;
  String password;
  String Country;
  String Zipcode;
  String Mobileno;
  String myrefercode;
  UserData() ;

  UserData.fromJson(Map<String, dynamic> jsonMap)
      : this.id = jsonMap["id"],
        this.name = jsonMap["name"],
        this.photo = jsonMap["photo"],
        this.Email = jsonMap["email"],
        this.Status = jsonMap["status"],
        this.address = jsonMap["address"],
        this.City = jsonMap["city"],
        this.State = jsonMap["state"],
        this.myrefercode = jsonMap["myrefercode"],
        this.Country = jsonMap["country"],
        this.password = jsonMap["password"],
        this.Zipcode = jsonMap["zipcode"],
        this.Mobileno = jsonMap["mobile"];
}