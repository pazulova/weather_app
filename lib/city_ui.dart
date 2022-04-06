import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/city_by_name_ui.dart';
import 'package:weather_app/city_screen.dart';
import 'package:weather_app/location_provider.dart';
import 'package:weather_app/progres_indicator.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/weather_model.dart';
import 'package:weather_app/weather_provider.dart';
class CityUi extends StatefulWidget {
  @override
  _CityUiState createState() => _CityUiState();
}

class _CityUiState extends State<CityUi> {

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final _formKey = GlobalKey<FormState>();
final TextEditingController _cityNameController =TextEditingController();

 Position _position;

 Map<String, dynamic> _data;
 int _celcius = 0;
 bool isLogin = false;
 String _cityName;
String weatherIcon;
String weatherMessage;
 WeatherModel weatherModel;
 
  @override
  void initState() {
    super.initState();
// _showMyDialog();
  //showSnackBar();
   // WeathrProvider().getWeatherData('osh');
  // getCurrentLocation();
    print('initState');
  
  }
@override
void didChangeDependencies() {
  super.didChangeDependencies();
   getCurrentLocation2();
   // showSnackBar();
   
  // WidgetsBinding.instance.addPostFrameCallback((_){
  // _showMyDialog();
  // // Add Your Code here.
  // });
   print('didChangeDependencies');

}

//  верстя 1  менен иштоо
Future <void> getCurrentLocation2() async {
   setState(() {
   isLogin = true;
 });
  _position = await LocationProvider().getCurrentPosition();
 weatherModel = await WeatherProvider().getWeatherModel(position: _position);

 await Future.delayed(Duration(seconds: 1), () {});

 setState(() {
   isLogin = false;
 });
  

//  верстя 2  менен иштоо

  Future <void> getCurrentLocation1() async {
   setState(() {
  isLogin = true;
});
   _position = await LocationProvider().getCurrentPosition();

  _data = await WeatherProvider().getWeatherData(position: _position);
  weatherModel = await WeatherProvider().getWeatherModel(position: _position);

double _kelvin = _data['main'] ['temp'];

_celcius = (_kelvin - 273).round();
_cityName = _data['name'];
//  print("_position.lat: ${_position.latitude}");
//  print("_position.long: ${_position.longitude}");

await Future.delayed(Duration(seconds: 1), () {});

 setState(() {
   isLogin = false;
 });
  }


 void showSnackBar() {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: const Text('snack'),
        duration: const Duration(seconds: 1),
        action: SnackBarAction(
          label: 'ACTION',
          onPressed: () { },
        ),
      ));
 }

 
Future<void> _showMyDialog() async {
  
  return showDialog<void>(
     
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Write your city'),
        content: SingleChildScrollView(
            child:  Form(
              key: _formKey,
              child: TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Required field';
                  } else{
                    return null;
                  }
                },
                onChanged: (String danniy) {
                // print('onChanged: $danniy');
                // // _cityName = danniy;
                // print('onChanged _cityName: $_cityName');
                },
                controller: _cityNameController,
                // onSaved: (String danniy) {
             
                //   print('validate');
                //    print('onSave: $danniy');
                //    _cityName = danniy;
                // }
              
              ),
            ),
           
          ),
        
        actions: <Widget>[
          TextButton(
            child: const Text('ok'),
            onPressed: () {
                   print('_cityNameController.text before validate:${_cityNameController.text}');
              if (_formKey.currentState.validate()){
                
                print('_cityNameController.text after validate:${_cityNameController.text}');
              Navigator.of(context).pop();
               Navigator.push(
             context, MaterialPageRoute(
               builder: (context) => CityByNameUi(
                 cityName: _cityNameController.text,
               ),
               ),
            
              
               );
              }
            }
          ),
        ],
      );
    },
  );
}
}

  @override
  void dispose() {
     print('dispose');
    // TODO: implement dispose
    super.dispose();
  }


  @override
  void deactivate() {
      print('deactivate');
    super.deactivate();
  }
  @override
  Widget build(BuildContext context) {
    print('build');

    return Scaffold(
      body: isLogin 
      ? circularProgress()
     : Scaffold(
        key: scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/location_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () async {
                              getCurrentLocation2();
                            },
                            child: const Icon(
                              Icons.near_me,
                              size: 50.0,
                            ),
                          ),
                          FlatButton(
                            onPressed: () async {
                             // _showMyDialog();
                             
                              String typedCity = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CityScreen();
                                  },
                                ),
                              );

                             if (typedCity != null) {
                               setState(() {
                                 isLogin = true;
                               });
                               weatherModel = await WeatherProvider()
                               .getWeatherModel(city: typedCity);
                                setState(() {
                                 isLogin = false;
                               });
                             }
                            },
                            child: Icon(
                              Icons.location_city,
                              size: 50.0,
                            ),
                          ),  
                        ],
                       ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                             '${weatherModel.celcius}',
                              style: kTempTextStyle,
                            ) ,               //model менен иштеген туру
                            // Text(
                            //  '$_celcius',
                            //   style: kTempTextStyle,
                            // ),             //  model    жасабай иштоо
                             Text(
                              weatherModel.icon ?? '☀️',
                              style: kConditionTextStyle,
                            )                  //  model  менен иштоо
                            // Text(
                            //   weatherIcon ?? '☀️',
                            //   style: kConditionTextStyle,
                            // ),              //  model    жасабай иштоо
                           
                          ],
                        ),
                      ),
                  
                      Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: 
                            
                        Text(
                          weatherModel.message == null
                         ? 'Weather in ${weatherModel.cityName}'
                          :'${weatherModel.message} in ${weatherModel.cityName}',
                          textAlign: TextAlign.right,
                          style: kMessageTextStyle,
                      ),                         //model менен иштеген туру
                      //   Text(
                      //     weatherMessage == null
                      //    ? 'Weather in $_cityName'
                      //     :'$weatherMessage in $_cityName',
                      //     textAlign: TextAlign.right,
                      //     style: kMessageTextStyle,
                      // ),                    //  model    жасабай иштоо
                      ),        
                    ],
                  )
                  ),
                ),
      ),    
      );                       
   
  }
}


 

