import 'dart:async';
import 'package:crud_moura_flutter_app/Models/Tarefa.dart';
import 'package:crud_moura_flutter_app/services/TarefaService.dart';
import 'package:crud_moura_flutter_app/uteis/text.uteis.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _texts = new TextsUteis();

  TarefaService _tarefaService = new TarefaService();
  Future<List<Tarefa>> tarefas;

  @override
  void initState(){
    super.initState();

    getTarefas();
  }

  getTarefas(){
    setState(() {
      tarefas = _tarefaService.getTarefas();
    });
  }

  _mudarStatusTarefa(Tarefa tarefa) async{
    await _tarefaService.AlterarStatus(tarefa).then((_){
      getTarefas();
    });
  }

  _showAlertDialogEditar(BuildContext context, Tarefa tarefa){

    var textController = new TextEditingController();
    textController.text = tarefa.tarefanome.toString();

    String nomeTarefa = "";

    Widget cancelButton = FlatButton(
      child: Text(_texts.cancelar),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );


    Widget payButton = FlatButton(
      child: Text(_texts.confirmarAlteracao),
      onPressed: () async {
        await _tarefaService.AlterarTarefa(tarefa, nomeTarefa).then((_){
          Navigator.of(context).pop();
          setState(() {
            getTarefas();
          });
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(_texts.alterarTarefaTitulo),
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
                    nomeTarefa = value;
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

  _showAlertDialogDelete(BuildContext context, Tarefa tarefa) {
    Widget cancelButton = FlatButton(
      child: Text(_texts.cancelar),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget payButton = FlatButton(
      child: Text(_texts.confirmarExclusao),
      onPressed: () async {
        await _tarefaService.DeletarTarefa(tarefa.tarefaid).then((_){
          Navigator.of(context).pop();
          setState(() {
            getTarefas();
          });
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(_texts.excluirTarefaTitulo),
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

  _save(String nomeTarefa, BuildContext context)async{
    TarefaService tarefa = TarefaService();
    await tarefa.AdicionarTarefa(nomeTarefa).then((_) {
      Navigator.of(context).pop();
      getTarefas();
    });
  }

  _dialogInserir(BuildContext context) async {

    String nomeTarefa = '';

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.top),
          child:
          AlertDialog(
            title: Text(_texts.inserirTarefa),
            content: new Row(
              children: <Widget>[
                new Expanded(
                    child: new TextField(
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Nome', hintText: 'Tarefa'),
                      onChanged: (value) {
                        nomeTarefa = value;
                      },
                    ))
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(_texts.fechar),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(_texts.confirmar),
                onPressed: () async{
                  _save(nomeTarefa, context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(_texts.nameApp),
        backgroundColor: Colors.grey,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async{
              _dialogInserir(context);
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
                future: tarefas,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text(_texts.carregando),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
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
                                                _mudarStatusTarefa(snapshot.data[index]);
                                              },
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: Icon(Icons.assignment_turned_in,
                                                      color: snapshot.data[index].tarefarealizada ? Colors.green : Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _showAlertDialogEditar(context, snapshot.data[index]);
                                              },
                                              child: Text(
                                                snapshot.data[index].tarefanome,
                                                style: TextStyle(color: Colors.black, fontSize: 20.0),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _showAlertDialogDelete(context, snapshot.data[index]);
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
