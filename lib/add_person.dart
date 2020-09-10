import 'package:flutter/material.dart';

import 'constants.dart';
import 'infra.dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DsiScaffold(
      body: Column(
        children: <Widget>[
          Spacer(),
          Text(
          'Cadastro',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold
          ),
          ),
          Constants.spaceSmallHeight,
          AddForm(),
          Spacer(),
          Padding(
            padding: Constants.paddingMedium,
            child: Text(
              'Cadastro de pessoa',
              style: Theme.of(context).textTheme.caption.copyWith(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}

class AddForm extends StatefulWidget{
  @override
  AddFormState createState(){
    return AddFormState();
  }

}

class AddFormState extends State<AddForm>{
  final _finalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key:_finalKey,
      child: Padding(
        padding: Constants.paddingSmall,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'Nome*'),
              validator: (String value) {
                return value.isEmpty ? 'Escreva um Nome!' : null;
              },
            ),
            Constants.spaceSmallHeight,
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'CPF*'),
              validator: (String value) {
                return value.isEmpty ? 'CPF inválido!' : null;
              },
            ),
            Constants.spaceSmallHeight,
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'Endereço*'),
              validator: (String value) {
                return value.isEmpty ? 'Endereço inválido!' : null;
              },
            ),
            ButtonBar(
              buttonMinWidth: dsiHelper.getBodyWidth(context),
              children: [
                Row(
                  children: [
                    Text(
                      'Adicionar'
                    ),
                    Icon(Icons.add),

                  ],
                )
              ],
            ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(

              onPressed: ()=>dsiHelper.go(context, '/home'),
              child: Text('Concluir'),
            ),
          )
          ],
        ),
      ),
    );
  }



}