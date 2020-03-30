import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirushelp/app/config/constant.dart';
import 'package:coronavirushelp/app/model/demand.dart';
import 'package:coronavirushelp/app/ui/accept-demand.dart';
import 'package:coronavirushelp/app/ui/app.dart';
import 'package:coronavirushelp/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DemandDetailPage extends StatefulWidget {
  final Demand demand;
  DemandDetailPage({Key key, this.demand}) : super(key: key);

  @override
  _DemandDetailPageState createState() => _DemandDetailPageState();
}

class _DemandDetailPageState extends State<DemandDetailPage> {
  Demand get demand => widget.demand;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détail de l'offre"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.all(40),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Je m'appelle",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    widget.demand.demander.name,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline,
                  ),
                  Divider(),
                  Spacer(flex: 1),
                  Text(
                    "Je souhaiterai qu'une personne m'aide pour : ",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    demand.title,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline,
                  ),
                  Spacer(flex: 1),
                  Text(
                    "Cela consiste en : ",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    widget.demand.description,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(flex: 1),
                  Divider(),
                  Spacer(flex: 1),
                  Text(
                    "Il me faudrait une réponse avant le : ",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    DateFormat('dd MMM à kk:mm')
                        .format(widget.demand.demandDatetime),
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline,
                  ),
                  Spacer(flex: 1),
                  Divider(),
                  Spacer(flex: 1),
                  Text(
                    "Es-tu prêt à m'aider ? Si oui je te transmets mes coordonnées pour prendre contact.",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline,
                  ),
                  Spacer(flex: 1),
                  RaisedButton(
                    child: Text("OUI, je souhaite t'aider"),
                    onPressed: () => _acceptDemand(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _acceptDemand() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Tu es sur le point d'accepter une demande",
              style: TextStyle(color: CompanyColors.blue)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text(
                  "Nous souhaitons attirer ton attention sur le fait que si tu cliques sur oui, tu deviendras le/la responsable de cette demande. Ta responsabilité sera d'aider cette personne."),
            ],
          ),
          actions: <Widget>[
            new RaisedButton(
              child: new Text("Accepter"),
              onPressed: () {
                Constant.getId(context).then((id) {
                  demand.status = 'accepted';
                  demand.accepterUniquePhoneId = id;
                  Firestore.instance
                      .collection('demands')
                      .document(demand.id)
                      .updateData({'status': 'accepted', 'accepterUniquePhoneId' : id});
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AcceptDemandPage(demand: demand)),
                    (value) => value is BasicApp);
                });
                
              },
            ),
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
