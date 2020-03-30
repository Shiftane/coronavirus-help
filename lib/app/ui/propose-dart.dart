import 'package:coronavirushelp/app/ui/form/propose-form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProposePage extends StatefulWidget {
  ProposePage({Key key}) : super(key: key);

  @override
  _ProposePageState createState() => _ProposePageState();
}

class _ProposePageState extends State<ProposePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Faite votre demande")),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Expanded(
            child: new Material(
              child: new ProposeForm(),
            ),
          ),
          new Container(
            color: Colors.white,
            padding: new EdgeInsets.all(10.0),
            child: new RaisedButton(child: Text("Faire une demande")),
          ),
        ],
      ),
    );
  }
}
