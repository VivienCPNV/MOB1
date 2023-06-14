import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloudy/constants/open_weather_api.dart';

class WeatherData {
  WeatherData._();

  static final WeatherData _instance = WeatherData._();

  factory WeatherData() {
    return _instance;
  }

  WeatherFactory weatherFactory = WeatherFactory(API_KEY);
  double previousLatitude = 0.00;
  double previousLongitude = 0.00;
  Weather? previousWeatherData = null;

  Future<Weather?> getWeatherByPosition(Position position) async {
    if (previousWeatherData != null) {
      if ((previousLatitude - position.latitude).abs() >= 0.05 &&
          (previousLongitude - position.longitude).abs() >= 0.05) {
        previousWeatherData = await weatherFactory.currentWeatherByLocation(
            position.latitude, position.longitude) as Weather?;
        previousLongitude = position.longitude;
        previousLatitude = position.latitude;
      }
    } else {
      previousWeatherData = await weatherFactory.currentWeatherByLocation(
          position.latitude, position.longitude) as Weather?;
      previousLongitude = position.longitude;
      previousLatitude = position.latitude;
    }
    return previousWeatherData;
  }

  Future<Weather> getWeatherCityName(String cityName) async {
    return await weatherFactory.currentWeatherByCityName(cityName);
  }
}
