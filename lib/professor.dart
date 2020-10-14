import 'package:dsi_app/constants.dart';
import 'package:dsi_app/dsi_widgets.dart';
import 'package:dsi_app/infra.dart';
import 'package:dsi_app/pessoa.dart';
import 'package:flutter/material.dart';


class Professor extends Pessoa {

  String idprof;

  //Construtor da classe Professor.
  Professor({cpf, nome, endereco, this.idprof});

  Professor.fromJson(Map<String, dynamic> json)
      : idprof = json['codID'],
        super.fromJson(json);

  ///TIP este método converte o objeto atual para um mapa que representa um
  ///objeto JSON.
  Map<String, dynamic> toJson() =>
      super.toJson()
        ..addAll({
          'codID': idprof,
        });

}
var professorController = ProfessorController();

class ProfessorController {
  List<Professor> getAll() {
    return pessoaController.getAll().whereType<Professor>().toList();
  }

  Professor save(professor) {
    return pessoaController.save(professor);
  }

  bool remove(professor) {
    return pessoaController.remove(professor);
  }
}

class ListProfessorPage extends StatefulWidget {
  @override
  ListProfessorPageState createState() => ListProfessorPageState();
}

class ListProfessorPageState extends State<ListProfessorPage> {
  List<Professor> _professores = professorController.getAll();

  @override
  Widget build(BuildContext context) {
    return DsiScaffold(
      title: 'Listagem de Professores',
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => dsiHelper.go(context, '/maintain_professor'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        // physics: NeverScrollableScrollPhysics(),
        itemCount: _professores.length,
        itemBuilder: _buildListTileProfessor,
      ),
    );
  }

  Widget _buildListTileProfessor(context, index) {
    var professor = _professores[index];
    print(professor);
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        setState(() {
          professorController.remove(professor);
          _professores.remove(index);
        });
        dsiHelper.showMessage(
          context: context,
          message: '${professor.nome} foi removido.',
        );
      },
      background: Container(
        color: Colors.red,
        child: Row(
          children: <Widget>[
            Constants.boxSmallHeight,
            Icon(Icons.delete, color: Colors.white),
            Spacer(),
            Icon(Icons.delete, color: Colors.white),
            Constants.boxSmallHeight,
          ],
        ),
      ),
      child: ListTile(
        title: Text(professor.nome),
        subtitle: Column(
          children: <Widget>[
            SizedBox(width: 8.0),
            Text('IDprof. ${professor.idprof}'),
          ],
        ),
        onTap: () =>
            dsiHelper.go(context, "/maintain_professor", arguments: professor),
      ),
    );
  }
}

class MaintainProfessorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Professor professor = dsiHelper.getRouteArgs(context);
    if (professor == null) {
      professor = new Professor();
    }

    return DsiBasicFormPage(
        title: 'Professor',
        onSave: () {
          professorController.save(professor);
          dsiHelper.go(context, '/list_professor');
        },
        body: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: Constants.boxSmallHeight.height,
            children: <Widget>[
              MaintainPessoaBody(professor),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'codigo de ID*'),
                validator: (String value) {
                  return value.isEmpty ? 'codigo de ID inválido.' : null;
                },
                initialValue: professor.idprof,
                onSaved: (newValue) => professor.idprof = newValue,)
            ]));
  }
}
