import 'package:flutter/material.dart';
import 'package:brand_colors/brand_colors.dart';
class ProgressBar extends StatelessWidget {
  final String status;
  ProgressBar({this.status});
  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      backgroundColor: Colors.transparent,
      child:Container(
        height: 150,
        margin: EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(

          children:<Widget>[
            SizedBox(height: 20,),
            ClipRRect(
              borderRadius: new BorderRadius.circular(10.0),
              child: Image(
                height: 50,
                width: 50,
                fit: BoxFit.fill,
                alignment: Alignment.center,
                image: AssetImage("asset/images/logo.png"),
              ),
            ),
            SizedBox(height: 20,),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(BrandColors.cocaColaRed),),
              SizedBox(width: 30,),
              Text(status,style: TextStyle(fontSize: 20,fontFamily: 'Apasto',fontWeight: FontWeight.bold),)
            ],
          ),
        ]),
      )
    );
  }
}
