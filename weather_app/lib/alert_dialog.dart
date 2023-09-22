import 'package:flutter/material.dart';
class Alert{

 Future<void> showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Şehir Bulunamadı'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Böyle bir şehir bulunamadı.'),
              Text('Doğru yazdığınızdan emin misiniz?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Tamam'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}