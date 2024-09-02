import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    _weatherFactory.currentWeatherByCityName('Sakrand').then((value) {
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
      body: buildUI(),
    );
  }

  Widget buildUI() {
    if (_weather == null) {
      return Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            locationHeader(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            dateTimeInfo(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            weatherIcon(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            currentTemp(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            extraInfo(),
          ],
        ),
      );
    }
  }

  Widget locationHeader() {
    return Text(
      _weather?.areaName ?? "",
      style: TextStyle(fontSize: 20),
    );
  }

  Widget dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: TextStyle(fontSize: 35),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            SizedBox(width: 10),
            Text(
              "${DateFormat("d.m.y").format(now)}",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }

  Widget weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.20,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png'))),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: TextStyle(fontSize: 20),
        )
      ],
    );
  }

  Widget currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: TextStyle(fontSize: 90, fontWeight: FontWeight.bold),
    );
  }

  Widget extraInfo() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.80,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              Text(
                "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                style: TextStyle(fontSize: 15, color: Colors.white),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              Text(
                "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                style: TextStyle(fontSize: 15, color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
