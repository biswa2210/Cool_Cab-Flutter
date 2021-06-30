import 'package:cool_cab/datamodels/address.dart';
import 'package:flutter/material.dart';
class AppData extends ChangeNotifier{
  AddressDatatype pickAddress;
  void updatePickupAddress(AddressDatatype pickup){
    pickAddress = pickup;
    notifyListeners();
  }
}