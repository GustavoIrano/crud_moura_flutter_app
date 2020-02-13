import 'package:crud_moura_flutter_app/android/telas/Home.dart';
import 'package:crud_moura_flutter_app/bloc/texts.bloc.dart';
import 'package:flutter/material.dart';

class MyMaterialApp extends StatelessWidget {

  var texts = new TextsBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: texts.nameApp,
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
