import 'package:check_weather/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Loading extends StatefulWidget{
  @override
  _LoadingState createState()=> _LoadingState();
}

class _LoadingState extends State<Loading>{
  void getLocation() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    //return position;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            getLocation();
          },
          child: Text(Constant.str_loading),
          style: ElevatedButton.styleFrom(
            primary: Colors.orangeAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            )
          ),
        ),
      ),
    );
  }

}