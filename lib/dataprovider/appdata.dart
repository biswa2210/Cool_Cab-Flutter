import 'package:cool_cab/datamodels/address.dart';
import 'package:flutter/material.dart';
class AppData extends ChangeNotifier{
  /*
CREATED BY BISWARUP BHATTACHARJEE
EMAIL    : bbiswa471@gmail.com
PHONE NO : 6290272740
*/
  AddressDatatype pickAddress;
  void updatePickupAddress(AddressDatatype pickup){
    pickAddress = pickup;
    notifyListeners();
  }
}
