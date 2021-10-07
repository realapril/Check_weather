import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget{
  final dynamic parseWeatherData;
  WeatherScreen({this.parseWeatherData});//생성자

  @override
  State<StatefulWidget> createState() =>_WeatherScreen();

}

class _WeatherScreen extends State<WeatherScreen>{
  String cityName = "";
  double temp = 0.0;
  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData);
  }

  void updateData(dynamic weatherData){
    temp = weatherData['main']['temp'];
    cityName = weatherData['name'];
    // print(temp);
    // print(cityName);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$cityName',
                style: TextStyle(
                  fontSize: 30.0
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '$temp',
                style: TextStyle(
                  fontSize: 30.0
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}