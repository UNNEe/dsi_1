import 'package:dsi_app/dsi_widgets.dart';
import 'package:dsi_app/infra.dart';
import 'package:flutter/material.dart';
import 'package:dsi_app/constants.dart';

class RecoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DsiScaffold(
      body: Column(
        children: <Widget>[
          Spacer(),
          //todo
          _FormBuilder(),
          Spacer(),


        ],
      )
    );
  }
}

class _FormBuilder extends StatefulWidget{
  @override
  RecoverState createState(){
    return RecoverState();
  }

}

class RecoverState extends State<_FormBuilder>{
  final _formkey = GlobalKey<FormState>();

  String _validator(String value){
    if (value.isEmpty){
      return "Digite o Email";
    }
    if(!value.contains("@")){
      return "Email não valido";
    }

  }

  void _recover(){
    if (!_formkey.currentState.validate()) return;

    dsiDialog.showInfo(
      context: context,
      message: "Email de recuperaçao enviado",
      buttonPressed: () => dsiHelper..back(context)..back(context),
    );

  }
  void _cancel(){
    dsiHelper.back(context);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formkey,
      child: Padding(
        padding: Constants.paddingMedium,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "E-MAIL*"
              ),
              validator: (String value){
                return _validator(value);
              },
            ),
            Constants.spaceSmallHeight,
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text("Enviar"),
                onPressed: _recover,
              ),
            ),
            FlatButton(
              child: Text("Cancelar"),
             onPressed: _cancel,
            )

          ],
        ),
      ),
    );
  }
}