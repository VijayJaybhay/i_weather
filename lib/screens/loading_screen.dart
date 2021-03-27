import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:i_weather/model/location.dart';
import 'package:i_weather/model/weather_data.dart';
import 'package:i_weather/screens/location_screen.dart';
import 'package:i_weather/services/location_service.dart';
import 'package:i_weather/services/weather_service.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocationService _locationService;
  WeatherService _weatherService;
  _LoadingScreenState() {
    _locationService = LocationService();
    _weatherService = WeatherService();
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  void getLocation() async {
    print('inside getlocation');
    Location location = await _locationService.getCurrentLocation();
    print('Got location');
    print(location);
    WeatherData newWeatherData = await _weatherService.getWeatherData(
        lat: location.latitude, lon: location.longitude);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(newWeatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          size: 100,
          color: Colors.orange,
        ),
      ),
    );
  }
}
