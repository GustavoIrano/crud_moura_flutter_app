import 'dart:async';

import 'package:crud_moura_flutter_app/Models/Tarefa.dart';
import 'package:crud_moura_flutter_app/Uteis/Dialogs.dart';
import 'package:crud_moura_flutter_app/Uteis/StackBuilder.dart';
import 'package:crud_moura_flutter_app/bloc/texts.bloc.dart';
import 'package:crud_moura_flutter_app/services/TarefaService.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var texts = new TextsBloc();
  TarefaService _tarefaService = new TarefaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(texts.nameApp),
        backgroundColor: Colors.grey,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              new Dialogs().asyncInputDialog(context);
            },
          ),
        ],
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 90,
              child: FutureBuilder(
                future: _tarefaService.getTarefas(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text("Carregando..."),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return StackBuilder().buildStack(context, snapshot
                            .data[index], _tarefaService);
                      },
                    );
                  }
                },
              ),
            )
          ],
      ),
      ),
    );
  }
}
