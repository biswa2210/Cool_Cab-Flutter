import 'package:cool_cab/database/company.dart';
/*
CREATED BY BISWARUP BHATTACHARJEE
EMAIL    : bbiswa471@gmail.com
PHONE NO : 6290272740
*/
import 'package:cool_cab/screens/AboutPg.dart';
import 'package:cool_cab/screens/CompanyDetail.dart';
import 'package:cool_cab/screens/ComparisonSc.dart';
import 'package:cool_cab/screens/car_details.dart';
import 'package:cool_cab/screens/contacctUs.dart';
import 'package:cool_cab/screens/favourities.dart';
import 'package:cool_cab/screens/loginpg.dart';
import 'package:cool_cab/screens/myhomepage.dart';
import 'package:cool_cab/screens/profile.dart';
import 'package:cool_cab/widgets/BrandDevidder.dart';
import 'package:cool_cab/widgets/DrawerItemStyle.dart';
import 'package:cool_cab/widgets/ProgressBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cool_cab/database/db.dart';
import 'package:cool_cab/database/Car.dart';
import 'package:cool_cab/database/company.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
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
class AllCar extends StatefulWidget {
  static const String id="allcars";
  @override
  _AllCarState createState() => _AllCarState();
}

class _AllCarState extends State<AllCar> {
  String emailstr;
  String userid;
  String phone;
  String fullname;
  String firstnm="User";
  String photourl="https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png";
  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;


  List<Widget> itemsData = [];

  void getPostsData() {
    List<Car> responseList = CarsDB;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CarDetails(post.id,post.company,post.logoUrl,post.name,post.Engine,post.Mileage,post.MaxTorque,post.MaxPower,post.BodyType,post.BootSpace,post.SeatingCapacity,post.MarketPrice,post.images)));
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
                          post.name,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                          softWrap: false,
                          maxLines: 3,
                        ),
                        Text(
                          "Mileage : "+post.Mileage,
                          style: const TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${post.MarketPrice}",
                          style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Image.asset(
                    post.logoUrl,
                    height: double.infinity,
                    width:60,
                  )
                ],
              ),
            )),
      ));
    });
    setState(() {
      itemsData = listItems;
    });
  }


  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(() {

      double value = controller.offset/119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

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

    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.35;
    return SafeArea(
      child: Scaffold(
        key:scaffoldkey,
        drawer: Drawer(
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
                leading: Icon(Icons.home),
                title: Text('Home',style: DrawerStyle,),
                onTap: (){
                  showDialog(context: context, builder: (BuildContext context)=>ProgressBar(
                      status:"Processing..."),);
                  Future.delayed(const Duration(milliseconds: 2000), () {
                    Navigator.pushNamedAndRemoveUntil(context,MyHomePage.id, (route) => false);});
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: (){
              scaffoldkey.currentState.openDrawer();
            },
            child: Icon(
              Icons.menu,
              color: Colors.black,
              size: 35,
            ),
          ),
          title: Text('All Cars',style: TextStyle(fontSize: 35,fontFamily: 'qh',color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 2.0),),

        ),
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: closeTopContainer?0:1,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: size.width,
                    alignment: Alignment.topCenter,
                    height: closeTopContainer?0:categoryHeight,
                    child: categoriesScroller),
              ),
              Expanded(
                  child: ListView.builder(
                      controller: controller,
                      itemCount: itemsData.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        double scale = 1.0;
                        if (topContainer > 0.5) {
                          scale = index + 0.5 - topContainer;
                          if (scale < 0) {
                            scale = 0;
                          } else if (scale > 1) {
                            scale = 1;
                          }
                        }
                        return Opacity(
                          opacity: scale,
                          child: Transform(
                            transform:  Matrix4.identity()..scale(scale,scale),
                            alignment: Alignment.bottomCenter,
                            child: Align(
                                heightFactor: 0.7,
                                alignment: Alignment.topCenter,
                                child: itemsData[index]),
                          ),
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();


  @override
  Widget build(BuildContext context) {
    List<Car> cArs=CarsDB;
    List<Company> companies= CompaniesDB;
    final double categoryHeight = MediaQuery.of(context).size.height * 0.35 - 50;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
        child:Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[

            for (int i=0;i<companies.length;i++) ...[
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>CompanyDetail(
                    companyName: companies[i].name,
                    founder: companies[i].founder,
                    logoUrl: companies[i].Companylogo,
                    Ownership: companies[i].Ownership,
                    BrandAmbas: companies[i].brandAmbassador,
                    Ceo: companies[i].ceo,
                  )));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  margin: EdgeInsets.only(right: 20),
                  height: categoryHeight,
                  decoration: BoxDecoration(gradient: LinearGradient(
                    begin:Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                    HexColor('#feada6'),
                     HexColor('#f5efef')
                    ]
                  ), borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Stack(
                    children: <Widget>[
                      Container(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              companies[i].name,
                              style: TextStyle(fontSize:32, color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'Apasto'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children:<Widget>[

                                Text("Founder : ",style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'BoltR'),),

                                Flexible(
                                  child:Text(
                                  companies[i].founder,
                                  style: TextStyle(fontSize: 18, color: Colors.black,fontFamily: 'qh'),
                                    maxLines: 3,
                                    softWrap: false,
                                ), )
                              ]
                            ),

                            SizedBox(
                              height: 15,
                            ),
                            Row(
                                children:<Widget>[

                                  Text("CEO : ",style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'BoltR'),),

                                  Flexible(
                                    child:  Text(companies[i].ceo,
                                      style: TextStyle(fontSize: 18, color: Colors.black,fontFamily: 'qh'),
                                      maxLines: 3,
                                        softWrap: false,
                                    ), )
                                ]
                            ),
                            SizedBox(height: 15,),
                            Row(
                                children:<Widget>[

                                  Text("Brand Ambassador : ",style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'BoltR'),),

                                  Flexible(
                                    child:Text(
                                      companies[i].brandAmbassador,
                                      style: TextStyle(fontSize: 16, color: Colors.black,fontFamily: 'qh'),
                                      maxLines: 3,
                                      softWrap: false,
                                    ), )
                                ]
                            ),


                          ],
                        ),
                      ),
                    ),
                      Positioned(
                          top:5,
                          left: 250,
                          child:Image.asset(companies[i].Companylogo,height: 50,width: 50,)
                      )
                    ]),
                ),
              ),

            ],

            ],
          ),
        ),
      ),
    );
  }}

