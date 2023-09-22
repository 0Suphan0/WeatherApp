import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/screen_page.dart';

import 'api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Api myApi = Api();
  String backgroundAssetUrl = 'assets/c.jpg';
  double? centigrate;
  String? location = "Berlin";
  String weatherBackground = '';

  void getMyResponse() async {
    var response = await myApi.getWeatherData(location);
    var myResponse = jsonDecode(response.body);
    setState(() {
      centigrate = myResponse['main']['temp'];
      weatherBackground = myResponse['weather'][0]['main'];
      backgroundAssetUrl = 'assets/$weatherBackground.jpg';

      //gps'ten gelecek.
      // location=
    });
  }

  @override
  void initState() {
    getMyResponse();
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
                  Center(
                    child: Text("$centigrate°C",
                        style: const TextStyle(
                            fontSize: HomePageFontSize.centigradeSize,
                            fontWeight: FontWeight.bold)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(location ?? 'Şehir verisi alınamadı :(',
                          style: const TextStyle(
                              fontSize: HomePageFontSize.locationSize)),
                      IconButton(
                          onPressed: () async {
                            location = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ScreenPage()));
                            getMyResponse();
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
