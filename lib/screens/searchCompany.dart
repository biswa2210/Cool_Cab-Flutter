import 'package:cool_cab/database/company.dart';
import 'package:cool_cab/screens/CompanyDetail.dart';
import 'package:cool_cab/screens/car_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:cool_cab/database/db.dart';
import 'package:cool_cab/database/Car.dart';

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


class SearchCompanyPg extends StatefulWidget {
  static const String id = "searchcompg";
  @override
  _SearchCompanyPgState createState() => _SearchCompanyPgState();
}

class _SearchCompanyPgState extends State<SearchCompanyPg> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('cf0000'),
        title: Text("Search Company",style: TextStyle(fontFamily: 'Ratro',fontSize: 50),),
        actions: <Widget>[
          IconButton(icon: Icon(OMIcons.search,size: 40,), onPressed: (){
            showSearch(context: context, delegate: DataSearch());
          }
          )
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String>{
  List<Company> cars= CompaniesDB.toList();
  List<Company> rcars=CompaniesDB.toList();
  List<Company> suggestionList;


  @override
  List<Widget> buildActions(BuildContext context) {
    return[
      IconButton(icon: Icon(Icons.clear), onPressed:(){
        query="";
      })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon:
    AnimatedIcon(icon:
    AnimatedIcons.menu_arrow,
      progress: transitionAnimation,
    ), onPressed: (){
      close(context, null);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context,index)=>ListTile(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>CompanyDetail(
              companyName: suggestionList[index].name,
              founder: suggestionList[index].founder,
                Ownership: suggestionList[index].Ownership,
                Ceo: suggestionList[index].ceo,
              BrandAmbas: suggestionList[index].brandAmbassador,
              logoUrl: suggestionList[index].Companylogo
           )));
          },
          leading: Image.asset(suggestionList[index].Companylogo,height: 35,width: 40,),
          title: GestureDetector(
            child: RichText(
              text: TextSpan(
                  text: suggestionList[index].name.substring(0,query.length),
                  style:TextStyle(
                    color: Colors.black,fontWeight: FontWeight.bold,),
                  children: [
                    TextSpan(
                        text: suggestionList[index].name.substring(query.length),
                        style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)
                    )
                  ]
              ),
            ),
          )
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context){
    suggestionList=query.isEmpty ? rcars : cars.where((p)=>p.name.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context,index)=>ListTile(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>CompanyDetail(
                companyName: suggestionList[index].name,
                founder: suggestionList[index].founder,
                Ownership: suggestionList[index].Ownership,
                Ceo: suggestionList[index].ceo,
                BrandAmbas: suggestionList[index].brandAmbassador,
                logoUrl: suggestionList[index].Companylogo
            )));
          },
          leading: Image.asset(suggestionList[index].Companylogo,height: 35,width: 40,),
          title: GestureDetector(
            child: RichText(
              text: TextSpan(
                  text: suggestionList[index].name.substring(0,query.length),
                  style:TextStyle(
                    color: Colors.black,fontWeight: FontWeight.bold,),
                  children: [
                    TextSpan(
                        text: suggestionList[index].name.substring(query.length),
                        style: TextStyle(color:Colors.grey)
                    )
                  ]
              ),
            ),
          )
      ),

    );
  }
}