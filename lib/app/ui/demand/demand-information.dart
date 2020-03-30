import 'package:coronavirushelp/app/config/constant.dart';
import 'package:coronavirushelp/app/model/demand.dart';
import 'package:coronavirushelp/app/model/person.dart';
import 'package:coronavirushelp/app/ui/app.dart';
import 'package:coronavirushelp/app/ui/demand/demand-save.dart';
import 'package:coronavirushelp/app/ui/widget/multi-layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class DemandInformationPage extends StatefulWidget {
  final Demand demand;

  DemandInformationPage({Key key, @required this.demand}) : super(key: key);

  @override
  _DemandInformationPageState createState() => _DemandInformationPageState();
}

class _DemandInformationPageState extends State<DemandInformationPage> {
  TextEditingController _nameController = new TextEditingController();

  TextEditingController _emailController = new TextEditingController();

  TextEditingController _phoneController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("De quoi ai-je besoin ? "),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(40),
          child: Column(children: [
            Form(
              key: _formKey,
              child: _buildFields(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Créer la demande"),
                    Icon(Icons.chevron_right),
                  ],
                ),
                onPressed: () => _continue(context),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _continue(context) {
    if (_formKey.currentState.validate()) {
      Constant.getId(context).then((uniquePhoneId) {
        Person demander = Person(
            name: _nameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            uniquePhoneId: uniquePhoneId);
        widget.demand.demander = demander;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => DemandSavePage(demand: widget.demand)),
            (value) => value is BasicApp);
      });
    }
  }

  _buildFields() {
    return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Information sur vous",
            style: Theme.of(context).textTheme.headline,
          ),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: "Nom et prénom"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Ce champ doit contenir une valeur';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Les informations ci-dessous ne seront divulguées uniquement si une personne souhaite vous aider.",
                style: Theme.of(context).textTheme.body2),
          ),
          Icon(Icons.arrow_downward),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            decoration: InputDecoration(labelText: "Email"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Ce champ doit contenir une valeur';
              }
              bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value);
              if (!emailValid) {
                return 'Email invalide';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: 'Numéro de téléphone'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Ce champ doit contenir une valeur';
              }
              return null;
            },
          ),
        ]);
  }
}
