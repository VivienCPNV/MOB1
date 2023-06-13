import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloudy/constants/open_weather_api.dart';

class WeatherData {
  static WeatherFactory weatherFactory = WeatherFactory(API_KEY);
  static double previousLatitude = 0.00;
  static double previousLongitude = 0.00;
  static Weather? previousWeatherData = null;

  static Future<Weather?> getWeatherByPosition(Position position) async {
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

  static Future<Weather> getWeatherCityName(String cityName) async {
    return await weatherFactory.currentWeatherByCityName(cityName);
  }
}
