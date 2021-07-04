import 'package:cool_cab/screens/loginpg.dart';
/*
CREATED BY BISWARUP BHATTACHARJEE
EMAIL    : bbiswa471@gmail.com
PHONE NO : 6290272740
*/
import 'package:cool_cab/screens/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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
class Profile extends StatefulWidget {
  static const String id ="ProfilePg";
  String emailstr;
  String userid;
  String phone;
  String fullname;
  String photourl;
  Profile({
    @required this.emailstr,
  @required this.userid,
  @required this.phone,
  @required this.fullname,
  @required this.photourl});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  Widget build(BuildContext context) {
    void _SignOut() async{
      try{
        await FirebaseAuth.instance.signOut();
      }catch(e){
        print(e.toString());
      }
    }

    return Scaffold(
      backgroundColor: HexColor('ead3cb'),
      body:SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(child:CircleAvatar(
              backgroundColor: Colors.red,
              radius: 50,
              backgroundImage: NetworkImage(widget.photourl),
            )),
            SizedBox(height: 20,),
            Text(widget.fullname,
              style: TextStyle(
                fontFamily: 'qh',
                color: Colors.black,
                fontSize: 25.0,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 35,
              width: 250,
              child: Divider(
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(vertical: 12.0,horizontal: 25.0),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.phone,
                    color: Colors.teal.shade900,
                  ),
                  Container(
                    child: Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text("  "+widget.phone,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22
                          ),
                        ),
                      ),
                    ),
                  ),

                ],

              ),

            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(vertical: 12.0,horizontal: 25.0),
              child:   Row(
                children:<Widget>[
                  Icon(
                    Icons.mail,
                    color: Colors.teal.shade900,
                  ),
                  Container(
                    child: Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text("  "+widget.emailstr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22
                          ),
                        ),
                      ),
                    ),
                  ),
                ],),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(vertical: 12.0,horizontal: 25.0),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.verified_user,
                    color: Colors.teal.shade900,
                  ),
              Text(" UID: ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                ),),
                  Container(
                    child: Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(widget.userid,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22
                          ),
                        ),
                      ),
                    ),
                  ),

                ],

              ),

            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(35),
              margin: EdgeInsets.symmetric(vertical: 12.0,horizontal: 60.0),
              child: RaisedButton(
                onPressed: ()async{
                  await _SignOut();
                  Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25)
                ),
                color:Colors.white,
                textColor: Colors.black,
                child: Container(
                  height: 60,
                  child: Center(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget> [
                        new Image.asset("asset/images/logout.png",height: 40,),
                        Text('SignOut',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Apasto',
                          ),
                        ),
                      ], ),
                  ),
                ),
              ),
            ),

          ],),
      ),
    );
  }
}
