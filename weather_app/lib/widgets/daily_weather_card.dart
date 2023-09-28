import 'package:flutter/material.dart';

class DailyWeather extends StatelessWidget {
  const DailyWeather({Key? key, required this.icon, required this.centigrate, required this.date}) : super(key: key);

  final String? icon;
  final double? centigrate;
  final String? date;

  @override
  Widget build(BuildContext context) {

    // date verisini gün formatına çevirmek icin...

    List<String> weekDays = ["Pazartesi","Salı","Çarşamba", "Perşembe", "Cuma", "Cumartesi", "Pazar"];

    String weekday=weekDays[DateTime.parse(date??"").weekday-1];
    //

    return SizedBox(
      width: 150,
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            SizedBox(
              height: 70,
              child:
                  Image.network('https://openweathermap.org/img/wn/$icon.png'),
            ),
            Center(
              child: Text("$centigrate°C",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Text(weekday)
          ],
        ),
      ),
    );
  }
}
