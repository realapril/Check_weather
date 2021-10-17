import 'package:check_weather/data/my_location.dart';
import 'package:check_weather/data/network.dart';
import 'package:check_weather/screens/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:check_weather/auth/secrets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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

    late var weatherData;
    late var airData;
    Network network = Network(weatherUrl, airUrl);

    var result = await Future.wait<dynamic>([
      network.getJsonData(),
      network.getAirData(),
      _initGoogleMobileAds()
    ]);
    weatherData = result[0];
    airData = result[1];

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(parseWeatherData: weatherData, parseAirData: airData);
    }));

    //print(result);
    // print("결과"+weatherData.toString());

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(parseWeatherData: weatherData, parseAirData: airData,);
    }));
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    // COMPLETE: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
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