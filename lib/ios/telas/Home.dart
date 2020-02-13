import 'package:crud_moura_flutter_app/uteis/text.uteis.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  @override
  Home_State createState() => Home_State();
}

class Home_State extends State<Home> {

  var _texts = new TextsUteis();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(_texts.nameApp),
      ),
      child: ListView(
        children: <Widget>[

        ],
      ),
    );
  }
}
