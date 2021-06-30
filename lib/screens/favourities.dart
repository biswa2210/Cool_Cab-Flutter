import 'package:cool_cab/database/Car.dart';
import 'package:cool_cab/screens/car_details.dart';
import 'package:cool_cab/widgets/BrandDevidder.dart';
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
class FavouritesPg extends StatefulWidget {
  static const String id ="favPg";
  @override
  _FavouritesPgState createState() => _FavouritesPgState();
}

class _FavouritesPgState extends State<FavouritesPg> {

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

  List<Car> Favcars=[];
  void FavSet() async{
    var dbRef = FirebaseDatabase.instance.reference().child("users");
    dbRef.child('${FirebaseAuth.instance.currentUser.uid}/cars').once().then((snapshot){
      setState(() {
        pok=snapshot.value.values.toList();
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
         Favcars.add(Car(
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
      });

    });
  }
 @override
  void initState() {
    // TODO: implement initState
   FavSet();
    super.initState();
  }
  /*-----------------------------------------*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("e28f83"),
        title: Center(child: Text("Favourites Cars",style: TextStyle(color: Colors.black,letterSpacing: 2
        ,fontFamily: 'qh',fontSize: 35),)
        ),
      ),

      body: ListView.builder(
        itemCount: Favcars.length,
        itemBuilder: (context,int index){
          return GestureDetector(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>
              CarDetails(
                Favcars[index].id,
                Favcars[index].company,
                Favcars[index].logoUrl,
                Favcars[index].name,
                Favcars[index].Engine,
                Favcars[index].Mileage,
                Favcars[index].MaxTorque,
                Favcars[index].MaxPower,
                Favcars[index].BodyType,
                Favcars[index].BootSpace,
                Favcars[index].SeatingCapacity,
                Favcars[index].MarketPrice,
                Favcars[index].images
              )));
            },
            child: Container(
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
                  BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                             Favcars[index].name,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                              softWrap: false,
                              maxLines: 3,
                            ),
                            Text(
                              Favcars[index].Mileage,
                              style: const TextStyle(fontSize: 17, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              Favcars[index].MarketPrice,
                              style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Image.asset(
                        Favcars[index].logoUrl,
                        height: double.infinity,
                        width:60,
                      )
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
