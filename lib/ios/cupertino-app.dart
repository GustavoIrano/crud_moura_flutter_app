import 'package:crud_moura_flutter_app/bloc/texts.bloc.dart';
import 'package:crud_moura_flutter_app/ios/telas/Home.dart';
import 'package:flutter/cupertino.dart';

class MyCuppertinoApp  extends StatelessWidget {

  var texts = new TextsBloc();

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: texts.nameApp,
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
