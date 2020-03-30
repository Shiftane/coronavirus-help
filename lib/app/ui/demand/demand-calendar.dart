import 'package:coronavirushelp/app/model/demand.dart';
import 'package:coronavirushelp/app/ui/demand/demand-information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class DemandCalendarPage extends StatefulWidget {
  final Demand demand;

  DemandCalendarPage({Key key, @required this.demand}) : super(key: key);

  @override
  _DemandCalendarPageState createState() => _DemandCalendarPageState();
}

class _DemandCalendarPageState extends State<DemandCalendarPage> {
  TextEditingController _dateController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quand ai-je besoin ?"),
      ),
      body: Container(
        margin: EdgeInsets.all(40),
        child: new SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                    'Choisir une date et heure à laquelle vous souhaitez avoir une réponse',
                    style: Theme.of(context).textTheme.headline),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(labelText: "Date et heure"),
                  controller: _dateController,
                  onTap: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime.now().add(Duration(hours: 1)),
                        maxTime: DateTime(2019, 6, 7),
                        onChanged: (date) {}, onConfirm: (date) {
                      widget.demand.demandDatetime = date;
                      _dateController.text =
                          DateFormat('dd MMM à kk:mm').format(date);
                    }, currentTime: DateTime.now(), locale: LocaleType.fr);
                  },
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
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DemandInformationPage(demand: widget.demand)),
      );
    }
  }
}
