import 'package:crud_moura_flutter_app/bloc/texts.bloc.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  @override
  Home_State createState() => Home_State();
}

class Home_State extends State<Home> {

  var texts = new TextsBloc();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(texts.nameApp),
      ),
      child: ListView(
        children: <Widget>[

        ],
      ),
    );
  }
}
