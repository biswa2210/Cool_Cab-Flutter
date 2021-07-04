import 'package:cool_cab/MLP.dart';
import 'package:cool_cab/database/company.dart';
/*
CREATED BY BISWARUP BHATTACHARJEE
EMAIL    : bbiswa471@gmail.com
PHONE NO : 6290272740
*/
import 'package:cool_cab/dataprovider/appdata.dart';
import 'package:cool_cab/screens/AboutPg.dart';
import 'package:cool_cab/screens/CompanyCarsList.dart';
import 'package:cool_cab/screens/CompanyDetail.dart';
import 'package:cool_cab/screens/ComparisonSc.dart';
import 'package:cool_cab/screens/allCars.dart';
import 'package:cool_cab/screens/car_details.dart';
import 'package:cool_cab/screens/contacctUs.dart';
import 'package:cool_cab/screens/favourities.dart';
import 'package:cool_cab/screens/googleSignIn.dart';
import 'package:cool_cab/screens/loginpg.dart';
import 'package:cool_cab/screens/profile.dart';
import 'package:cool_cab/screens/registration.dart';
import 'package:cool_cab/screens/resetPass.dart';
import 'package:cool_cab/screens/searchpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cool_cab/screens/myhomepage.dart';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    options: Platform.isIOS || Platform.isMacOS
        ? const FirebaseOptions(
      apiKey: "AIzaSyDi9kIaCeKXmmU2GHyk_AZiufVANLhwUaY",
      appId: "1:251549165284:ios:3e4d0fe174e5103ae8aef1",
      databaseURL: "https://cool-cab-b8194-default-rtdb.firebaseio.com",
      messagingSenderId: "251549165284",
      projectId: "cool-cab-b8194"

    )
        : const FirebaseOptions(
      apiKey: 'AIzaSyBpGv6op5xuhCCIPqGcouFod6NNUZTVyAM',
      appId: '1:251549165284:android:303fcf5a685f0ec3e8aef1',
      databaseURL: 'https://cool-cab-b8194-default-rtdb.firebaseio.com',
      messagingSenderId: "251549165284",
        projectId: "cool-cab-b8194"

    ),
  );
/*App Show Always In Potrait Mode*/
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>AppData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute:MLP.id,
        routes: {
          RegistrationPg.id : (context)=>RegistrationPg(),
          LoginPage.id:(context)=>LoginPage(),
          MyHomePage.id:(context)=>MyHomePage(),
          ResetPassword.id:(context)=>ResetPassword(),
          GoogleSignInPage.id:(context)=>GoogleSignInPage(),
          SearchPage.id:(context)=>SearchPage(),
          AllCar.id:(context)=>AllCar(),
          Profile.id:(context)=>Profile(),
          MLP.id:(context)=>MLP(),
          FavouritesPg.id:(context)=>FavouritesPg(),
          CompanyDetail.id:(context)=>CompanyDetail(),
          CompanyCarsList.id:(context)=>CompanyCarsList(),
          CompareScreen.id:(context)=>CompareScreen(),
          ContactUs.id:(context)=>ContactUs(),
          AboutPG.id:(context)=>AboutPG()

        },
      ),
    );
  }
}
