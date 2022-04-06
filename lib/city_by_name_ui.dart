import 'package:flutter/material.dart';
import 'package:weather_app/weather_provider.dart';

class CityByNameUi extends StatefulWidget {
  final String cityName;
  CityByNameUi({Key key, this.cityName}) : super(key: key);

  @override
  _CityByNameUiState createState() => _CityByNameUiState();
}

class _CityByNameUiState extends State<CityByNameUi> {
Map<String, dynamic>_cityWeatherData;
int _celcius = 0;

@override
void initState() {
  super.initState();
  getCityWeather();
}
Future <void> getCityWeather() async {
 _cityWeatherData = await WeatherProvider().getWeatherData(city:widget.cityName);
 _celcius = (_cityWeatherData['main'] ['temp'] - 273.15).round();
 setState(() {
   
 });
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
         children:[
           
            Text('cityBy name: ${widget.cityName}'),
            Text('cityBy nam: ${_celcius}'),
         ]
        )
              ),
     
          );
  }
}