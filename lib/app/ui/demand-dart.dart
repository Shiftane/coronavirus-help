import 'package:coronavirushelp/app/ui/form/demand-form.dart';
import 'package:flutter/material.dart';

class DemandPage extends StatefulWidget {
  DemandPage({Key key}) : super(key: key);

  @override
  _DemandPageState createState() => _DemandPageState();
}

class _DemandPageState extends State<DemandPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Faite votre demande")),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Expanded(
            child: new Material(
              child: new DemandForm(key: Key("demand_1"),),
            ),
          ),
          new Container(
            color: Colors.white,
            padding: new EdgeInsets.all(10.0),
            child: new RaisedButton(
                child: Text("Demander de l'aide"), onPressed: () => _addDemand),
          ),
        ],
      ),
    );
  }

  void _addDemand(){
    
  }
}
