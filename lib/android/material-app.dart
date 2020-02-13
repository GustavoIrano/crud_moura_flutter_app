import 'package:crud_moura_flutter_app/android/telas/Home.dart';
import 'package:crud_moura_flutter_app/uteis/text.uteis.dart';
import 'package:flutter/material.dart';

class MyMaterialApp extends StatelessWidget {

  var _texts = new TextsUteis();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _texts.nameApp,
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
