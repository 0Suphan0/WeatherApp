import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Api {
  //Apı'den gelen Weather datasını döner.
  Future<http.Response> getWeatherDataWithCity(String? city) {
    return http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?units=metric&lang=tr&q=$city&appid=bbe52cc5c96e0bc331ca6e56b4d64f2f'));
  }

  Future<http.Response> getWeatherDataWithLocation(Position? pos) {
    return http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?units=metric&lang=tr&appid=bbe52cc5c96e0bc331ca6e56b4d64f2f&lat=${pos!.latitude}&lon=${pos.longitude}'));
  }
}
