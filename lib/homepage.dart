import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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
  String selectedCity = 'Karachi';

  @override
  void initState() {
    super.initState();
    _weatherFactory.currentWeatherByCityName(selectedCity).then((value) {
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
        // child: Lottie.asset(
        //   "assets/animations/loadingAnimation.json",
        //   width: 200,
        //   height: 200,
        //   fit: BoxFit.fill,
        // ),
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.blue, Colors.black])),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            locationHeader(),
            weatherIcon(),
            currentTemp(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            dateTimeInfo(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            extraInfo(),
          ],
        ),
      );
    }
  }

  Widget locationHeader() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_on),
          DropdownButton(
              alignment: Alignment.center,
              value: selectedCity,
              hint: Text(
                _weather?.areaName ?? "",
                style: TextStyle(fontSize: 20),
              ),
              underline: SizedBox.shrink(),
              items: <String>[
                'Karachi',
                'Lahore',
                'Islamabad',
                'Rawalpindi',
                'Faisalabad',
                'Multan',
                'Peshawar',
                'Quetta',
                'Sialkot',
                'Gujranwala',
                'Hyderabad',
                'Sargodha',
                'Bahawalpur',
                'Sukkur',
                'Larkana',
                'Rahim Yar Khan',
                'Jhelum',
                'Mardan',
                'Kasur',
                'Sahiwal',
                'Nawabshah',
                'Sakrand',
                'Mirpur Khas',
                'Chiniot',
                'Okara',
                'Sheikhupura',
                'Abbottabad',
                'Dera Ghazi Khan',
                'Vehari',
                'Mingora',
                'Muzaffarabad',
              ].map<DropdownMenuItem<String>>((String city) {
                return DropdownMenuItem<String>(value: city, child: Text(city));
              }).toList(),
              onChanged: (String? newCity) {
                setState(() {
                  selectedCity = newCity!;
                  _weatherFactory
                      .currentWeatherByCityName(selectedCity)
                      .then((value) {
                    setState(() {
                      _weather = value;
                    });
                  });
                });
              }),
        ],
      ),
    );
  }

  Widget dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("EEEE").format(now),
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("h:mm a").format(now),
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            SizedBox(width: 10),
            Text(
              "${DateFormat("d/m/y").format(now)}",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }

  Widget weatherIcon() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png'))),
    );
  }

  Widget currentTemp() {
    return Column(
      children: [
        Text(
          "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
          style: TextStyle(
              fontSize: 80, fontWeight: FontWeight.w300, color: Colors.white),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: TextStyle(fontSize: 20),
        )
      ],
    );
  }

  Widget extraInfo() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/max.png',
                    height: 30,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/min.png',
                    height: 30,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              )
            ],
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/wind.png',
                    height: 30,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/humidity.png',
                    height: 30,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              )
            ],
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.sunny,
                    color: Colors.yellow,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Sunrise: ${DateFormat("h:mm a").format(DateTime.parse("${_weather?.sunrise!}"))}",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.sunny_snowing,
                    color: Colors.orange,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Sunset: ${DateFormat("h:mm a").format(DateTime.parse("${_weather?.sunset!}"))}",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
