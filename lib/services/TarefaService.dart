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

    var tarefaParaAdicionar = new Tarefa("00000000-0000-0000-0000-000000000000", nomeTarefa, false);

    var body = await MontaObjetoTarefa(tarefaParaAdicionar, false);

    return http.post(
        this.urlTarefas,
        headers: {"Content-Type": "application/json"},
        body: body).then((http.Response response){

          final int statusCode = response.statusCode;

          if (statusCode < 200 || statusCode > 400 || json == null) {
            throw new Exception("Error while fetching data");
          }

    });
  }

  Future AlterarTarefa(Tarefa tarefa, String novoNome) async {

    var tarefaParaAlterar = new Tarefa(tarefa.tarefaid, novoNome, tarefa.tarefarealizada);

    var body = await MontaObjetoTarefa(tarefaParaAlterar, false);

    return http.put(
        getUrlComId(tarefa.tarefaid),
        headers: {"Content-Type": "application/json"},
        body: body).then((http.Response response){

          final int statusCode = response.statusCode;

          if (statusCode < 200 || statusCode > 400 || json == null) {
            throw new Exception("Error while fetching data");
          }
    });
  }

  Future AlterarStatus(Tarefa tarefa) async
  {
    var body = await MontaObjetoTarefa(tarefa, true);

    return http.put(
        getUrlComId(tarefa.tarefaid),
        headers: {"Content-Type": "application/json"}, body: body).then((http.Response response){

          final int statusCode = response.statusCode;

          if (statusCode < 200 || statusCode > 400 || json == null) {
            throw new Exception("Error while fetching data");
          }
    });
  }

  Future DeletarTarefa(String idTarefa)async
  {
    return http.delete(
          getUrlComId(idTarefa),
          headers: {"Content-Type": "application/json"}
        );
  }

  MontaObjetoTarefa(Tarefa tarefa, bool isAlterarEstatus) async{
    return json.encode({
      "id": tarefa.tarefaid,
      "nome": tarefa.tarefanome,
      "realizada": isAlterarEstatus ? !tarefa.tarefarealizada : tarefa.tarefarealizada
    });
  }

  getUrlComId(String idTarefa){
    return Uri.parse(this.urlTarefas.toString() + idTarefa);
  }

}