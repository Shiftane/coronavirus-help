import 'package:coronavirushelp/app/model/demand.dart';
import 'package:coronavirushelp/app/ui/demand/demand-calendar.dart';
import 'package:flutter/material.dart';

class DemandTitleDescPage extends StatefulWidget {
  final Demand demand;

  DemandTitleDescPage({Key key, @required this.demand}) : super(key: key);

  @override
  _DemandTitleDescPageState createState() => _DemandTitleDescPageState();
}

class _DemandTitleDescPageState extends State<DemandTitleDescPage> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("De quoi ai-je besoin ? "),
      ),
      body: Container(
        margin: EdgeInsets.all(40),
        child: new SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Définissez un brève résumé de votre demande",
                    style: Theme.of(context).textTheme.headline),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      labelText: "Titre de votre demande (max. 40 caractères)"),
                  maxLength: 40,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Ce champ doit contenir une valeur';
                    }
                    return null;
                  },
                ),
                Text("Donnez des informations complémentaires",
                    style: Theme.of(context).textTheme.headline),
                TextFormField(
                  controller: _descController,
                  maxLines: 3,
                  decoration:
                      InputDecoration(labelText: "Description de votre besoin"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Ce champ doit contenir une valeur';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: RaisedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Continuer"),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                    onPressed: () => _continue(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _continue(context) {
    if (_formKey.currentState.validate()) {
      widget.demand.title = _titleController.text;
      widget.demand.description = _descController.text;

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DemandCalendarPage(demand: widget.demand)),
      );
    }
  }
}
