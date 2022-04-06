
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/utilities/constants.dart';
 import 'dart:convert' as convert;

import 'package:weather_app/weather_model.dart';
 //client.read(Uri.parse(urlPath));
 class  WeatherProvider{
    Future<WeatherModel> getWeatherModel(
     {String city = '', Position position}) async{
 String baseUrl = 'https:api.openweathermap.org/data/2.5/weather?';
 String endpointByLocation;
   String endpointByName = 'q=$city&appid=$apiKey';
   if(city == '') {

   endpointByLocation = 
   'lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey';
   }
   String url =
  city == '' ? baseUrl + endpointByLocation : baseUrl + endpointByName;
  

    Uri uri = Uri.parse(url);
 
 
 http.Response response = await http.get(uri);
  if (response.statusCode == 200 || response.statusCode == 201) {
  final body = response.body;
  // print(' json body: $body');
  
  final data = convert.jsonDecode(body) as Map<String, dynamic>;

   //print('Map data: $data');
  // print(' map data temperature: ${data['main'] ['temp'] }');

  final  WeatherModel weatherModel = WeatherModel.fronJson(data);
  print('weatherModel ======>: ${weatherModel.cityName}');
   print('weatherModel ======>: ${weatherModel.celcius}');
    print('weatherModel ======>: ${weatherModel.kelvin}');
     print('weatherModel ======>: ${weatherModel.icon}');
      print('weatherModel ======>: ${weatherModel.message}');

  return weatherModel;
  } else {
   return null;
  }}

   Future<Map<String, dynamic>> getWeatherData(
     {String city = '', Position position}) async{
    
   //https:api.openweathermap.org/data/2.5/weather?q=Bishkek&appid=85780a1640a4f54485a3733c3a91774b
  // print('getWeatherData.city: $city');
  
  print('getweqatherDate.city: $city');
       
 String baseUrl = 'https:api.openweathermap.org/data/2.5/weather?';
 String endpointByLocation;
   String endpointByName = 'q=$city&appid=$apiKey';
    if(city == '') {

   endpointByLocation = 
   'lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey';
   }
   String url =
  city == '' ? baseUrl + endpointByLocation : baseUrl + endpointByName;
  

    Uri uri = Uri.parse(url);
     
 http.Response response = await http.get(uri);
  if (response.statusCode == 200 || response.statusCode == 201) {
  final body = response.body;
  // print(' json body: $body');
  
  final data = convert.jsonDecode(body) as Map<String, dynamic>;

  //  print('Map data: $data');
  //  print(' map data temperature: ${data['main'] ['temp'] }');
  return data;
  } else {
   return null;
  }}
 }