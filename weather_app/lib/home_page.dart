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

  //Daily weather
  String backgroundAssetUrl = 'assets/c.jpg';
  double? centigrate;
  String? city = "";
  String weatherBackground = '';
  Position? currentPosition;
  String? icon;

  // 5 Days weather datas
  List<String> icons = [];
  List<double> temperatures = [];
  List<String> dates =[];

  // get my daily weather datas with gps pos data.
  void getMyResponseWithPos() async {
    //position verisini al gps servisi ile.
    currentPosition = await gps.determinePosition();

    //eger konum null degilse
    if (currentPosition != null) {
      var response = await myApi.getWeatherDataWithLocation(currentPosition);
      var myResponse = jsonDecode(response.body);
      setState(() {
        city = myResponse['name'];
        centigrate = myResponse['main']['temp'];
        weatherBackground = myResponse['weather'][0]['main'];
        backgroundAssetUrl = 'assets/$weatherBackground.jpg';
        icon = myResponse['weather'][0]['icon'];
      });
    }
  }

  // get my 5 days weather datas with gps
  void getMyResponseDailyWithPos() async {
    //position verisini al gps servisi ile.
    currentPosition = await gps.determinePosition();

    //eger konum null degilse
    if (currentPosition != null) {
      var response = await myApi.getWeatherDataDailyWithLocation(currentPosition);
      var myResponse = jsonDecode(response.body);
      setState(() {

        //clear the list
       icons.clear();
       temperatures.clear();
       dates.clear();

       // fill the list
       for(int i=7; i<40; i=i+8){
         temperatures.add(myResponse['list'][i]['main']['temp']);
         icons.add(myResponse['list'][i]['weather'][0]['icon']);
         dates.add(myResponse['list'][i]['dt_txt']);

       }

      });
    }
  }

  // get my 5 days weather datas with city.
  void getMyResponseDailyWithCity(String? city) async {

    if (city != null) {
      var response = await myApi.getWeatherDataDailyWithCity(city);
      var myResponse = jsonDecode(response.body);
      setState(() {
        icons.clear();
        temperatures.clear();
        dates.clear();

        for(int i=7; i<40; i=i+8){
          temperatures.add(myResponse['list'][i]['main']['temp']);
          icons.add(myResponse['list'][i]['weather'][0]['icon']);
          dates.add(myResponse['list'][i]['dt_txt']);

        }

      });
    }
  }

  // get my daily weather datas with city
  void getMyResponseWithCity(String? city) async {
    if (city != null) {
      var response = await myApi.getWeatherDataWithCity(city);
      var myResponse = jsonDecode(response.body);
      setState(() {
        city = myResponse['name'];
        centigrate = myResponse['main']['temp'];
        weatherBackground = myResponse['weather'][0]['main'];
        backgroundAssetUrl = 'assets/$weatherBackground.jpg';
        icon = myResponse['weather'][0]['icon'];
      });
    }
  }

  @override
  void initState() {
    getMyResponseWithPos();
    getMyResponseDailyWithPos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(backgroundAssetUrl), fit: BoxFit.cover)),
      child: (centigrate == null || currentPosition==null || icons.isEmpty || dates.isEmpty ||temperatures.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    child: Image.network(
                        'https://openweathermap.org/img/wn/$icon@4x.png'),
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
                            getMyResponseDailyWithCity(city);

                          },
                          icon: const Icon(Icons.search))
                    ],
                  ),
                  buildDailyWeatherCards(context)
                ],
              ),
            ),
    );
  }

  Widget buildDailyWeatherCards(BuildContext context) {
    List<DailyWeather> dailyWeathers = [];

    for (int i = 0; i < 5; i++) {
      dailyWeathers.add(DailyWeather(
          icon: icons[i], centigrate: temperatures[i], date: dates[i]));
    }

    return SizedBox(
      height: 170,
      width: MediaQuery.of(context).size.width * 0.9,
      child:
          ListView(scrollDirection: Axis.horizontal, children: dailyWeathers),
    );
  }
}

class HomePageFontSize {
  static const double centigradeSize = 70;
  static const double locationSize = 30;
}
