import 'package:http/http.dart' as http;


class Api{
  //Apı'den gelen Weather datasını döner.
  Future<http.Response> getWeatherData(String? location) {
    return http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?units=metric&lang=tr&q=$location&appid=bbe52cc5c96e0bc331ca6e56b4d64f2f'));
  }
}