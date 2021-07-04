import 'dart:io';
/*
CREATED BY BISWARUP BHATTACHARJEE
EMAIL    : bbiswa471@gmail.com
PHONE NO : 6290272740
*/
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cool_cab/dataprovider/appdata.dart';
import 'package:cool_cab/screens/myhomepage.dart';
import 'package:cool_cab/screens/searchpage.dart';
import 'package:cool_cab/widgets/BrandDevidder.dart';
import 'package:cool_cab/widgets/DrawerItemStyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
class CarDetails extends StatefulWidget {
  static const String id="CarDetails";
  final int idofcar;
  final String company;
  final String logoUrl;
  final String name;
  final String Engine;
  final String Mileage;
  final String MaxTorque;
  final String MaxPower;
  final String BodyType;
  final String BootSpace;
  final String SeatingCapacity;
  final String MarketPrice;
  final List<String> images;
  CarDetails(this.idofcar, this.company, this.logoUrl, this.name, this.Engine, this.Mileage, this.MaxTorque, this.MaxPower, this.BodyType, this.BootSpace, this.SeatingCapacity, this.MarketPrice, this.images);
  @override
  _CarDetailsState createState() => _CarDetailsState();
}
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
class _CarDetailsState extends State<CarDetails> {
  var pok;
  bool isFav;
  bool isCom;
  List<int> ids = [];
  List<int> comids=[];
  void FavButtonSet() async{
    var Dbref=FirebaseDatabase.instance.reference().child('users');
    Dbref.child('${FirebaseAuth.instance.currentUser.uid}/cars').once().then((snapshot){
      setState(() {
        pok=snapshot.value.values.toList();
        for(int i=0;i<pok.length;i++){
          int p=int.parse(pok[i]["CarId"].toString());
          ids.add(p);
          ids=ids.toSet().toList();
        }
        if(ids.contains(int.parse(widget.idofcar.toString()))){
          isFav=true;
        }
        else{
          isFav=false;
        }
      });
      print(isFav);
    });

  }
  void ComButtonSet() async{
    var Dbref=FirebaseDatabase.instance.reference().child('users');
    Dbref.child('${FirebaseAuth.instance.currentUser.uid}/comcars').once().then((snapshot){
      setState(() {
        pok=snapshot.value.values.toList();
        for(int i=0;i<pok.length;i++){
          int p=int.parse(pok[i]["CarId"].toString());
          comids.add(p);
          comids=comids.toSet().toList();
        }
        if(comids.contains(int.parse(widget.idofcar.toString()))){
          isCom=true;
        }
        else{
          isCom=false;
        }
      });
      print(isCom);
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    FavButtonSet();
    ComButtonSet();
    super.initState();
  }
  double searchSheetHeight;
  bool flag=false;
  @override
  Widget build(BuildContext context) {

FavButtonSet();
ComButtonSet();
    final List<Image> imgList=[
      Image.network( widget.images[0],fit: BoxFit.cover,),
      Image.network( widget.images[1],fit: BoxFit.cover,),
      Image.network( widget.images[2],fit: BoxFit.cover,),
      Image.network( widget.images[3],fit: BoxFit.cover,),
      Image.network( widget.images[4],fit: BoxFit.cover,),
      Image.network( widget.images[5],fit: BoxFit.cover,),
    ];
    searchSheetHeight= (Platform.isIOS) ? MediaQuery.of(context).size.height *0.65 : MediaQuery.of(context).size.height *0.65 ;
    return Scaffold(
    body: Stack(
       children: <Widget>[

        Positioned(
          top: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.35,
              child: Carousel(
                images: imgList,
                dotColor: HexColor('eeebdd'),
                dotIncreasedColor: HexColor('ead3cb'),
                defaultImage: Image.asset("asset/images/lamborghini.png"),
                autoplayDuration: Duration(seconds: 15),
                animationCurve: Curves.decelerate,
                animationDuration: Duration(seconds: 1),
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
                color: HexColor('eeebdd'),
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
                    Text('Nice to see this Car',style: TextStyle(fontFamily: 'BoltS',fontSize: 15),),
                    Text(widget.name,style: TextStyle(fontFamily: 'BoltS',fontSize: 25),maxLines: 2,),
                    SizedBox(height: 15,),
                    GestureDetector(
                      onTap: () {
                        if(flag){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: HexColor('f0e3ca'),
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
                              Icon(Icons.money,color: Colors.black,size: 35,),
                              SizedBox(width: 10,),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(widget.MarketPrice,style: TextStyle(fontSize: 25,fontFamily:'qh',letterSpacing:2
                                  ,fontWeight: FontWeight.bold),softWrap: false,),
                                ),
                              )
                            ],),

                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    BrandDevider(),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset("asset/icons/engine.png",height: 60,),
                        SizedBox(width: 20,),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(widget.Engine,style: TextStyle(fontFamily: 'BoltS',fontSize: 18),softWrap: false,),
                              SizedBox(height: 5),
                              Text('Engine details',style: TextStyle(fontFamily: 'BoltR',fontSize: 14),)
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 10,),
                        Image.asset("asset/icons/mileage.png",height: 60,),
                        SizedBox(width:35,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Text(widget.Mileage,style: TextStyle(fontFamily: 'BoltS',fontSize: 18),softWrap: false,),
                            SizedBox(height: 5),
                            Text('Mileage Information',style: TextStyle(fontFamily: 'BoltR',fontSize: 14),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 10,),
                        Image.asset("asset/icons/company.png",height: 60,),
                        SizedBox(width: 35,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Text(widget.company,style: TextStyle(fontFamily: 'BoltS',fontSize: 18),softWrap: false,),
                            SizedBox(height: 5),
                            Text('Company Information',style: TextStyle(fontFamily: 'BoltR',fontSize: 14),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 10,),
                        Image.asset("asset/icons/torque.png",height: 60,),
                        SizedBox(width: 35,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(
                                height: 20,
                                width: MediaQuery.of(context).size.width - 180,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(widget.MaxTorque,style: TextStyle(fontFamily: 'BoltS',fontSize: 18)))),
                                  ],
                                )),
                            SizedBox(height: 5),
                            Text('Maximum Torque',style: TextStyle(fontFamily: 'BoltR',fontSize: 14),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 10,),
                        Image.asset("asset/icons/maxpower.png",height: 60,),
                        SizedBox(width: 35,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                height: 20,
                                width: MediaQuery.of(context).size.width - 180,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(widget.MaxPower,style: TextStyle(fontFamily: 'BoltS',fontSize: 18)))),
                                  ],
                                )),
                            SizedBox(height: 5),
                            Text('Maximum Power',style: TextStyle(fontFamily: 'BoltR',fontSize: 14),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 1,),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 5,),
                        Image.asset("asset/icons/bootspace.png",height: 60,),
                        SizedBox(width: 40,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Text(widget.BootSpace,style: TextStyle(fontFamily: 'BoltS',fontSize: 18),softWrap: false,),
                            SizedBox(height: 5),
                            Text('Boots Space',style: TextStyle(fontFamily: 'BoltR',fontSize: 14),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 10,),
                        Image.asset("asset/icons/bodytype.png",height: 60,),
                        SizedBox(width: 35,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(
                                height: 20,
                                width: MediaQuery.of(context).size.width - 220,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(widget.BodyType,style: TextStyle(fontFamily: 'BoltS',fontSize: 18)))),
                                  ],
                                )),
                            SizedBox(height: 5),
                            Text('Body Type',style: TextStyle(fontFamily: 'BoltR',fontSize: 14),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 10,),
                        Image.asset("asset/icons/seatingcapacity.png",height: 60,),
                        SizedBox(width: 35,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 20,
                              width: MediaQuery.of(context).size.width - 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(widget.SeatingCapacity,style: TextStyle(fontFamily: 'BoltS',fontSize: 18),)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Text('Seating Capacity',style: TextStyle(fontFamily: 'BoltR',fontSize: 14),softWrap: false,)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    BrandDevider(),
                  ],
                ),
              ),

            ),
          ),
        ),
         Positioned(
             bottom: 10,
             right: 20,
               child: FloatingActionButton(
                   backgroundColor: HexColor('faf2da'),
                   child: Icon(Icons.favorite,
                   color: '${isFav}'=='true' ? Colors.red:Colors.black,
                   size: '${isFav}'=='true'? 40 :30,),
                 onPressed: () async{
                   if('${isFav}'=='true'){
                     await FirebaseDatabase.instance.reference().child('users/${FirebaseAuth.instance.currentUser.uid}/cars/car${widget.idofcar}').remove().then(
                             (value) => Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>CarDetails(widget.idofcar, widget.company, widget.logoUrl, widget.name, widget.Engine, widget.Mileage, widget.MaxTorque, widget.MaxPower, widget.BodyType, widget.BootSpace, widget.SeatingCapacity, widget.MarketPrice, widget.images))));
                    
                   }
                   else{
                     DatabaseReference newref=FirebaseDatabase.instance.reference().child('users/${FirebaseAuth.instance.currentUser.uid}/cars/car${widget.idofcar}');
                     Map UserMap ={
                       "CarId":widget.idofcar,
                       "Engine":widget.Engine,
                       "Mileage":widget.Mileage,
                       "Name":widget.name,
                       "MaxTorque":widget.MaxTorque,
                       "MaxPower":widget.MaxPower,
                       "Company":widget.company,
                       "BodyType":widget.BodyType,
                       "BootSpace":widget.BootSpace,
                       "MarketPrice":widget.MarketPrice,
                       "logoUrl":widget.logoUrl,
                       "SeatingCapacity":widget.SeatingCapacity
                     };
                     DatabaseReference imgRef=FirebaseDatabase.instance.reference().child('users/${FirebaseAuth.instance.currentUser.uid}/cars/car${widget.idofcar}/images');
                     Map ImgMap={
                       "img1":widget.images[0],
                       "img2":widget.images[1],
                       "img3":widget.images[2],
                       "img4":widget.images[3],
                       "img5":widget.images[4],
                       "img6":widget.images[5],

                     };
                     newref.set(UserMap);
                     imgRef.set(ImgMap).then(
                         (value) =>
                             Navigator.pushReplacement(context, MaterialPageRoute(
                                 builder:(context)=>CarDetails(widget.idofcar,
                             widget.company, widget.logoUrl, widget.name,
                                     widget.Engine, widget.Mileage, widget.MaxTorque, widget.MaxPower,
                             widget.BodyType, widget.BootSpace, widget.SeatingCapacity,
                                     widget.MarketPrice, widget.images))));
                   }
                   }
               ),
             ),
         Positioned(
           bottom: 80,
           right: 20,
           child: FloatingActionButton(
               backgroundColor: HexColor('faf2da'),
               child: Icon(Icons.compare,
                 color: '${isCom}' =='true' ? Colors.red : Colors.black,
                 size: '${isCom}' =='true'? 40 :30,),
               onPressed: () async{

                   if('${isCom}'=='true'){
                  await FirebaseDatabase.instance.reference().child('users/${FirebaseAuth.instance.currentUser.uid}/comcars/car${widget.idofcar}').remove().then(
                  (value) => Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>CarDetails(widget.idofcar, widget.company, widget.logoUrl, widget.name, widget.Engine, widget.Mileage, widget.MaxTorque, widget.MaxPower, widget.BodyType, widget.BootSpace, widget.SeatingCapacity, widget.MarketPrice, widget.images))));
                  }
                   else{
                     if(comids.length<3){
                     DatabaseReference newref=FirebaseDatabase.instance.reference().child('users/${FirebaseAuth.instance.currentUser.uid}/comcars/car${widget.idofcar}');
                     Map UserMap ={
                       "CarId":widget.idofcar,
                       "Engine":widget.Engine,
                       "Mileage":widget.Mileage,
                       "Name":widget.name,
                       "MaxTorque":widget.MaxTorque,
                       "MaxPower":widget.MaxPower,
                       "Company":widget.company,
                       "BodyType":widget.BodyType,
                       "BootSpace":widget.BootSpace,
                       "MarketPrice":widget.MarketPrice,
                       "logoUrl":widget.logoUrl,
                       "SeatingCapacity":widget.SeatingCapacity
                     };
                     DatabaseReference imgRef=FirebaseDatabase.instance.reference().child('users/${FirebaseAuth.instance.currentUser.uid}/comcars/car${widget.idofcar}/images');
                     Map ImgMap={
                       "img1":widget.images[0],
                       "img2":widget.images[1],
                       "img3":widget.images[2],
                       "img4":widget.images[3],
                       "img5":widget.images[4],
                       "img6":widget.images[5],

                     };
                     newref.set(UserMap);
                     imgRef.set(ImgMap).then(
                             (value) =>
                             Navigator.pushReplacement(context, MaterialPageRoute(
                                 builder:(context)=>CarDetails(widget.idofcar,
                                     widget.company, widget.logoUrl, widget.name,
                                     widget.Engine, widget.Mileage, widget.MaxTorque, widget.MaxPower,
                                     widget.BodyType, widget.BootSpace, widget.SeatingCapacity,
                                     widget.MarketPrice, widget.images))));
                   }
                     else{
                       showDialog(
                           context: context,
                           builder: (BuildContext context) => leadDialog);
                     }
                   }
                 }


           ),
         )
      ],
    ),
    );
  }
}
Dialog leadDialog = Dialog(
  child: Container(
    height: 130.0,
    width: 120.0,
    decoration: BoxDecoration(
      color: HexColor('faf2da'),
        boxShadow: [
          BoxShadow(
            color: HexColor('#feada6'),
            spreadRadius: 4,
            blurRadius: 15,
          ),
          BoxShadow(
            color: HexColor('#f5efef'),
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
          size: 60,),
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            'Comparison Table is Full',
            style:
            TextStyle(color: Colors.black, fontSize: 22.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontFamily: 'qh'),
          ),
        ),
      ],
    ),
  ),
);
