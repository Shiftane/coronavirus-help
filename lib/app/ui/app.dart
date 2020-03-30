import 'package:coronavirushelp/app/config/constant.dart';
import 'package:coronavirushelp/app/model/demand.dart';
import 'package:coronavirushelp/app/ui/demand/demand-information.dart';
import 'package:coronavirushelp/app/ui/demand/demand-location.dart';
import 'package:coronavirushelp/app/ui/map-page.dart';
import 'package:coronavirushelp/app/ui/propose-dart.dart';
import 'package:coronavirushelp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

class BasicApp extends StatefulWidget {
  BasicApp({Key key}) : super(key: key);

  @override
  _BasicAppState createState() => _BasicAppState();
}

class _BasicAppState extends State<BasicApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coronavirus Help"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom:8.0),
                        child: Text(
                          "Et le colibri lui répondit : \"Je le sais, mais je fais ma part.\"",
                          style: TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: CompanyColors.blue),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        "La légende du colibri",
                        style:
                            TextStyle(fontSize: 12, color: CompanyColors.blue),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),

                Padding(
                        padding: const EdgeInsets.only(bottom:12.0),
                  child: Text(
                    "Vous avez besoin d\'aide",
                    style: Theme.of(context).textTheme.headline,
                    textAlign: TextAlign.center,
                  ),
                ),
                RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.notifications_active,
                        size: 40,
                        color: CompanyColors.blue,
                      ),
                      Spacer(),
                      Text("Demander de l'aide"),
                      Spacer(),
                      Icon(Icons.chevron_right, size: 40),
                    ],
                  ),
                  onPressed: () => createDemand(),
                ),
                // RaisedButton(
                //   child: Text("Proposer de l'aide"),
                //   onPressed: () => createProposal(),
                // ),
                Divider(height: 50,),
                Padding(
                        padding: const EdgeInsets.only(bottom:12.0),
                  child: Text(
                    "Vous pouvez donner un coup de main",
                    style: Theme.of(context).textTheme.headline,
                    textAlign: TextAlign.center,
                  ),
                ),
                RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.map,
                        size: 40,
                        color: CompanyColors.blue,
                      ),
                      Spacer(),
                      Text("Voir la carte des gens dans le besoin"),
                      Spacer(),
                      Icon(Icons.chevron_right, size: 40),
                    ],
                  ),
                  onPressed: () => showMap(),
                ),
                Divider(height: 50,),
                Text(
                  "Participer à l'aventure, rejoins-nous sur Slack",
                  textAlign: TextAlign.center,
                ),
                FlatButton(
                  child: Text("# coronavirushelp.slack.com"),
                  onPressed: () {
                    String urlString =
                        'https://join.slack.com/t/coronavirushelp/shared_invite/zt-d6c5jl3o-s9AHeO5f3Yl4UQj1lcT44Q';
                    launch(urlString);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createDemand() {
    Constant.saveIdInDB(context);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DemandLocationPage(
                demand: new Demand(),
              )),
    );
  }

  void createProposal() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProposePage()),
    );
  }

  void showMap() {
    Constant.saveIdInDB(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapPage()),
    );
  }
}
