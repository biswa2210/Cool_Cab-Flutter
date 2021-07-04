import 'package:cool_cab/screens/loginpg.dart';
/*
CREATED BY BISWARUP BHATTACHARJEE
EMAIL    : bbiswa471@gmail.com
PHONE NO : 6290272740
*/
import 'package:cool_cab/screens/myhomepage.dart';
import 'package:cool_cab/screens/registration.dart';
import 'package:cool_cab/widgets/ProgressBar.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cool_cab/screens/googleSignIn.dart';
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



class GoogleSignInPage extends StatefulWidget {
  static const String id="googleSingIn";
  @override
  _GoogleSignInPageState createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

  var phoneNumber=TextEditingController();

  @override
  Widget build(BuildContext context) {
    void signInWithGoogle() async {
      showDialog(context: context, builder: (BuildContext context)=>ProgressBar(
          status:"Google Sign In"),);
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      if(googleUser!=null){
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        // Create a new credential
        if(googleAuth.accessToken!=null && googleAuth.idToken!=null){
          final GoogleAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          // Once signed in, return the UserCredential
          UserCredential userCredential=await FirebaseAuth.instance.signInWithCredential(credential);
          var drootRef = FirebaseDatabase.instance.reference().child("users");
          drootRef.child('${userCredential.user.uid}').once().then((snapshot) async{
            if(snapshot.value!=null){
              if(snapshot.value["fullname"]!=null) {
                print(snapshot.value["fullname"]);
                drootRef.child('${userCredential.user.uid}/phonenumber').once().then((snapshot2) async{
                  if(snapshot2.value["userphno"]!=null){
                    await FirebaseDatabase.instance.reference().child('users/${FirebaseAuth.instance.currentUser.uid}/phonenumber').remove();
                    DatabaseReference newreF=FirebaseDatabase.instance.reference().child('users/${FirebaseAuth.instance.currentUser.uid}/phonenumber');
                    Map UserMap ={
                      "userphno":phoneNumber.text,
                    };
                    newreF.set(UserMap).then((value) =>Navigator.pushNamedAndRemoveUntil(context,MyHomePage.id, (route) => false));
                  }

                });



              }
            }
              else{
                DatabaseReference newref=FirebaseDatabase.instance.reference().child('users/${userCredential.user.uid}');
                Map UserMap ={
                  "fullname":userCredential.user.displayName,
                  "email":userCredential.user.email,
                };
                DatabaseReference newref2=FirebaseDatabase.instance.reference().child('users/${userCredential.user.uid}/phonenumber');
                Map UserMap2 ={
                  "userphno":phoneNumber.text,
                };
                newref.set(UserMap);
                newref2.set(UserMap2).then((value) => Navigator.pushNamedAndRemoveUntil(context,MyHomePage.id, (route) => false));
              }
          });


        }
        else{
          throw PlatformException(
              code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
              message: 'Missing Google Auth Token'
          );
        }
      }else{
        throw PlatformException(
            code: 'ERROR_ABORTED_BY_USER',
            message: 'Sign in Aborted By User'
        );
      }

    }
    return Scaffold(
      key: scaffoldkey,
      backgroundColor: HexColor('f39189'),
      body: Center(
        child: SafeArea(
          child: DelayedDisplay(
            slidingCurve: Curves.easeInOutQuart,
            delay: Duration(microseconds: 500),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height:55 ),
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
                  Text("Google SignIn",
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
                            controller: phoneNumber,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 35.0,
                                    fontFamily: 'Qh'
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 35
                                )
                            ),
                            style: TextStyle(
                                fontSize: 30
                            ),
                          ),//EMAIL
                          SizedBox(height: 30,),


                          SizedBox(height: 20),
                          RaisedButton(
                            onPressed: (){
                              if(phoneNumber.text.length!=10)
                              {
                                showSnackBar("Provide a valid Phone Number");
                                return;
                              }
                              signInWithGoogle();
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(25)
                            ),
                            color:Colors.white,
                            textColor: Colors.black,
                            child: Container(
                              height: 50,
                              child: Center(
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:<Widget> [
                                   new Image.asset("asset/images/google.jpg",height: 48,),
                                    Text('Google SignIn',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'Apasto',
                                    ),
                                  ),
                               ], ),
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
                                  'Back to LogIn',
                                  style: TextStyle(
                                      fontSize: 23,
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
        ),
      ),);
  }
}
