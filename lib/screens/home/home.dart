import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:cloudy/providers/geolocator.dart';
import 'package:cloudy/providers/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Weather? weatherData;
  bool loading = true;

  @override
  void initState() {
    weatherData = getWeatherData();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  setState() {
                    loading = true;
                  }

                  final result =
                      await Navigator.pushNamed(context, '/search') as String;
                  getWeatherData(result);
                },
                child: const Icon(
                  Icons.search,
                  size: 25.0,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    setState() {
                      loading = true;
                    }

                    getWeatherData();
                  },
                  child: const Icon(
                    Icons.my_location,
                    size: 25.0,
                    color: Colors.white,
                  )),
            ]),
        if (!loading)
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text((() {
                String townName = "Town";
                if (weatherData != null) {
                  townName = weatherData?.areaName ?? 'Town';
                }
                return townName;
              })(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  )),
              Text(DateFormat('EEEE').format(DateTime.now()),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  )),
              Image(
                image: (() {
                  return AssetImage(
                      'assets/images/${weatherData?.weatherIcon ?? "01d"}.png');
                })(),
                width: 200,
                height: 200,
              ),
              Text((() {
                return "${weatherData?.temperature?.celsius?.toStringAsFixed(1) ?? 20} C";
              })(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 25, color: Colors.white)),
              Text((() {
                return weatherData?.weatherMain ?? "Clear";
              })(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  )),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Image(
                      image: AssetImage('assets/images/thermometer_low.png'),
                      width: 50,
                      height: 50,
                    ),
                    Text((() {
                      return "${weatherData?.tempMin?.celsius?.toStringAsFixed(1) ?? 10} C";
                    })(),
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        )),
                    const Image(
                      image: AssetImage('assets/images/thermometer_high.png'),
                      width: 50,
                      height: 50,
                    ),
                    Text((() {
                      return "${weatherData?.tempMax?.celsius?.toStringAsFixed(1) ?? 30} C";
                    })(),
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        )),
                  ]),
            ],
          )),
        if (loading)
          Container(
              color: Colors.grey.shade900,
              child: const Center(
                  child: SpinKitChasingDots(
                color: Colors.white,
              )))
      ],
    );
  }

  getWeatherData([String city = ""]) {
    try {
      if (city != "") {
        WeatherData().getWeatherCityName(city).then((weather) {
          setState(() {
            weatherData = weather;
            loading = false;
          });
        });
      } else {
        // TODO: Add caching
        CloudyGeoLocator.getCurrentLocation().then((position) {
          if (position != null) {
            WeatherData().getWeatherByPosition(position).then((weather) {
              setState(() {
                weatherData = weather;
                loading = false;
              });
            });
          }
        });
      }
    } on OpenWeatherAPIException catch (ex) {
      print("Failed to retrieve weather data");
    }
  }
}
