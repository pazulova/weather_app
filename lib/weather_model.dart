
import 'package:weather_app/utilities/weather_util.dart';

class WeatherModel {
  final String cityName;
  final double kelvin;
  final int celcius;
  final String icon;
  final  String message;

  WeatherModel({
    this.celcius, 
    this.cityName,
   this.kelvin,
    this.icon, 
    this.message});

factory WeatherModel.fronJson(Map<String, dynamic> json){
  print('WeatherModel.fronJson json => $json');
  return WeatherModel (
    cityName: json ['name'],
    kelvin: json ['main']['temp'] ,
    celcius: WeatherUtil().kelvinToCelcius(json ['main']['temp']),
    icon: WeatherUtil().getWeatherIcon((json['main']['temp']).round()) ,
    message: WeatherUtil().getWeatherMessage(
      WeatherUtil().kelvinToCelcius(json ['main']['temp']),)
    );
}
}