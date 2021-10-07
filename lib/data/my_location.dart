import 'package:geolocator/geolocator.dart';

class MyLocation{
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> getMyCurrentLocation() async{
    try{
      //Dart가 Future만나면 큐에 넣고 바로 다음으로 넘어가버림.
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
    }catch(e){
      print("Internet error has occured");
    }
    //return position;
  }
}