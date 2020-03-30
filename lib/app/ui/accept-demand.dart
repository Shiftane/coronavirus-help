import 'package:coronavirushelp/app/model/demand.dart';
import 'package:coronavirushelp/app/ui/app.dart';
import 'package:coronavirushelp/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AcceptDemandPage extends StatefulWidget {
  final Demand demand;
  AcceptDemandPage({Key key, this.demand}) : super(key: key);

  @override
  _AcceptDemandPageState createState() => _AcceptDemandPageState();
}

class _AcceptDemandPageState extends State<AcceptDemandPage> {
  Demand get _demand => widget.demand;
  String _subject = "Quelqu'un souhaite vous aider";
  String _body =
      "Je souhaite t'aider dans cette période difficile. \n Merci de me contacter en répondant à ce mail";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Demande d'aide accepté")),
      body: Builder(
        builder: (context) {
        return Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Text(
                "MERCI BEAUCOUP",
                style: Theme.of(context).textTheme.headline,
              ),
              Icon(
                Icons.thumb_up,
                size: 80,
                color: CompanyColors.green,
              ),
              Text("Maintenant, contacte-moi rapidement"),
              Text("Mon numéro de téléphone est le :"),
              FlatButton(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    _demand.demander.phone,
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () =>
                      _launchURL(context, "tel:" + _demand.demander.phone)),
              Text(
                "(click dessus pour appeler directement)",
                style: TextStyle(fontSize: 14),
              ),
              Text("Voici aussi mon email si besoin : "),
              FlatButton(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    _demand.demander.email,
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () => _launchURL(
                      context,
                      "mailto:" +
                          _demand.demander.email +
                          "?subject=" +
                          _subject +
                          "&body=" +
                          _body)),
              RaisedButton(
                child: Text("Retour au menu"),
                onPressed: () => _backToMenu(),
              )
            ],
          ),
        );
      }),
    );
  }

  _backToMenu() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BasicApp()),
    );
  }

  _launchURL(context, url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      final snackBar = SnackBar(
          content: Text(
              'Impossible de continuer cette action. Vous n\'êtes peut-être pas en possession d\'un téléphone'));

      // Find the Scaffold in the widget tree and use it to show a SnackBar.
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
