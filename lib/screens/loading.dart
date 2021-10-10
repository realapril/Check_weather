import 'package:check_weather/data/my_location.dart';
import 'package:check_weather/data/network.dart';
import 'package:check_weather/screens/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:check_weather/auth/secrets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

    String weatherUrl = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$weatherKey&units=metric';
    String airUrl = 'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=$weatherKey&units=metric';

    Network network = Network(weatherUrl, airUrl);
    var weatherData = await network.getJsonData();
    var airData = await network.getAirData();
    // print(weatherData);

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(parseWeatherData: weatherData, parseAirData: airData,);
    }));
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }

}