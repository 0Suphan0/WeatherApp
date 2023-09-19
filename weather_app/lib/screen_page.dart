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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: sizes.inputHorizontalPadding),
                child: TextField(
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
