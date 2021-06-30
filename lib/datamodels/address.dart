import 'package:flutter/cupertino.dart';

class AddressDatatype{
String placeName;
double latitude;
double longitude;
String placeId;
String placeFormattedAddress;
AddressDatatype({
  this.placeId,
  this.latitude,
  this.longitude,
  this.placeName,
  this.placeFormattedAddress,
});
}