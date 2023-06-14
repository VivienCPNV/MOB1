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
  int timeOfLastRequest = 0;
  Weather? previousWeatherData = null;

  Future<Weather?> getWeatherByPosition(Position position) async {
    if (previousWeatherData != null) {
      // Check if user is still relatively close to the cached request. If he's
      // far enough away, we update the cached request.
      if ((previousLatitude - position.latitude).abs() >= 0.05 &&
          (previousLongitude - position.longitude).abs() >= 0.05) {
        previousWeatherData = await weatherFactory.currentWeatherByLocation(
            position.latitude, position.longitude) as Weather?;
        previousLongitude = position.longitude;
        previousLatitude = position.latitude;
      }
      // Check if last update was 30 minutes ago (1'800'000 milliseconds)
      else if ((DateTime.now().millisecondsSinceEpoch - timeOfLastRequest)
              .abs() >=
          1800000) {
        previousWeatherData = await weatherFactory.currentWeatherByLocation(
            position.latitude, position.longitude) as Weather?;
        previousLongitude = position.longitude;
        previousLatitude = position.latitude;
      }
    }
    // No cached request so do request
    else {
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
