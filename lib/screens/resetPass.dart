import 'package:cool_cab/screens/loginpg.dart';
import 'package:cool_cab/screens/registration.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
final GlobalKey<ScaffoldState> scaffoldkey=new GlobalKey<ScaffoldState>();
void showSnackBar(String title){
  final snackbar=SnackBar(
    content: Text(title,textAlign: TextAlign.center,style: TextStyle(fontSize: 18),),
  );
  scaffoldkey.currentState.showSnackBar(snackbar);
}
class ResetPassword extends StatelessWidget {
  static const String id="resetPass";
  @override
  Widget build(BuildContext context) {
    Future _passwordReset(String email) async {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        showSnackBar("Password Reset Link Sent In Your Register Email");
      } catch (e) {
        showSnackBar(e.toString());
      }
    }
    var email=TextEditingController();
    return Scaffold(
      key: scaffoldkey,
    backgroundColor: HexColor('f39189'),
    body: SafeArea(
    child: SingleChildScrollView(
    child: DelayedDisplay(
      slidingCurve: Curves.easeInCirc,
      delay: Duration(microseconds: 500),
      child: Column(
      children: <Widget>[
      SizedBox(height:45 ),
      ClipRRect(
      borderRadius: new BorderRadius.circular(10.0),
      child: Image(
      height: 170,
      width: 170,
      fit: BoxFit.fill,
      alignment: Alignment.center,
      image: AssetImage("asset/images/logo.png"),
      ),
      ),
      SizedBox(height: 30,),
      Text("RESET PASSWORD OF RIDER",
      textAlign: TextAlign.center,
      style: TextStyle(
      fontSize:30,
      fontWeight: FontWeight.bold,
      fontFamily: 'Qh',
      ),),
      Padding(
      padding: EdgeInsets.all(25),
      child: Column(
      children: <Widget>[
      TextField(
        controller: email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
      labelText: 'Registered Email Address',
      labelStyle: TextStyle(
      color: Colors.black,
      fontSize: 30.0,
      fontFamily: 'Qh'
      ),
      hintStyle: TextStyle(
      color: Colors.grey,
      fontSize: 30
      )
      ),
      style: TextStyle(
      fontSize: 20
      ),
      ),//EMAIL
      SizedBox(height: 30,),


      SizedBox(height: 20),
      RaisedButton(
      onPressed: (){
      _passwordReset(email.text);
      },
      shape: new RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(25)
      ),
      color:HexColor('ce1212'),
      textColor: Colors.white,
      child: Container(
      height: 50,
      child: Center(
      child: Text(
      'RESET PASSWORD',
      style: TextStyle(
      fontSize: 25,
      fontFamily: 'Apasto'
      ),
      ),
      ),
      ),
      ),
        SizedBox(height: 20),
        RaisedButton(
          onPressed: (){
            Navigator.pushNamedAndRemoveUntil(context,LoginPage.id, (route) => false);
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(25)
          ),
          color:HexColor('ce1212'),
          textColor: Colors.white,
          child: Container(
            height: 50,
            child: Center(
              child: Text(
                'Login',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Apasto'
                ),
              ),
            ),
          ),
        ),


      ] ),
      ),


      ],
      ),
    ),
    ),
    ),);
  }
}
