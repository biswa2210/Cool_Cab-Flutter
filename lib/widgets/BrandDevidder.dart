import 'package:flutter/material.dart';
/*
CREATED BY BISWARUP BHATTACHARJEE
EMAIL    : bbiswa471@gmail.com
PHONE NO : 6290272740
*/
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
class BrandDevider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Divider(height: 1.0,thickness: 1.0,color: HexColor('ca8a8b'),);
  }
}
