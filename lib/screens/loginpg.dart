import 'package:cool_cab/screens/googleSignIn.dart';
/*
CREATED BY BISWARUP BHATTACHARJEE
EMAIL    : bbiswa471@gmail.com
PHONE NO : 6290272740
*/
import 'package:cool_cab/screens/myhomepage.dart';
import 'package:cool_cab/screens/registration.dart';
import 'package:cool_cab/screens/resetPass.dart';
import 'package:cool_cab/widgets/ProgressBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
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
bool validateStructure(String value){
  String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
final GlobalKey<ScaffoldState> scaffoldkey=new GlobalKey<ScaffoldState>();
void showSnackBar(String title){
  final snackbar=SnackBar(
    content: Text(title,textAlign: TextAlign.center,style: TextStyle(fontSize: 18),),
  );
  scaffoldkey.currentState.showSnackBar(snackbar);
}




class LoginPage extends StatefulWidget {
  static const String id="login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController=TextEditingController();

  var passwordController=TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  void login(BuildContext context) async{
    showDialog(context: context, builder: (BuildContext context)=>ProgressBar(
        status:"Logging In You"),);
    final   UserCredential userCredential = (await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ).catchError((ex){
      FirebaseAuthException thEx=ex;
      showSnackBar(thEx.message);
    }));
    if(userCredential!=null){
      DatabaseReference useRef=FirebaseDatabase.instance.reference().child('users/${userCredential.user.uid}');
      useRef.once().then((DataSnapshot snapshot){
        if(snapshot.value!=null){
          Navigator.pushNamedAndRemoveUntil(context, MyHomePage.id, (route) => false);
        }
      });
    }
  }









  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldkey,
      backgroundColor: HexColor('f39189'),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: DelayedDisplay(
              slidingCurve: Curves.slowMiddle,
            delay: Duration(seconds: 1),
              child: Column(
                  children: <Widget>[
                    SizedBox(height:35 ),
                    ClipRRect(
                      borderRadius: new BorderRadius.circular(10.0),
                      child: Image(
                        height: 120,
                        width: 120,
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                        image: AssetImage("asset/images/logo.png"),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text("Sign in as a User",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Qh',
                    ),),
                    DelayedDisplay(
                      delay: Duration(milliseconds: 1300),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                                fontFamily: 'Qh'
                              ),
                              hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 20
                          )
                            ),
                            style: TextStyle(
                              fontSize: 14
                            ),
                          ),//EMAIL
                            SizedBox(height: 20,),
                            TextField(
                              controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24.0,
                                  fontFamily: 'Qh'
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20
                              )
                          ),
                          style: TextStyle(
                              fontSize: 14
                          ),
                        ),//PASSWORD
                            SizedBox(height: 20),
                            FlatButton(
                              onPressed: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>ResetPassword()));
                              },
                              child: Text("Forget Password",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'boltR',
                                ),),
                            ),
                            SizedBox(height: 10),
                            DelayedDisplay(
                              delay: Duration(milliseconds: 1500),
                              child: RaisedButton(
                                onPressed: () async {
                                  /*Check Network Connectivity*/
                                  try{
                                    var connectivityResult = await Connectivity().checkConnectivity();
                                    if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
                                      // I am not connected to a mobile network or wifi.So I have no Connection..
                                      showSnackBar("No Internet Connectivity...\nTry Again With Proper Network Connection..");
                                      return;
                                    }}
                                  catch(e){
                                    print(e);
                                  }
                                  if(!emailController.text.contains('@'))
                                  {
                                    showSnackBar("Provide a valid Email Address");
                                    return;
                                  }
                                  if(passwordController.text.length<10)
                                  {
                                    showSnackBar("Password Must be at least 10 characters");
                                    return;

                                  }
                                  if(passwordController.text.length>=10)
                                  {
                                    if(!validateStructure(passwordController.text)){
                                      showSnackBar("Password Has ----> \nMinimum 1 Upper case\nMinimum 1 lowercase\nMinimum 1 Numeric Number\nMinimum 1 Special Character");
                                      return;
                                    }
                                  }
                                  login(context);

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
                                      'LOGIN',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: 'Apasto'
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            DelayedDisplay(
                              slidingCurve: Curves.elasticInOut,
                              delay: Duration(milliseconds: 1500),
                              child: RaisedButton(
                                onPressed: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>GoogleSignInPage()));
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
                                      'Google SignIn',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: 'Apasto'
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            DelayedDisplay(
                              slidingCurve: Curves.elasticInOut,
                              delay: Duration(milliseconds: 1500),
                              child: FlatButton(
                                onPressed: (){
                                  Navigator.pushNamedAndRemoveUntil(context, RegistrationPg.id, (route) => false);
                                },
                                child: Text("Don't have an account,sign up here",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'boltR',
                                ),),
                              ),
                            ),


                       ] ),
                      ),
                    ),


                  ],
                ),
            ),
          ),
        ),
      ),
    );
  }
}
