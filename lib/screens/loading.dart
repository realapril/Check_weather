import 'package:check_weather/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'dart:convert'; //이건기본으로있음

class Loading extends StatefulWidget{
  @override
  _LoadingState createState()=> _LoadingState();
}

class _LoadingState extends State<Loading>{
  void getLocation() async{
    try{
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    }catch(e){
      print("Internet error has occured");
    }
    //return position;
  }

  void fetchData() async{
    Response response = await get(Uri.parse('https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1'));
    if(response.statusCode ==200){
      String jsonData = response.body.toString();
      var myJson = jsonDecode(jsonData);
      var description = myJson['weather'][0]['description'];
      var windSpeed = myJson['wind']['speed'];
      var id = myJson['id'];
      print(description);
      print(windSpeed);
      print(id);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            getLocation();
            fetchData();
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