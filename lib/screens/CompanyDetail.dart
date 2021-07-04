import 'package:cool_cab/database/db.dart';
/*
CREATED BY BISWARUP BHATTACHARJEE
EMAIL    : bbiswa471@gmail.com
PHONE NO : 6290272740
*/
import 'package:cool_cab/screens/CompanyCarsList.dart';
import 'package:cool_cab/widgets/BrandDevidder.dart';
import 'package:flutter/cupertino.dart';
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
class CompanyDetail extends StatefulWidget {
  static const String id="compayDetail";
  String companyName;
  String Ownership;
  String founder;
  String Ceo;
  String BrandAmbas;
  String logoUrl;
  CompanyDetail({
   @required this.companyName,
    @required this.founder,
   @required this.Ownership,
   @required this.BrandAmbas,
   @required this.Ceo,
   @required this.logoUrl
});
  @override
  _CompanyDetailState createState() => _CompanyDetailState();
}

class _CompanyDetailState extends State<CompanyDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Stack(
          children:[
          /*1st path*/
            ClipPath(
              clipper: FLinePathClass(),
              child: Container(
                decoration: BoxDecoration(gradient: LinearGradient(
                    begin:Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                      HexColor('#feada6'),
                      HexColor('#f5efef')
                    ]
                )
              ),
            )
            ),
            /*2nd path*/
            ClipPath(
                clipper: SLinePathClass(),
                child: Container(
                  decoration: BoxDecoration(gradient: LinearGradient(
                      begin:Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [
                        HexColor('#feada6'),
                        HexColor('#f5efef')
                      ]
                  )
                  ),
                )
            ),
            /*3rd path*/
            ClipPath(
                clipper: TLinePathClass(),
                child: Container(
                  decoration: BoxDecoration(gradient: LinearGradient(
                      begin:Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [
                        HexColor('#feada6'),
                        HexColor('#f5efef')
                      ]
                  )
                  ),
                )
            ),
            /*4th path*/
            ClipPath(
                clipper: FoLinePathClass(),
                child: Container(
                  decoration: BoxDecoration(gradient: LinearGradient(
                      begin:Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [
                        HexColor('#feada6'),
                        HexColor('#f5efef')
                      ]
                  )
                  ),
                )
            ),
            /*5th path*/
            ClipPath(
                clipper: FiLinePathClass(),
                child: Container(
                  decoration: BoxDecoration(gradient: LinearGradient(
                      begin:Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [
                        HexColor('#feada6'),
                        HexColor('#f5efef')
                      ]
                  )
                  ),
                )
            ),
            /*6th  path*/
            ClipPath(
                clipper: SiLinePathClass(),
                child: Container(
                  decoration: BoxDecoration(gradient: LinearGradient(
                      begin:Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [
                        HexColor('#feada6'),
                        HexColor('#f5efef')
                      ]
                  )
                  ),
                )
            ),
            Positioned(
              top: 30,
              left: 20,
              child:Container(
              child: Image.asset(widget.logoUrl,height:100,width: 100,),
            ),),

            Positioned(
                top: 50,
                bottom: 50,
                left: 50,
                right: 50,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 35,
                                    width: MediaQuery.of(context).size.width-150,
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(widget.companyName,style: TextStyle(
                                              fontFamily: 'MON',
                                              fontSize: 30
                                            ),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                      SizedBox(height: 7,),
                      BrandDevider(),
                      SizedBox(height: 8,),
                      Container(
                        height: 70,
                        child: SingleChildScrollView(
                          child: Text(
                            "Founder: "+widget.founder,
                            style: TextStyle(
                                fontFamily: 'qh',
                                fontSize: 30
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 7,),
                      BrandDevider(),
                      SizedBox(height: 8,),
                      Container(
                        height: 70,
                        child: SingleChildScrollView(
                          child: Text(
                            "Ownership: "+widget.Ownership,
                            style: TextStyle(
                                fontFamily: 'qh',
                                fontSize: 30
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 7,),
                      BrandDevider(),
                      SizedBox(height: 8,),
                      Container(
                        height: 70,
                        child: SingleChildScrollView(
                          child: Text(
                            "BrandAmbassador: "+widget.BrandAmbas,
                            style: TextStyle(
                                fontFamily: 'qh',
                                fontSize: 30
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 7,),
                      BrandDevider(),
                      SizedBox(height: 8,),
                      Container(
                        height: 70,
                        child: SingleChildScrollView(
                          child: Text(
                            "CEO: "+widget.Ceo,
                            style: TextStyle(
                                fontFamily: 'qh',
                                fontSize: 30
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 7,),
                      BrandDevider(),
                      SizedBox(height: 8,),
    ],
    ),
    ),
    )],
                  ),
                ),
            Positioned(
              bottom: 50,
                right: 60,
              left: 60,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                ),
                child: RaisedButton(
                  padding: EdgeInsets.all(10),
                  onPressed:(){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>CompanyCarsList(companyNm: widget.companyName,)));
                  },
                  child: Text("View Cars",style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'BlotS',
                    color: Colors.black
                  ),),
                  color: HexColor('#feada6'),
                ),
              ),
            )
          ]
        )
    );
  }
}
/*1st Path Define*/
class FLinePathClass extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path=new Path();
    path.lineTo(0, 250);
    path.lineTo(250, 0);
    path.lineTo(size.height-500, size.width-500);
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
/*2nd Path Define*/
class SLinePathClass extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path=new Path();
    path.lineTo(250, 0);
    path.lineTo(0,450);
    path.lineTo(size.height-500, size.width-500);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
   return false;
  }

}
/*3rd Path Define*/
class TLinePathClass extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path=new Path();
    path.lineTo(250, 0);
    path.lineTo(150, 450);
    path.lineTo(size.height-500, size.width-500);
    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
  return false;
  }

}
/*4th Path Define*/
class FoLinePathClass extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path=new Path();
    path.lineTo(250, 0);
    path.lineTo(250, 450);
    path.lineTo(size.height-500, size.width-500);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}
/*5th Path Define*/
class FiLinePathClass extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path=new Path();
    path.lineTo(250,0);
    path.lineTo(350, 450);
    path.lineTo(size.height-500, size.width-500);
    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}
/*6th Path Define*/
class SiLinePathClass extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path=new Path();
    path.lineTo(250, 0);
    path.lineTo(400, 350);
    path.lineTo(size.height-500, size.width-500);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}

