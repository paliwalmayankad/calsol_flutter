class CommonModels{
  bool  Success;
  String errorMessage;






  CommonModels.map(dynamic obj){
    if(obj!=null)
    {
      this.Success=obj["success"];


      if(Success==true) {
        //this.data=obj['data'];

      }
      else{
        this.errorMessage=obj["errorMessage"];
      }
    }

  }


}