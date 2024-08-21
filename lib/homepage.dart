import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/key.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _weatherFactory = WeatherFactory(ApiKey.key);
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _weatherFactory.currentWeatherByCityName('Karachi').then((value) {
      setState(() {
        _weather = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                text: 'Weather',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                children: [
              TextSpan(
                text: 'App',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ])),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
