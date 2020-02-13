import 'package:crud_moura_flutter_app/Models/Tarefa.dart';
import 'package:crud_moura_flutter_app/android/telas/Home.dart';
import 'package:crud_moura_flutter_app/services/TarefaService.dart';
import 'package:flutter/material.dart';

class StackBuilder {
  Stack buildStack(BuildContext context, Tarefa tarefa,
      TarefaService tarefaService) {

    showAlertDialog(BuildContext context, Tarefa tarefa) {
      Widget cancelButton = FlatButton(
        child: Text("Cancelar"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );


      Widget payButton = FlatButton(
        child: Text("Confirmar exclusão?"),
        onPressed: () async {

          TarefaService tarefaService = new TarefaService();
          tarefaService.DeletarTarefa(tarefa.tarefaid).then((_){
            Navigator.push(context, new MaterialPageRoute(builder: (context) => Home()));
          });

        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Excluir Tarefa"),
        content: Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child:
          new RichText(
          text: new TextSpan(
              style: new TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                new TextSpan(
                    text: 'Tarefa: ' + tarefa.tarefanome,
                    style: new TextStyle(fontWeight: FontWeight.bold))
              ]),
        ),
        ),
        actions: [
          cancelButton,
          payButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    mudarStatusTarefa(Tarefa) {
      TarefaService tarefaService = new TarefaService();
      tarefaService.AlterarStatus(tarefa).then((_){
        Navigator.push(context, new MaterialPageRoute(builder: (context) => Home()));
      });
    }

    showAlertDialogEditar(BuildContext context, Tarefa tarefa) {

      var textController = new TextEditingController();
      textController.text = tarefa.tarefanome.toString();

      String teamName = "";
      Widget cancelButton = FlatButton(
        child: Text("Cancelar"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );


      Widget payButton = FlatButton(
        child: Text("Confirmar alteração?"),
        onPressed: () async {
          TarefaService tarefaService = new TarefaService();
          tarefaService.AlterarTarefa(tarefa, teamName).then((_){
            Navigator.push(context, new MaterialPageRoute(builder: (context) => Home()));
          });
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Alterar Tarefa"),
        content: Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child:
          new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
                  controller: textController,
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Nome'),
                  onChanged: (value) {
                    teamName = value;
                  },
                ))
          ],
        ),
        ),
        actions: [
          cancelButton,
          payButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Stack(children: <Widget>[
      // The containers in the background
      Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 80.0,
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Material(
                color: Colors.white,
                elevation: 14.0,
                shadowColor: Color(0x802196F3),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            mudarStatusTarefa(tarefa);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.assignment_turned_in,
                                           color: tarefa.tarefarealizada ? Colors.green : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showAlertDialogEditar(context, tarefa);
                          },
                          child: Text(
                            tarefa.tarefanome,
                            style:
                            TextStyle(color: Colors.black, fontSize: 20.0),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showAlertDialog(context, tarefa);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    ]);
  }
}