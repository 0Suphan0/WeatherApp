import 'package:flutter/material.dart';
import 'package:weather_app/screen_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String backgroundAssetUrl = 'assets/c.jpg';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(backgroundAssetUrl), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('20 °C',
                style: TextStyle(
                    fontSize: HomePageFontSize.centigradeSize,
                    fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Ankara",
                    style: TextStyle(fontSize: HomePageFontSize.locationSize)),
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
