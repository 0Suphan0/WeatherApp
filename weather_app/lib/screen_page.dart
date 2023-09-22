import 'package:flutter/material.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({Key? key}) : super(key: key);

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  final String backgroundAssetUrl = 'assets/search.jpg';
  final String hintText = 'Lütfen Şehir Giriniz';
  ScreenPageFontAndPaddingSize sizes = ScreenPageFontAndPaddingSize();
  String selectedCity = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(backgroundAssetUrl), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: sizes.inputHorizontalPadding),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        selectedCity = value;
                      },
                      style: TextStyle(fontSize: sizes.inputFontSize),
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sizes.hintSize,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(sizes.inputRadius)),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context,selectedCity);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 3.0, color: Colors.brown),
                        padding: EdgeInsets.all(16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text(
                        'Kaydet',
                        style: TextStyle(
                            color: Colors.white, fontSize: 20), // Metin rengi
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class ScreenPageFontAndPaddingSize {
  final double inputHorizontalPadding = 50;
  final double inputFontSize = 40;
  final double hintSize = 30;
  final double inputRadius = 15;
}
