import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'MyColors.dart';

class UiWidgets{
  static InputDecoration edittextsdinglelinebackground(String hint){
    return InputDecoration(



      enabledBorder: new UnderlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.light_grey_color,


          ),
      ),
      focusedBorder: new UnderlineInputBorder(

          borderSide: BorderSide(
            color: MyColors.dark_grey_color,

          ),
      ),
      focusColor: Colors.black,



    );

  }
  static SpinKitFadingCircle progressdialogbox()
  {
    return SpinKitFadingCircle(
      color: MyColors.purple_color,

      size: 50.0,
    );
  }
  static String getcurrentdateasrequireformat(String format ){
    DateTime now = DateTime.now();
    String formattedDate = DateFormat(format).format(now);

    return formattedDate;
  }
  static BoxDecoration whiteboxroundeddecoration(){
    return BoxDecoration(color:Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),

          topRight: Radius.circular(16.0),
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0)
      ),);
  }
  static void showprogressdialogcomplete(BuildContext context, bool show)async{
    if(show==true){
      try {
        await  showGeneralDialog(context: context,
            barrierDismissible: false,
            barrierLabel: MaterialLocalizations
                .of(context)
                .modalBarrierDismissLabel,
            barrierColor: Colors.black45,

            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (BuildContext buildContext,
                Animation animation,
                Animation secondaryAnimation) {
              return
                Center(child: Container(
                    height: 65, width: 65, decoration: whiteboxroundeddecoration(),
                    child: SpinKitFadingCircle(
                      color: MyColors.purple_color,

                      size: 50.0,
                    )
                ));
            });
      }
      catch(e){
        print(e);
      }
    }
    else{
      Navigator.of(context).pop();
    }
  }
}