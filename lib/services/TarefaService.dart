import 'dart:convert';
import 'package:crud_moura_flutter_app/Models/Tarefa.dart';
import 'package:http/http.dart' as http;

class TarefaService
{
  Uri urlTarefas = Uri.parse('https://crudmouraapi.azurewebsites.net/api/tarefas/');

  Future<List<Tarefa>> getTarefas() async {
    http.Response response = await http.get(this.urlTarefas);

    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var result = data as List;

      return result.map<Tarefa>((json) => Tarefa.fromMap(json)).toList();
    }
  }

  Future AdicionarTarefa(String nomeTarefa) async {

    var body = {
      "id": "fc3760a3-dde2-47ce-aed4-e640d249c386",
      "nome": nomeTarefa,
      "realizada": false
    };

    return http.post(this.urlTarefas, headers: {"Content-Type": "application/json"}, body: json.encode(body))
        .then((http.Response response){
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
    });
  }

  Future AlterarTarefa(Tarefa tarefa, String novoNome) async
  {
    var body = {
      "id": tarefa.tarefaid,
      "nome": novoNome,
      "realizada": tarefa.tarefarealizada
    };

    Uri url = Uri.parse(this.urlTarefas.toString() + tarefa.tarefaid);

    return http.put(url, headers: {"Content-Type": "application/json"}, body: json.encode(body))
        .then((http.Response response){
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
    });
  }

  Future AlterarStatus(Tarefa tarefa) async
  {
    var body = {
      "id": tarefa.tarefaid,
      "nome": tarefa.tarefanome,
      "realizada": !tarefa.tarefarealizada
    };

    Uri url = Uri.parse(this.urlTarefas.toString() + tarefa.tarefaid);

    return http.put(url, headers: {"Content-Type": "application/json"}, body: json.encode(body))
        .then((http.Response response){
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
    });
  }

  Future DeletarTarefa(String idTarefa)async
  {
    Uri url = Uri.parse(this.urlTarefas.toString() + idTarefa);

    return http.delete(url, headers: {"Content-Type": "application/json"} );
  }

}