import 'package:flutter/material.dart';

class ProposeForm extends StatefulWidget {
  ProposeForm({Key key}) : super(key: key);

  @override
  _ProposeFormState createState() => _ProposeFormState();
}

class _ProposeFormState extends State<ProposeForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Form(
         key: _formKey,
         child: Column(children: <Widget>[
           TextFormField(
             validator: (value){
              if (value.isEmpty) {
                return 'Ce champ doit contenir une valeur';
              }
              return null;
             },
             maxLength: 50,
             decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Votre demande (max 50 caractères)'
            ),
           ),
           TextFormField(
             validator: (value){
              if (value.isEmpty) {
                return 'Ce champ doit contenir une valeur';
              }
              return null;
             },
             decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Votre nom'
            ),
           ),
           TextFormField(
              keyboardType: TextInputType.multiline,

             validator: (value){
              if (value.isEmpty) {
                return 'Ce champ doit contenir une valeur';
              }
              return null;
             },
             decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Votre demande (longue)'
            ),
           )
       ],)),
    );
  }
}