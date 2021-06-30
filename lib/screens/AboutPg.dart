import 'package:cool_cab/screens/ComparisonSc.dart';
import 'package:cool_cab/screens/contacctUs.dart';
import 'package:cool_cab/screens/favourities.dart';
import 'package:cool_cab/screens/loginpg.dart';
import 'package:cool_cab/screens/profile.dart';
import 'package:cool_cab/widgets/BrandDevidder.dart';
import 'package:cool_cab/widgets/DrawerItemStyle.dart';
import 'package:cool_cab/widgets/ProgressBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

import 'allCars.dart';
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
class AboutPG extends StatefulWidget {
  static const String id="AboutPg";
  @override
  _AboutPGState createState() => _AboutPGState();
}

class _AboutPGState extends State<AboutPG> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:HexColor('cf0000') ,
      appBar: AppBar(
        backgroundColor:HexColor('cf0000') ,
        title: Center(child: Text("About",
        style: TextStyle(
          color: Colors.yellowAccent,
          fontFamily: 'Apasto',
          fontSize: 45
        ),)),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color:HexColor('cf0000')
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 80,
                      width: 80,
                      decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                          boxShadow:   [
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 4,
                              blurRadius: 15,
                            ),
                            BoxShadow(
                              color:Colors.red,
                              spreadRadius: -4,
                              blurRadius: 25,
                            )
                          ]
                      ),
                      child:Image.asset("asset/images/logo.png",height: 60,width: 60,)
                    ),
                    SizedBox(width: 18,),
                    Container(
                        height: 80,

                      child:Text("   Cool  Cab\nApplication",
                      style: TextStyle(
                        fontFamily: 'mon',
                        fontSize: 30,
                        color: Colors.yellowAccent
                      ),),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery. of(context).size.height-250,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow:   [
                          BoxShadow(
                            color: Colors.yellowAccent,
                            spreadRadius: 4,
                            blurRadius: 15,
                          ),
                          BoxShadow(
                            color:Colors.yellowAccent,
                            spreadRadius: -4,
                            blurRadius: 25,
                          )
                        ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 5,),
                          BrandDevider(),
                          SizedBox(height: 5,),
                         Expanded(
                           child: SingleChildScrollView(
                             child: Text(
                               "This cool cab android or iOS application is for car lovers. It's a platform to explore well known 160 cars of 28 established companies. Here user can sign in with google account and phone number. User has to do it just for the first time. By swiping right user can see his or her profile and some options like all cars, favourites, comparison, feedback, contact us and about. In the home page there is a search engine to search cars and companies. This app need location access so that it can be stored safely with feedback. In the contact us section user can give some reviews and ideas for the app. In each car there is an option to add it to favourites. By clicking on the ad to comparison table button user can add it for comparison. User can add 2 or 3 cars to compare the features, price etc. User can also reset the comparison table. This app is totally responsive, user friendly, safe and a good place to explore cars.",
                               style: TextStyle(
                                 fontFamily: 'qh',
                                 letterSpacing: 2,
                                 fontSize: 15
                               )),
                           ),
                         ),
                         SizedBox(height: 5,),
                          BrandDevider(),
                          SizedBox(height: 5,),
                         Text(
                           "Biswarup Bhattacharjee student of BTECH, 2nd year has developed the app with all source codes in front end and back end and database, designed the entire UI of the app, edited photos of cars. Ankita Sikder student of BTECH, 2nd year has collected all resources of 160 cars and 28 companies and added the data in code.",
                           style: TextStyle(
                               fontFamily: 'qh',
                               letterSpacing: 2,
                               fontSize: 15
                           ),

                         ),
                          SizedBox(height: 5,),
                          BrandDevider(),
                          SizedBox(height: 5,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
