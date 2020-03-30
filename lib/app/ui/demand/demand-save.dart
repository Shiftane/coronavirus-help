import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirushelp/app/model/demand.dart';
import 'package:coronavirushelp/main.dart';
import 'package:flutter/material.dart';

class DemandSavePage extends StatefulWidget {
  final Demand demand;

  DemandSavePage({Key key, @required this.demand}) : super(key: key);

  @override
  _DemandSavePageState createState() => _DemandSavePageState();
}

class _DemandSavePageState extends State<DemandSavePage> {
  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('demands').add(widget.demand.toJson());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Félicitation"),
      ),
      body: Container(
        margin: EdgeInsets.all(40),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Expanded(
              child: new Column(
                children: <Widget>[
                  
                  Text("Votre demande a été enregistré",
                      style: Theme.of(context).textTheme.headline),
                  Spacer(flex:1),
                  Icon(Icons.check, size: 100, color: CompanyColors.green),
                  Spacer(flex:1),
                  Text(
                      "Nous croisons les doigts pour qu'une personne vous contact rapidement",
                      style: Theme.of(context).textTheme.body1),
                  Spacer(flex:1),
                  Text("Prochaines étapes",
                      style: Theme.of(context).textTheme.headline),
                  Spacer(flex:1),
                  Text(
                      "Maintenant attendez sagement chez vous que quelqu'un se propose pour vous aider",
                      style: Theme.of(context).textTheme.body1),
                  Spacer(flex:4),
                ],
              ),
            ),
            Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: RaisedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Retour à l'accueil"),
                        Icon(Icons.home),
                      ],
                    ),
                    onPressed: () => _backHome(context),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  void _backHome(context) {
    Navigator.pushReplacementNamed(
      context,
      "/"
    );
  }
}
