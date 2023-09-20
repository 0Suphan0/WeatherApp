import 'package:flutter/material.dart';
import 'package:weather_app/screen_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String backgroundAssetUrl = 'assets/c.jpg';
  double centigrate = 20.0;
  String location = "Ankara";
  final String apiKey = "bbe52cc5c96e0bc331ca6e56b4d64f2f";

  //Apı'den gelen Weather datasını döner.
  Future<http.Response> getWeatherData() {
    return http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?units=metric&lang=tr&q=$location&appid=$apiKey'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(backgroundAssetUrl), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () async {
             var response= await getWeatherData();
             print(response.statusCode);
            }, child: Text("TEST")),
            Text("$centigrate°C",
                style: const TextStyle(
                    fontSize: HomePageFontSize.centigradeSize,
                    fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(location,
                    style: const TextStyle(
                        fontSize: HomePageFontSize.locationSize)),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScreenPage()));
                    },
                    icon: const Icon(Icons.search))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HomePageFontSize {
  static const double centigradeSize = 70;
  static const double locationSize = 30;
}
