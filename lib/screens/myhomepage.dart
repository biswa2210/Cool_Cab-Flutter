import 'dart:async';
import 'dart:io';
/*
CREATED BY BISWARUP BHATTACHARJEE
EMAIL    : bbiswa471@gmail.com
PHONE NO : 6290272740
*/
import 'package:brand_colors/brand_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_cab/dataprovider/appdata.dart';
import 'package:cool_cab/helpers.dart';
import 'package:cool_cab/screens/AboutPg.dart';
import 'package:cool_cab/screens/ComparisonSc.dart';
import 'package:cool_cab/screens/allCars.dart';
import 'package:cool_cab/screens/contacctUs.dart';
import 'package:cool_cab/screens/favourities.dart';
import 'package:cool_cab/screens/loginpg.dart';
import 'package:cool_cab/screens/profile.dart';
import 'package:cool_cab/screens/searchCompany.dart';
import 'package:cool_cab/screens/searchpage.dart';
import 'package:intl/intl.dart';
import 'package:cool_cab/widgets/BrandDevidder.dart';
import 'package:cool_cab/widgets/DrawerItemStyle.dart';
import 'package:cool_cab/widgets/ProgressBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:quick_feedback/quick_feedback.dart';

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
class MyHomePage extends StatefulWidget {
  static const String id = "myhomepg";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  String emailstr;
  String userid;
  String phone;
  String fullname;
  String firstnm="User";
  String photourl="https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png";
  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();
  double searchSheetHeight= (Platform.isIOS) ? 320 : 320;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  double mapBottomPadding=0;

  Position currentPosition;
  bool flag=false;
  void setupPositionLocator() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition=position;
    LatLng pos= LatLng(position.latitude,position.longitude);
    final cor=new Coordinates(position.latitude, position.longitude);
    CameraPosition cp=new CameraPosition(target: pos,zoom:18);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
    var address=await FindLocation(cor,context);
    print(address);
    flag=true;
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  /*---------------------------------------------FEEDBACK--------------------------------------------------------------->*/


