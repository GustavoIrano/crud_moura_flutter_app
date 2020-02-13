import 'package:crud_moura_flutter_app/ios/telas/Home.dart';
import 'package:crud_moura_flutter_app/uteis/text.uteis.dart';
import 'package:flutter/cupertino.dart';

class MyCuppertinoApp  extends StatelessWidget {

  var _texts = new TextsUteis();

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: _texts.nameApp,
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
