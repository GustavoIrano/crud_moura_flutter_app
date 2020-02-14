# Lista de tarefas - Flutter

Para desenvolver o app foi adicionado somente mais um package, o http.
Foi separado em pastas a versão android e a versão ios.(Fiz somente a versão android). No arquivo main.dart foi feito um chaveamento que verifica qual dispositivo que está rodando o app e retorna a versão em ios(Cupertino) ou android(material).
Também foi criada uma pasta service que contém os arquivos que fazem as chamadas para a API, uma pasta models e uma pasta uteis. 
O app está apontando para a API publicada no AZURE.

## Como funciona:

## Adicionar tarefa:
Na appBar há um ícone de + que ao clicá-lo será exibida uma dialog para inserção da tarefa.

## Alterar tarefa:
Para alterar a tarefa é necessário clicar no nome da tarefa e será exibida uma dialog para alterar o nome.

## Deletar tarefa:
Para deletar uma tarefa é necessário clicar no ícone de exclusão que está a frente do nome da tarefa e confirmar a exclusão na dialog. 

## Marcar tarefa como concluída:
Para marcar uma tarefa como concluída basta criar no ícone que está antes do nome da tarefa. Ao marcar essa opção o ícone ficará verde. Para desfazer essa opção basta clicar novamente no ícone.
