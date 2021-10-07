import 'package:check_weather/constant/constant.dart';
import 'package:check_weather/data/my_location.dart';
import 'package:check_weather/data/network.dart';
import 'package:check_weather/screens/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:check_weather/auth/secrets.dart';

class Loading extends StatefulWidget{
  @override
  _LoadingState createState()=> _LoadingState();
}

class _LoadingState extends State<Loading>{
  @override
  void initState() {
    super.initState();
    getLocation();
  }
  double latitude = 0.0;
  double longitude = 0.0;
  void getLocation() async{
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude = myLocation.latitude;
    longitude = myLocation.longitude;

    // print(latitude);
    // print(longitude);

    Network network = Network('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$weatherKey&units=metric');
    var weatherData = await network.getJsonData();
    print(weatherData);

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(parseWeatherData: weatherData,);
    }));
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