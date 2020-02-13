class Tarefa{
  String _tarefaid;
  String _tarefanome;
  bool _tarefarealizada;

  Tarefa(this._tarefaid,this._tarefanome,this._tarefarealizada);

  Tarefa.map(dynamic obj){
    this._tarefaid = obj['id'];
    this._tarefanome = obj['nome'];
    this._tarefarealizada = obj['realizada'];
  }

  String get tarefaid => _tarefaid;
  String get tarefanome => _tarefanome;
  bool   get tarefarealizada => _tarefarealizada;

  Map<String,dynamic> toMap(){
    var map = new Map<String,dynamic>();
    map['nome']=_tarefanome;
    map['realizada'] = _tarefarealizada;
    return map;
  }

  Tarefa.fromMap(Map<String,dynamic> map ){
    this._tarefaid = map['id'];
    this._tarefanome = map['nome'];
    this._tarefarealizada = map['realizada'];
  }
}