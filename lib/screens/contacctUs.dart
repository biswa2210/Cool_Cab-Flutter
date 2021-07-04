import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
/*
CREATED BY BISWARUP BHATTACHARJEE
EMAIL    : bbiswa471@gmail.com
PHONE NO : 6290272740
*/
import 'package:flutter_email_sender/flutter_email_sender.dart';
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
class ContactUs extends StatefulWidget {
  static const String id="contactus";
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  var name=TextEditingController();
  var phone=TextEditingController();
  var emailBody=TextEditingController();
  var emailSubject=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DelayedDisplay(
            slidingBeginOffset:	const Offset(-2,-5),
            slidingCurve: Curves.fastLinearToSlowEaseIn,
            delay: Duration(milliseconds: 800),
            child: ClipPath(
              clipper: Path1(),
              child: Container(
                decoration: BoxDecoration(gradient: LinearGradient(
                    begin:Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                      HexColor('#feada6'),
                      Colors.red,
                      Colors.black
                    ]
                )
                ),
              ),
            ),
          ),
          DelayedDisplay(
          slidingBeginOffset:	const Offset(1,0),
    slidingCurve: Curves.fastLinearToSlowEaseIn,
            delay: Duration(milliseconds: 1600),
            child: ClipPath(
              clipper: Path2(),
              child: Container(
                decoration: BoxDecoration(gradient: LinearGradient(
                    begin:Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.red,
                      HexColor('#feada6'),
                      Colors.black,

                    ]
                )
                ),
              ),
            ),
          ),
          DelayedDisplay(
            slidingCurve: Curves.fastLinearToSlowEaseIn,
            delay: Duration(milliseconds: 2400),
            child: ClipPath(
              clipper: Path3(),
              child: Container(
                decoration: BoxDecoration(gradient: LinearGradient(
                    begin:Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.red,
                      HexColor('#feada6'),
                      Colors.black,

                    ]
                )
                ),
              ),

            ),
          ),
          Positioned(
              top: 90,
              bottom: 90,
              left: 50,
              right: 50,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: DelayedDisplay(
                  slidingBeginOffset:	const Offset(0,-1),
                  delay:Duration(seconds: 3),
                  child: Container(
                    width: 180,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                        boxShadow:   [
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 4,
                            blurRadius: 15,
                          ),
                          BoxShadow(
                            color:Colors.red,
                            spreadRadius: -4,
                            blurRadius: 25,
                          )
                        ]
                    ),
            child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20,),
                    new ListTile(
                              leading: const Icon(Icons.person),
                            title: new TextField(
                            controller: name,
                                    decoration: new InputDecoration(
                                hintText: "Name",
                                        border: OutlineInputBorder()
                              ),
                              ),
                              ),
                           new ListTile(
                              leading: const Icon(Icons.phone),
                               title: new TextField(
                                 controller: phone,
                                 keyboardType: TextInputType.number,
                                    decoration: new InputDecoration(
                                  hintText: "Phone",
                                        border: OutlineInputBorder()
                               ),
                             ),
                                 ),
                                    new ListTile(
                                 leading: const Icon(Icons.email),
                                         title: new TextField(
                                         enabled: false,
                                         decoration: new InputDecoration(
                                      hintText: "bbiswa471@gmail.com",
                                             border: OutlineInputBorder()
                                                ),
                                                     ),
                                                    ),
                        new ListTile(
                            leading: const Icon(Icons.mediation_sharp),
                            title: new TextFormField(
                              controller: emailSubject,
                              minLines: 1, // any number you need (It works as the rows for the textarea)
                              keyboardType: TextInputType.multiline,
                              decoration: new InputDecoration(
                                  hintText: "Email Subject",
                                  border: OutlineInputBorder()
                              ),
                              maxLines: null,
                            )
                        ),
                        new ListTile(
                          leading: const Icon(Icons.message),
                          title: new TextFormField(
                            controller: emailBody,
                            minLines: 5, // any number you need (It works as the rows for the textarea)
                            keyboardType: TextInputType.multiline,
                            decoration: new InputDecoration(
                              hintText: "Email Body",
                              border: OutlineInputBorder()
                            ),
                            maxLines: null,
                          )
                        ),

                        SizedBox(height: 30,),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow:   [
                            BoxShadow(
                            color:Colors.black,
                            spreadRadius: 4,
                            blurRadius: 15,
                            ),
                            BoxShadow(
                            color:Colors.red,
                            spreadRadius: -4,
                            blurRadius: 25,
                            ),
                              BoxShadow(
                                color:HexColor('#feada6'),
                                spreadRadius: -4,
                                blurRadius: 25,
                              )
                            ]
                          ),
                          child: RaisedButton(onPressed: () async{
                            final Email email = Email(
                              body: emailBody.text+'\n\nContact From\nName : '+name.text+'\nPhoneNo : '+phone.text,
                              subject: emailSubject.text,
                              recipients: ['bbiswa471@gmail.com'],
                              cc: ['bbiswathegreat@gmail.com'],
                              bcc: ['biswarupb723@gmail.com'],
                              isHTML: false,
                            );
                            await FlutterEmailSender.send(email);
                          },
                            color: HexColor('#feada6'),
                            padding: EdgeInsets.all(12),
                          child: Text("Send  Email",
                          style: TextStyle(
                            fontFamily: "mon",
                            fontSize: 20
                          ),),
                          ),
                        )
                      ],
                    ),
                  ),
            ),
          ),
                ),
              ))
        ],
      ),
    );
  }
}
class Path1 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path=new Path();
    path.lineTo(size.width,0);
    path.lineTo(0,size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }


}
class Path2 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.moveTo(size.width,0);
    path.lineTo(size.width/2,size.height/2);
    path.lineTo(size.width,size.height-100);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}
class Path3 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
  var path = new Path();
  path.moveTo(size.width/2, size.height/2);
  path.lineTo(size.width, size.height-100);
  path.lineTo(size.width, size.height);
  path.lineTo(0, size.height);
  return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}
