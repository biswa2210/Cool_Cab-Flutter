import 'package:flutter/cupertino.dart';

class Car{
  final int id;
  final String company;
  final String logoUrl;
  final String name;
  final String Engine;
  final String Mileage;
  final String MaxTorque;
  final String MaxPower;
  final String BodyType;
  final String BootSpace;
  final String SeatingCapacity;
  final String MarketPrice;
  final List<String> images;
  const Car({@required this.id,@required this.company,@required this.logoUrl,@required this.name,@required this.Engine,@required this.Mileage
  ,@required this.MaxTorque,@required this.MaxPower,@required this.BodyType,@required this.BootSpace,@required this.SeatingCapacity,
  @required this.MarketPrice,@required this.images});
}