import 'package:cool_cab/database/Car.dart';
import 'package:cool_cab/dataprovider/appdata.dart';
import 'package:cool_cab/widgets/ProgressBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cool_cab/screens/car_details.dart';
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
class CompareScreen extends StatefulWidget {
  static const String id ="comparison";
  @override
  _CompareScreenState createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  /* -------> Read Datas From Firebase <-------- */
  var pok;
  /* Temporary Storage */
  Car c;
  int idofc;
  String img1;
  String img2;
  String img3;
  String img4;
  String img5;
  String img6;
  String name;
  String company;
  String logourl;
  String engine;
  String mileage;
  String maxtorque;
  String maxpower;
  String bodytype;
  String bootspace;
  String seatingCap;
  String marketprice;
  /*----------------->*/

  List<Car> Comcars=[];
  void ComSet() async{
    var dbRef = FirebaseDatabase.instance.reference().child("users");
    dbRef.child('${FirebaseAuth.instance.currentUser.uid}/comcars').once().then((snapshot){
      setState(() {
        pok=snapshot.value.values.toList();
        if(pok.length==3){
          List<Car> tc=[];
          Comcars=tc;
          for(int i=0;i<pok.length;i++){
            img1=pok[i]["images"]["img1"].toString();
            img2=pok[i]["images"]["img2"].toString();
            img3=pok[i]["images"]["img3"].toString();
            img4=pok[i]["images"]["img4"].toString();
            img5=pok[i]["images"]["img5"].toString();
            img6=pok[i]["images"]["img6"].toString();
            List<String> temp=[img1,img2,img3,img4,img5,img6];
            idofc= int.parse(pok[i]["CarId"].toString());
            company= pok[i]["Company"].toString();
            logourl=pok[i]["logoUrl"].toString();
            name=pok[i]["Name"].toString();
            engine=pok[i]["Engine"].toString();
            mileage=pok[i]["Mileage"].toString();
            maxtorque=pok[i]["MaxTorque"].toString();
            maxpower=pok[i]["MaxPower"].toString();
            bodytype=pok[i]["BodyType"].toString();
            bootspace=pok[i]["BootSpace"].toString();
            seatingCap=pok[i]["SeatingCapacity"].toString();
            marketprice=pok[i]["MarketPrice"].toString();
            Comcars.add(Car(
              id:idofc,
              company:company,
              logoUrl:logourl,
              name: name,
              Engine:engine,
              Mileage:mileage,
              MaxTorque:maxtorque,
              MaxPower:maxpower,
              BodyType:bodytype,
              BootSpace:bootspace,
              SeatingCapacity:seatingCap,
              MarketPrice:marketprice,
              images:temp,
            ));
          }
        }
        else if(pok.length==2) {
          List<Car> tc=[];
          Comcars=tc;
          for(int i=0;i<pok.length;i++){
            img1=pok[i]["images"]["img1"].toString();
            img2=pok[i]["images"]["img2"].toString();
            img3=pok[i]["images"]["img3"].toString();
            img4=pok[i]["images"]["img4"].toString();
            img5=pok[i]["images"]["img5"].toString();
            img6=pok[i]["images"]["img6"].toString();
            List<String> temp=[img1,img2,img3,img4,img5,img6];
            idofc= int.parse(pok[i]["CarId"].toString());
            company= pok[i]["Company"].toString();
            logourl=pok[i]["logoUrl"].toString();
            name=pok[i]["Name"].toString();
            engine=pok[i]["Engine"].toString();
            mileage=pok[i]["Mileage"].toString();
            maxtorque=pok[i]["MaxTorque"].toString();
            maxpower=pok[i]["MaxPower"].toString();
            bodytype=pok[i]["BodyType"].toString();
            bootspace=pok[i]["BootSpace"].toString();
            seatingCap=pok[i]["SeatingCapacity"].toString();
            marketprice=pok[i]["MarketPrice"].toString();
            Comcars.add(Car(
              id:idofc,
              company:company,
              logoUrl:logourl,
              name: name,
              Engine:engine,
              Mileage:mileage,
              MaxTorque:maxtorque,
              MaxPower:maxpower,
              BodyType:bodytype,
              BootSpace:bootspace,
              SeatingCapacity:seatingCap,
              MarketPrice:marketprice,
              images:temp,
            ));
          }
          img1="";
          img2="";
          img3="";
          img4="";
          img5="";
          img6="";
          List<String> temp=[img1,img2,img3,img4,img5,img6];
          idofc= int.parse("1");
          company= "";
          logourl="";
          name="";
          engine="";
          mileage="";
          maxtorque="";
          maxpower="";
          bodytype="";
          bootspace="";
          seatingCap="";
          marketprice="";
          Comcars.add(Car(
            id:idofc,
            company:company,
            logoUrl:logourl,
            name: name,
            Engine:engine,
            Mileage:mileage,
            MaxTorque:maxtorque,
            MaxPower:maxpower,
            BodyType:bodytype,
            BootSpace:bootspace,
            SeatingCapacity:seatingCap,
            MarketPrice:marketprice,
            images:temp,
          ));
        }
        else if(pok.length==1) {
          List<Car> tc=[];
          Comcars=tc;
          for(int i=0;i<pok.length;i++){
            img1=pok[i]["images"]["img1"].toString();
            img2=pok[i]["images"]["img2"].toString();
            img3=pok[i]["images"]["img3"].toString();
            img4=pok[i]["images"]["img4"].toString();
            img5=pok[i]["images"]["img5"].toString();
            img6=pok[i]["images"]["img6"].toString();
            List<String> temp=[img1,img2,img3,img4,img5,img6];
            idofc= int.parse(pok[i]["CarId"].toString());
            company= pok[i]["Company"].toString();
            logourl=pok[i]["logoUrl"].toString();
            name=pok[i]["Name"].toString();
            engine=pok[i]["Engine"].toString();
            mileage=pok[i]["Mileage"].toString();
            maxtorque=pok[i]["MaxTorque"].toString();
            maxpower=pok[i]["MaxPower"].toString();
            bodytype=pok[i]["BodyType"].toString();
            bootspace=pok[i]["BootSpace"].toString();
            seatingCap=pok[i]["SeatingCapacity"].toString();
            marketprice=pok[i]["MarketPrice"].toString();
            Comcars.add(Car(
              id:idofc,
              company:company,
              logoUrl:logourl,
              name: name,
              Engine:engine,
              Mileage:mileage,
              MaxTorque:maxtorque,
              MaxPower:maxpower,
              BodyType:bodytype,
              BootSpace:bootspace,
              SeatingCapacity:seatingCap,
              MarketPrice:marketprice,
              images:temp,
            ));
          }
          img1="";
          img2="";
          img3="";
          img4="";
          img5="";
          img6="";
          List<String> temp=[img1,img2,img3,img4,img5,img6];
          idofc= int.parse("1");
          company= "";
          logourl="";
          name="";
          engine="";
          mileage="";
          maxtorque="";
          maxpower="";
          bodytype="";
          bootspace="";
          seatingCap="";
          marketprice="";
          Comcars.add(Car(
            id:idofc,
            company:company,
            logoUrl:logourl,
            name: name,
            Engine:engine,
            Mileage:mileage,
            MaxTorque:maxtorque,
            MaxPower:maxpower,
            BodyType:bodytype,
            BootSpace:bootspace,
            SeatingCapacity:seatingCap,
            MarketPrice:marketprice,
            images:temp,
          ));
          idofc= int.parse("2");
          Comcars.add(Car(
            id:idofc,
            company:company,
            logoUrl:logourl,
            name: name,
            Engine:engine,
            Mileage:mileage,
            MaxTorque:maxtorque,
            MaxPower:maxpower,
            BodyType:bodytype,
            BootSpace:bootspace,
            SeatingCapacity:seatingCap,
            MarketPrice:marketprice,
            images:temp,
          ));
        }

      }


      );

    });
  }
  void fstIni(){
    setState(() {
      img1="";
      img2="";
      img3="";
      img4="";
      img5="";
      img6="";
      List<String> temp=[img1,img2,img3,img4,img5,img6];
      company= "";
      logourl="";
      name="";
      engine="";
      mileage="";
      maxtorque="";
      maxpower="";
      bodytype="";
      bootspace="";
      seatingCap="";
      marketprice="";
      idofc= int.parse("1");
      Comcars.add(Car(
        id:idofc,
        company:company,
        logoUrl:logourl,
        name: name,
        Engine:engine,
        Mileage:mileage,
        MaxTorque:maxtorque,
        MaxPower:maxpower,
        BodyType:bodytype,
        BootSpace:bootspace,
        SeatingCapacity:seatingCap,
        MarketPrice:marketprice,
        images:temp,
      ));
      idofc= int.parse("2");
      Comcars.add(Car(
        id:idofc,
        company:company,
        logoUrl:logourl,
        name: name,
        Engine:engine,
        Mileage:mileage,
        MaxTorque:maxtorque,
        MaxPower:maxpower,
        BodyType:bodytype,
        BootSpace:bootspace,
        SeatingCapacity:seatingCap,
        MarketPrice:marketprice,
        images:temp,
      ));
      idofc= int.parse("3");
      Comcars.add(Car(
        id:idofc,
        company:company,
        logoUrl:logourl,
        name: name,
        Engine:engine,
        Mileage:mileage,
        MaxTorque:maxtorque,
        MaxPower:maxpower,
        BodyType:bodytype,
        BootSpace:bootspace,
        SeatingCapacity:seatingCap,
        MarketPrice:marketprice,
        images:temp,
      ));
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    fstIni();
    ComSet();
    AppBar boompokbar=AppBar(
      title: Center(
        child: Text("COMPARISON",style: TextStyle(
            fontFamily: 'qh',
            fontSize: 35,
            letterSpacing: 2,
            color: Colors.black
        ),
        ),
      ),
      backgroundColor: HexColor('#feada6'),
    );
    return Scaffold(
      backgroundColor: HexColor('#feada6'),
      appBar: boompokbar,
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                  child: Container(
                    width: MediaQuery.of(context).size.width-5,
                    height: MediaQuery.of(context).size.height-boompokbar.preferredSize.height-100 ,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: HexColor('#f5efef').withOpacity(0.8),
                        boxShadow: [
                          BoxShadow(
                            color:Colors.red,
                            spreadRadius: 4,
                            blurRadius: 15,
                          ),
                          BoxShadow(
                            color: Colors.red,
                            spreadRadius: -4,
                            blurRadius: 25,
                          )
                        ]),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                margin: EdgeInsets.all(15.0),
                                padding: EdgeInsets.all(15.0),

                                child: Table(

                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  border: TableBorder.symmetric(inside: BorderSide(width: 1, color: Colors.red), outside: BorderSide(width: 1)),
                                  children: [
                                    TableRow(children: [
                                      Text('KEYS', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'MON',fontSize: 24)),
                                      Text('1ST CAR', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'MON',fontSize: 18)),
                                      Text('2ND CAR', textAlign: TextAlign.center,style: TextStyle(fontFamily: 'MON',fontSize: 18)),
                                      Text('3RD CAR', textAlign: TextAlign.center,style: TextStyle(fontFamily: 'MON',fontSize: 18)),

                                    ]),
                                    TableRow(children: [
                                      Text('NAME', textAlign: TextAlign.center,style: TextStyle(fontFamily: 'MON',fontSize: 20)),
                                      Text(Comcars[0].name.isNotEmpty?Comcars[0].name:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[1].name.isNotEmpty?Comcars[1].name:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[2].name.isNotEmpty?Comcars[2].name:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                    ]),
                                    TableRow(children: [
                                      Text('COMPANY', textAlign: TextAlign.center,style: TextStyle(fontFamily: 'MON',fontSize: 20)),
                                      Text(Comcars[0].company.isNotEmpty?Comcars[0].company:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[1].company.isNotEmpty?Comcars[1].company:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[2].company.isNotEmpty?Comcars[2].company:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                    ]),
                                    TableRow(children: [
                                      Text('ENGINE', textAlign: TextAlign.center,style: TextStyle(fontFamily: 'MON',fontSize: 20)),
                                      Text(Comcars[0].Engine.isNotEmpty?Comcars[0].Engine:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[1].Engine.isNotEmpty?Comcars[1].Engine:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[2].Engine.isNotEmpty?Comcars[2].Engine:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                    ]),
                                    TableRow(children: [
                                      Text('MILEAGE', textAlign: TextAlign.center,style: TextStyle(fontFamily: 'MON',fontSize: 20)),
                                      Text(Comcars[0].Mileage.isNotEmpty?Comcars[0].Mileage:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[1].Mileage.isNotEmpty?Comcars[1].Mileage:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[2].Mileage.isNotEmpty?Comcars[2].Mileage:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                    ]),
                                    TableRow(children: [
                                      Text('MAX TORQUE', textAlign: TextAlign.center,style: TextStyle(fontFamily: 'MON',fontSize: 20)),
                                      Text(Comcars[0].MaxTorque.isNotEmpty?Comcars[0].MaxTorque:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[1].MaxTorque.isNotEmpty?Comcars[1].MaxTorque:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[2].MaxTorque.isNotEmpty?Comcars[2].MaxTorque:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                    ]),
                                    TableRow(children: [
                                      Text('MAX POWER', textAlign: TextAlign.center,style: TextStyle(fontFamily: 'MON',fontSize: 20)),
                                      Text(Comcars[0].MaxPower.isNotEmpty?Comcars[0].MaxPower:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[1].MaxPower.isNotEmpty?Comcars[1].MaxPower:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[2].MaxPower.isNotEmpty?Comcars[2].MaxPower:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                    ]),
                                    TableRow(children: [
                                      Text('BODY TYPE', textAlign: TextAlign.center,style: TextStyle(fontFamily: 'MON',fontSize: 20)),
                                      Text(Comcars[0].BodyType.isNotEmpty?Comcars[0].BodyType:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[1].BodyType.isNotEmpty?Comcars[1].BodyType:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[2].BodyType.isNotEmpty?Comcars[2].BodyType:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                    ]),
                                    TableRow(children: [
                                      Text('BOOTS SPACE', textAlign: TextAlign.center,style: TextStyle(fontFamily: 'MON',fontSize: 20)),
                                      Text(Comcars[0].BootSpace.isNotEmpty?Comcars[0].BootSpace:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[1].BootSpace.isNotEmpty?Comcars[1].BootSpace:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[2].BootSpace.isNotEmpty?Comcars[2].BootSpace:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                    ]),
                                    TableRow(children: [
                                      Text('SEATING CAPACITY', textAlign: TextAlign.center,style: TextStyle(fontFamily: 'MON',fontSize: 20)),
                                      Text(Comcars[0].SeatingCapacity.isNotEmpty?Comcars[0].SeatingCapacity:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[1].SeatingCapacity.isNotEmpty?Comcars[1].SeatingCapacity:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[2].SeatingCapacity.isNotEmpty?Comcars[2].SeatingCapacity:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                    ]),
                                    TableRow(children: [
                                      Text('Price', textAlign: TextAlign.center,style: TextStyle(fontFamily: 'MON',fontSize: 20)),
                                      Text(Comcars[0].MarketPrice.isNotEmpty?Comcars[0].MarketPrice:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[1].MarketPrice.isNotEmpty?Comcars[1].MarketPrice:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                      Text(Comcars[2].MarketPrice.isNotEmpty?Comcars[2].MarketPrice:"NULL", textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: 'BoltS',fontSize: 18)),
                                    ]),
                                    TableRow(children: [
                                      Text('Go', textAlign: TextAlign.center,style: TextStyle(fontFamily: 'MON',fontSize: 40)),
                                      GestureDetector(

                                          onTap: (){
                                            Comcars[0].name.isNotEmpty ?
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                CarDetails(
                                                    Comcars[0].id,Comcars[0].company,
                                                    Comcars[0].logoUrl,Comcars[0].name,
                                                    Comcars[0].Engine,Comcars[0].Mileage,
                                                    Comcars[0].MaxTorque,Comcars[0].MaxPower,
                                                    Comcars[0].BodyType,Comcars[0].BootSpace,
                                                    Comcars[0].SeatingCapacity,
                                                    Comcars[0].MarketPrice,Comcars[0].images))):
                                            showDialog(context: context, builder: (BuildContext context)=>leadDialog);

                                          },
                                          child: CircleAvatar(child: Icon(Icons.navigate_next,size: 20,),backgroundColor: Colors.black,radius: 15,)),
                                      GestureDetector(
                                          onTap: (){
                                            Comcars[1].name.isNotEmpty ?
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                CarDetails(
                                                    Comcars[1].id,Comcars[1].company,
                                                    Comcars[1].logoUrl,Comcars[1].name,
                                                    Comcars[1].Engine,Comcars[1].Mileage,
                                                    Comcars[1].MaxTorque,Comcars[1].MaxPower,
                                                    Comcars[1].BodyType,Comcars[1].BootSpace,
                                                    Comcars[1].SeatingCapacity,
                                                    Comcars[1].MarketPrice,Comcars[1].images))):
                                            showDialog(context: context, builder: (BuildContext context)=>leadDialog);
                                          },
                                          child: CircleAvatar(child: Icon(Icons.navigate_next,size: 20,),backgroundColor: Colors.black,radius: 15,)),
                                      GestureDetector(
                                          onTap: (){
                                            Comcars[2].name.isNotEmpty ?
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                CarDetails(
                                                    Comcars[2].id,Comcars[2].company,
                                                    Comcars[2].logoUrl,Comcars[2].name,
                                                    Comcars[2].Engine,Comcars[2].Mileage,
                                                    Comcars[2].MaxTorque,Comcars[2].MaxPower,
                                                    Comcars[2].BodyType,Comcars[2].BootSpace,
                                                    Comcars[2].SeatingCapacity,
                                                    Comcars[2].MarketPrice,Comcars[2].images))):
                                            showDialog(context: context, builder: (BuildContext context)=>leadDialog);
                                          },
                                          child: CircleAvatar(child: Icon(Icons.navigate_next,size: 20,),backgroundColor: Colors.black,radius: 15,)),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: HexColor('#feada6'),
                          spreadRadius: 4,
                          blurRadius: 15,
                        ),
                        BoxShadow(
                          color:Colors.red,
                          spreadRadius: -4,
                          blurRadius: 25,
                        )
                      ]),
                  child: RaisedButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () async {
                      showDialog(context: context, builder: (BuildContext context)=>ProgressBar(
                          status:"Resetting..."),);
                      Future.delayed(Duration(seconds: 3), () async{
                        await FirebaseDatabase.instance.reference().child('users/${FirebaseAuth.instance.currentUser.uid}/comcars').remove().then(
                                (value){
                              Navigator.pop(context);
                              Navigator.popAndPushNamed(context, CompareScreen.id);
                            }

                        );
                      });

                    },
                    child: Text("RESET",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),),
                    color: Colors.black,

                  ),
                ),
                SizedBox(height: 5,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
Dialog leadDialog = Dialog(
  child: Container(
    height: 130.0,
    width: 130.0,
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
            'NO CARS ASSIGNED YET',
            style:
            TextStyle(color: Colors.black, fontSize: 21.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontFamily: 'qh'),
          ),
        ),
      ],
    ),
  ),
);