  void _showFeedback(context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String string = dateFormat.format(DateTime.now());
    showDialog(
      context: context,
      builder: (context) {
        return QuickFeedback(
          title: 'Leave a Feedback', // Title of dialog
          showTextBox: true, // default false
          textBoxHint:
          'Share your feedback', // Feedback text field hint text default: Tell us more
          submitText: 'SUBMIT', // submit button text default: SUBMIT
          onSubmitCallback: (feedback) {
            print('$feedback'); // map { rating: 2, feedback: 'some feedback' }
            final firestoreInstance = FirebaseFirestore.instance;

            if(int.parse(feedback['rating'].toString())==0 && feedback['feedback'].toString().isEmpty){
              showDialog(context: context, builder: (BuildContext context)=>Dialog(
                child: Container(
                  height: 130.0,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue,
                          spreadRadius: 4,
                          blurRadius: 15,
                        ),
                        BoxShadow(
                          color: Colors.blue,
                          spreadRadius: -4,
                          blurRadius: 25,
                        )
                      ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Center(
                        child: Icon(Icons.error,
                          color: Colors.black,
                          size: 40,),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Give Your Proper\nRating or Feedback',
                          style:
                          TextStyle(color: Colors.black, fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              fontFamily: 'qh'),
                        ),
                      ),
                    ],
                  ),
                ),
              ));

            }
            else{
              firestoreInstance.collection("feedbacks").add(
                  {
                    "date": string,
                    "email" : FirebaseAuth.instance.currentUser.email,
                    "LatLng": currentPosition.toString(),
                    "feedback":feedback['feedback'],
                    "rating":feedback['rating']
                  }).then((value){
                print(value.id);
              });
              Navigator.of(context).pop();
              showDialog(context: context, builder: (BuildContext context)=>Dialog(
                child: Container(
                  height: 100.0,
                  width: 100,
                  decoration: BoxDecoration(
                      color: HexColor('ead3cb'),
                      boxShadow: [
                        BoxShadow(
                          color: HexColor('ead3cb'),
                          spreadRadius: 4,
                          blurRadius: 15,
                        ),
                        BoxShadow(
                          color: HexColor('ead3cb'),
                          spreadRadius: -4,
                          blurRadius: 25,
                        )
                      ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Center(
                        child: Icon(Icons.done,
                          color: Colors.black,
                          size: 40,),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Successfully Submitted',
                          style:
                          TextStyle(color: Colors.black, fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              fontFamily: 'qh'),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
            }



          },
          askLaterText: 'ASK LATER',
          onAskLaterCallback: () {
            print('Do something on ask later click');
          },
        );
      },
    );
  }
/*-------------------------------------------------------------------------------------------------------------------->*/

  @override
  Widget build(BuildContext context) {
    void _SignOut() async{
      try{
        await FirebaseAuth.instance.signOut();
      }catch(e){
        print(e.toString());
      }
    }
    void profileSet() async{
      String email=await FirebaseAuth.instance.currentUser.email;
      String uid=await FirebaseAuth.instance.currentUser.uid;
      String tempphotourl=await FirebaseAuth.instance.currentUser.photoURL;
      print(tempphotourl);
      if(tempphotourl!=null){
        setState(() {
          photourl=tempphotourl;
        });
      }
      else{
        setState(() {
          photourl="https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png";
        });
      }
      var dbRef = FirebaseDatabase.instance.reference().child("users");
      dbRef.child(uid).once().then((snapshot){
        setState(() {
          fullname=snapshot.value["fullname"].toString();
          List<String> arr=fullname.split(" ");
          String fnm=arr[0];
          firstnm=fnm;
        });
      });
      var dbRef2 = FirebaseDatabase.instance.reference().child("users/${uid}");
      dbRef2.child("phonenumber").once().then((snapshot){
        setState(() {
          phone=snapshot.value["userphno"].toString();
        });
      });

      setState(() {
        emailstr=email;
        userid=uid;
      });
    }
    profileSet();

    return Scaffold(
      key:scaffoldkey,
      drawer: Container(
        width: 280,
        child: Drawer(
         child: ListView(
           padding: EdgeInsets.all(0),
           children: <Widget>[
             Container(
               color: HexColor('ead3cb'),
               height: 180,
               child: DrawerHeader(
                 decoration: BoxDecoration(
                   color:HexColor('ead3cb'),
                   
                 ),
                  child: Row(
                    children: <Widget>[
                      Image.network(photourl,height: 70,width: 65,),
                      SizedBox(width: 20,),
                      Container(
                        width:115,
                        height: 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                    child: Text(firstnm,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 23,fontFamily: 'BoltR'),))),
                            SizedBox(height: 5,),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>Profile(emailstr: emailstr,userid: userid,
                                phone: phone,fullname: fullname,photourl: photourl,)));
                              },
                                child: Container(
                                  width: 115,
                                    child: Text('View Profile',style: TextStyle(fontSize: 16)))),
                          ],
                        ),
                      )
                    ],
                  ),
               ),
             ),
             BrandDevider(),
             ListTile(
                leading: Icon(Icons.storage),
               title: Text('All Cars',style: DrawerStyle,),
               onTap: (){
                 showDialog(context: context, builder: (BuildContext context)=>ProgressBar(
                     status:"Processing..."),);
    Future.delayed(const Duration(milliseconds: 2000), () {
                  Navigator.pushNamedAndRemoveUntil(context,AllCar.id, (route) => false);});
               },
             ),
             ListTile(
               leading: Icon(OMIcons.favorite),
               title: Text('Favorites',style: DrawerStyle,),
               onTap: (){
    showDialog(context: context, builder: (BuildContext context)=>ProgressBar(
    status:"Processing..."),);
    Future.delayed(const Duration(milliseconds: 2000), () {
                 Navigator.pop(context);
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>FavouritesPg()));
    });
               },
             ),
             ListTile(
               leading: Icon(OMIcons.compare),
               title: Text('Comparison',style: DrawerStyle,),
               onTap:(){
                 showDialog(context: context, builder: (BuildContext context)=>ProgressBar(
                     status:"Processing..."),);
                 Future.delayed(const Duration(milliseconds: 2000), () {
                   Navigator.pop(context);
                   Navigator.push(context,MaterialPageRoute(builder: (context)=>CompareScreen()));
                 });

               }
             ),
             ListTile(
               leading: Icon(OMIcons.feedback),
               title: Text('Feedback',style: DrawerStyle,),
               onTap: (){
                 _showFeedback(context);
               },
             ),
             ListTile(
               leading: Icon(OMIcons.contactSupport),
               title: Text('Contact Us',style: DrawerStyle,),
               onTap: (){
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>ContactUs()));
               },
             ),
             ListTile(
               leading: Icon(OMIcons.info),
               title: Text('About',style: DrawerStyle,),
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutPG()));
               },
             ),
             ListTile(
               leading: Icon(OMIcons.exitToApp),
               title: Text('LogOut',style: DrawerStyle,),
               onTap:()async{
      await _SignOut();
      Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
      },
             ),
           ],
         ),

        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            padding: EdgeInsets.only(bottom: mapBottomPadding),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,


            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
              mapController=controller;
              setState(() {
                mapBottomPadding=(Platform.isAndroid)?  320 : 320;
              });
              setupPositionLocator();
            },
          ),
          Positioned(
            top: 45,
            left: 20,
            child: GestureDetector(
              onTap: (){
                scaffoldkey.currentState.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('ead3cb'),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0.5,
                      blurRadius: 5,
                      offset: Offset(
                        0.7,
                        0.7
                      )
                    )
                  ]
                ),
                child: CircleAvatar(
                  backgroundColor: HexColor('ead3cb'),
                  radius: 20,
                  child: Icon(OMIcons.menu,color: Colors.black,size: 30,),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: searchSheetHeight,
              decoration: BoxDecoration(
                  color: HexColor('ead3cb'),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                boxShadow: [BoxShadow(
                  spreadRadius: 6.5,
                  color: Colors.black26,
                  blurRadius: 22.5,
                  offset: Offset(0.9,0.9)
                )]
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12,horizontal: 26),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5,),
                      Text('Nice to see you',style: TextStyle(fontFamily: 'BoltS',fontSize: 15),),
                      Text('Which is your favorite car?',style: TextStyle(fontFamily: 'BoltS',fontSize: 22)),
                      SizedBox(height: 15,),
                      GestureDetector(
                        onTap: () {
                          if(flag){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                              boxShadow: [BoxShadow(
                                  spreadRadius: 6.5,
                                  color: Colors.black12,
                                  blurRadius: 22.5,
                                  offset: Offset(0.9,0.9)
                              )]


                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.search,color: Colors.blueAccent,size: 35,),
                                SizedBox(width: 12,),
                                Expanded(
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text('Search Car\'s Model',style: TextStyle(fontSize: 32,fontFamily:'Ratro',letterSpacing:2.8),)),
                                )
                              ],),

                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      BrandDevider(),
                      SizedBox(height: 10,),
                      Row(
                        children: <Widget>[
                          Icon(OMIcons.home,size: 50,color: Colors.black,),
                          SizedBox(width: 20,),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text((Provider.of<AppData>(context).pickAddress!=null)?Provider.of<AppData>(context).pickAddress.placeName:
                                  'Live Location',style: TextStyle(fontFamily: 'BoltS',fontSize: 18),),
                                SizedBox(height: 5),
                                Text('Your Current Location',style: TextStyle(fontFamily: 'BoltR',fontSize: 14),)
                              ],
                            ),
                          )
                        ],
                      ),

                      SizedBox(height: 10,),
                      BrandDevider(),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () {
                          if(flag){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchCompanyPg()));
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [BoxShadow(
                                  spreadRadius: 6.5,
                                  color: Colors.black12,
                                  blurRadius: 22.5,
                                  offset: Offset(0.9,0.9)
                              )]


                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.search,color: Colors.blueAccent,size: 35,),
                                SizedBox(width: 12,),
                                Expanded(child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text('Search Car\'s Company',style: TextStyle(fontSize: 32,fontFamily:'Ratro',letterSpacing:2.8),)))
                              ],),

                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      BrandDevider(),
                    ],
                  ),
                ),

              ),
            ),
          )
        ],

      )
    );
  }
}
