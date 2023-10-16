import 'package:flutter/material.dart';
import 'package:weather_api/models/weather_model.dart';
import 'package:weather_api/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherservice =
      WeatherService(apiKey: 'a0a66e3adb95732549944cbe2cfd0972');

  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherservice.getCurrentCity();
    try {
      final weather = await _weatherservice.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading City"),
            Text('${_weather?.temperature.round().toString()} °C'),
          ],
        ),
      ),
    );
  }
}
