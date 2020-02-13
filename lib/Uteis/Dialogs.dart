import 'package:crud_moura_flutter_app/android/telas/Home.dart';
import 'package:crud_moura_flutter_app/bloc/texts.bloc.dart';
import 'package:crud_moura_flutter_app/services/TarefaService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dialogs {

  var texts = new TextsBloc();

  void save(String nomeTarefa, BuildContext context){
    TarefaService tarefa = TarefaService();
    tarefa.AdicionarTarefa(nomeTarefa)
        .then((_) {

      Navigator.push(context, new MaterialPageRoute(builder: (context) => Home()));
    });
  }

  Future<String> asyncInputDialog(BuildContext context) async {
    String teamName = '';
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.top),
            child:
            AlertDialog(
          title: Text(texts.inserirTarefa),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: 'Nome', hintText: 'Tarefa'),
                    onChanged: (value) {
                      teamName = value;
                    },
                  ))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () async{
                save(teamName, context);
              },
            ),
            FlatButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        );
      },
    );
  }
}