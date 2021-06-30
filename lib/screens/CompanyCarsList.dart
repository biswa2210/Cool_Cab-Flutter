import 'package:cool_cab/database/Car.dart';
import 'package:cool_cab/database/db.dart';
import 'package:flutter/material.dart';

import 'car_details.dart';
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
class CompanyCarsList extends StatefulWidget {
  static const String id="companyCarslist";
  String companyNm;
  CompanyCarsList({
    @required this.companyNm
});
  @override
  _CompanyCarsListState createState() => _CompanyCarsListState();
}

class _CompanyCarsListState extends State<CompanyCarsList> {
  List<Car> cArs=CarsDB;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Center(
         child: Text(widget.companyNm,style: TextStyle(
              fontFamily: 'MON',
              fontSize: 30,
              color: Colors.black
          ),
         ),
       ),
        backgroundColor: HexColor('#feada6'),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for(int index=0;index<cArs.length;index++)...[
              if( cArs[index].company.toLowerCase()==widget.companyNm.toLowerCase())...[

              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      CarDetails(
                          cArs[index].id,cArs[index].company,
                          cArs[index].logoUrl,cArs[index].name,cArs[index].Engine,cArs[index].Mileage,
                          cArs[index].MaxTorque,cArs[index].MaxPower,cArs[index].BodyType,
                          cArs[index].BootSpace,cArs[index].SeatingCapacity,
                          cArs[index].MarketPrice,cArs[index].images
                      )
                  )
                  );

                },
                child: Container(
                    height: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white,
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
                                  cArs[index].name,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                                  softWrap: false,
                                  maxLines: 3,
                                ),
                                Text(
                                  cArs[index].Mileage,
                                  style: const TextStyle(fontSize: 17, color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  cArs[index].MarketPrice,
                                  style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Image.asset(
                            cArs[index].logoUrl,
                            height: double.infinity,
                            width:60,
                          )
                        ],
                      ),
                    )),
              ),

            ]
          ],]
        ),
      )
    );
  }
}
