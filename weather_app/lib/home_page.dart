import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/screen_page.dart';
import 'package:weather_app/gps.dart';
import 'package:weather_app/widgets/daily_weather_card.dart';
import 'api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Gps gps = Gps();
  Api myApi = Api();
  String backgroundAssetUrl = 'assets/c.jpg';
  double? centigrate;
  String? city = "";
  String weatherBackground = '';
  Position? currentPosition;
  String? icon;

  void getMyResponseWithPos() async {
    //position verisini al gps servisi ile.
    currentPosition = await gps.determinePosition();

    //eger konum null degilse
    if (currentPosition!=null) {
      var response = await myApi.getWeatherDataWithLocation(currentPosition);
      var myResponse = jsonDecode(response.body);
      setState(() {
        city=myResponse['name'];
        centigrate = myResponse['main']['temp'];
        weatherBackground = myResponse['weather'][0]['main'];
        backgroundAssetUrl = 'assets/$weatherBackground.jpg';
        icon=myResponse['weather'][0]['icon'];
      });
    }
  }

  void getMyResponseWithCity(String? city) async {
    if (city != null) {
      var response = await myApi.getWeatherDataWithCity(city);
      var myResponse = jsonDecode(response.body);
      setState(() {
        city = myResponse['name'];
        centigrate = myResponse['main']['temp'];
        weatherBackground = myResponse['weather'][0]['main'];
        backgroundAssetUrl = 'assets/$weatherBackground.jpg';
        icon=myResponse['weather'][0]['icon'];
      });
    }
  }

  @override
  void initState() {
    getMyResponseWithPos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(backgroundAssetUrl), fit: BoxFit.cover)),

      child: centigrate == null
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              child: Image.network('https://openweathermap.org/img/wn/$icon@4x.png'),
            ),
            
            Center(
              child: Text("$centigrate°C",
                  style: const TextStyle(
                      fontSize: HomePageFontSize.centigradeSize,
                      fontWeight: FontWeight.bold)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(city ?? 'Şehir verisi alınamadı :(',
                    style: const TextStyle(
                        fontSize: HomePageFontSize.locationSize)),
                IconButton(
                    onPressed: () async {
                      city = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScreenPage()));
                      getMyResponseWithCity(city);
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
            const Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                DailyWeather(),
                DailyWeather(),
                DailyWeather(),
                DailyWeather(),
                DailyWeather(),
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
