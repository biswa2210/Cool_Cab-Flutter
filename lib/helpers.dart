
import 'package:cool_cab/datamodels/address.dart';
import 'package:cool_cab/dataprovider/appdata.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';


  Future<String> FindLocation(Coordinates position,context) async{

    var address=await Geocoder.local.findAddressesFromCoordinates(position);
    if(address!=null) {
      AddressDatatype pickupAddress = new AddressDatatype();
      pickupAddress.longitude = position.longitude;
      pickupAddress.latitude = position.latitude;
      if(address.first.addressLine!=null){
        pickupAddress.placeName =await address.first.addressLine;
      }
      else{
        pickupAddress.placeName ='Not Known';
      }
      Provider.of<AppData>(context, listen: false).updatePickupAddress(
          pickupAddress);
      return address.first.adminArea;
    }
    else{
      return 'Not Found';
    }

  }
