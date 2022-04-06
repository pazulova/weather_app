//flutter StatefulWidget livecycle   окуш керек
import 'package:flutter/material.dart';
import 'package:weather_app/city_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: CityUi(),
    );
  }
}



//  flutter http request reset api  интерреттер караш кк
//flutter geolocator android settings интерреттер караш кк
//https://api.openweathermap.org/data/2.5/weather?q
//=Bishkek&appid=85780a1640a4f54485a3733c3a91774b



// {
//   "coord": {
//     "lon": 74.59,
  //   "lat": 42.87
  // },
  // "weather": [
  //   {
  //     "id": 804,
  //     "main": "Clouds",
  //     "description": "overcast clouds",
  //     "icon": "04d"
  //   }
  // ],
//   "base": "stations",
//   "main": {
//     "temp": 276.26,
//     "feels_like": 272.89,
//     "temp_min": 276.26,
//     "temp_max": 276.26,
//     "pressure": 1017,
//     "humidity": 87,
//     "sea_level": 1017,
//     "grnd_level": 927
//   },
//   "visibility": 10000,
//   "wind": {
//     "speed": 3.69,
//     "deg": 272,
//     "gust": 5.51
//   },
//   "clouds": {
//     "all": 100
//   },
//   "dt": 1642400024,
//   "sys": {
//     "type": 1,
//     "id": 8871,
//     "country": "KG",
//     "sunrise": 1642386528,
//     "sunset": 1642420440
//   },
//   "timezone": 21600,
//   "id": 1528675,
//   "name": "Bishkek",
//   "cod": 200
// }