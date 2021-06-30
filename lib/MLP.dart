import 'package:cool_cab/screens/myhomepage.dart';
import 'package:cool_cab/screens/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class MLP extends StatefulWidget {
  static const String id="mlp";
  const MLP({Key key}) : super(key: key);

  @override
  _MLPState createState() => _MLPState();
}

class _MLPState extends State<MLP> {
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkCurrentUser();

  }
  Future<void> _checkCurrentUser() async{
    User curruser=await FirebaseAuth.instance.currentUser;
    _updateUser(curruser);
  }
  User _user;
  void _updateUser(User user){
    setState(() {
      _user=user;
    });
  }
  @override
  Widget build(BuildContext context) {
   if (_user==null){
     return RegistrationPg();
   }
   else{
     return MyHomePage();
   }
  }
}
