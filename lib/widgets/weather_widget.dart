import 'package:flutter/material.dart';
import 'package:cloudy/providers/geolocator.dart';
import 'package:cloudy/providers/weather.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';

class WeatherWidget extends StatefulWidget {
  final String? city;
  const WeatherWidget({Key? key, this.city}) : super(key: key);
  @override
  WeatherWidgetState createState() => WeatherWidgetState();
}

class WeatherWidgetState extends State<WeatherWidget> {
  Weather? weatherData;
  @override
  void initState() {
    weatherData = getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          getWeatherData();
        },
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
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
        ));
  }

  getWeatherData() {
    try {
      if (widget.city != null) {
        WeatherData.getWeatherCityName(widget?.city ?? "Los Angeles")
            .then((weather) {
          setState(() {
            weatherData = weather;
          });
        });
      } else {
        // TODO: Add caching
        CloudyGeoLocator.getCurrentLocation().then((position) {
          if (position != null) {
            WeatherData.getWeatherByPosition(position).then((weather) {
              setState(() {
                weatherData = weather;
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
