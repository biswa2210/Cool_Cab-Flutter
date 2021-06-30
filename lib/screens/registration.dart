import 'package:cool_cab/screens/loginpg.dart';
import 'package:cool_cab/screens/myhomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'dart:io';
import 'package:delayed_display/delayed_display.dart';
import 'package:connectivity/connectivity.dart';
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
class RegistrationPg extends StatefulWidget {
  static const String  id = "register";

  @override
  _RegistrationPgState createState() => _RegistrationPgState();
}

class _RegistrationPgState extends State<RegistrationPg> {
  final GlobalKey<ScaffoldState> scaffoldkey=new GlobalKey<ScaffoldState>();

  var fullNameController=TextEditingController();

  var emailController=TextEditingController();

  var phoneController=TextEditingController();

  var passwordController=TextEditingController();

  void showSnackBar(String title){
    final snackbar=SnackBar(
      content: Text(title,textAlign: TextAlign.center,style: TextStyle(fontSize: 18),),
    );
    scaffoldkey.currentState.showSnackBar(snackbar);
  }

  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  void register(BuildContext context) async{

     final UserCredential  userCredential = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
      ).catchError((ex){
       FirebaseAuthException thEx=ex;
        showSnackBar(thEx.message);
     }));
    if(userCredential != null ){
      Toast.show("User Account Successfully Registered", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      DatabaseReference newref=FirebaseDatabase.instance.reference().child('users/${userCredential.user.uid}');
      Map UserMap ={
        "fullname":fullNameController.text,
        "email":emailController.text,
      };
      DatabaseReference newref2=FirebaseDatabase.instance.reference().child('users/${userCredential.user.uid}/phonenumber');
      Map UserMap2 ={
        "userphno":phoneController.text,
      };
      newref.set(UserMap);
      newref2.set(UserMap2);
      Navigator.pushNamedAndRemoveUntil(context,MyHomePage.id, (route) => false);
    }
    else{
      Toast.show("Fill The Credentials Properly", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      backgroundColor: HexColor('f39189'),
      body: Center(
        child: SafeArea(
          child: DelayedDisplay(
            slidingCurve: Curves.slowMiddle,
              delay: Duration(milliseconds: 500),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height:20 ),
                  ClipRRect(
                    borderRadius: new BorderRadius.circular(10.0),
                    child: Image(
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                      image: AssetImage("asset/images/logo.png"),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text("Register as a User",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Qh',
                    ),),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        children: <Widget>[
                          DelayedDisplay(
                            delay: Duration(seconds:1),
                            slidingCurve: Curves.elasticInOut,
                            child: TextField(
                              controller: fullNameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  labelText: 'Full Name',
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
                            ),
                          ),
                          SizedBox(height: 20,),
                          DelayedDisplay(
                            slidingCurve: Curves.elasticInOut,
                            delay: Duration(seconds:1),
                            child: TextField(
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
                            ),
                          ),//EMAIL


                          SizedBox(height: 20,),
                          DelayedDisplay(
                            delay: Duration(seconds:1),
                            slidingCurve: Curves.elasticInOut,
                            child: TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Phone Number',
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
                            ),
                          ),//PASSWORD//PASSWORD
                          SizedBox(height: 20,),
                          DelayedDisplay(
                            delay: Duration(seconds:1),
                            slidingCurve: Curves.elasticInOut,
                            child: TextField(
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
                            ),
                          ),//PASSWORD//PASSWORD
                          SizedBox(height: 30),
                          RaisedButton(
                            onPressed:() async{

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


                              if(fullNameController.text.length<5)
                                {
                                  showSnackBar("Provide a valid Full Name");
                                  return;
                                }
                              if(!emailController.text.contains('@'))
                              {
                                showSnackBar("Provide a valid Email Address");
                                return;
                              }
                              if(phoneController.text.length!=10)
                              {
                                showSnackBar("Provide a valid Phone Number");
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
                              Toast.show("Processing...", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

                              register(context);
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
                                  'REGISTER',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: 'Apasto'
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Center(
                            child: FlatButton(
                              onPressed: (){
                                Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
                              },
                              child: Text("Already Have an Account,Login here",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'boltR',
                                ),),
                            ),
                          )

                        ] ),
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
