import 'package:coronavirushelp/app/config/constant.dart';
import 'package:coronavirushelp/app/model/demand.dart';
import 'package:coronavirushelp/app/ui/demand/demand-title-desc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/geocoding.dart';

class DemandLocationPage extends StatefulWidget {
  final Demand demand;

  DemandLocationPage({Key key, @required this.demand}) : super(key: key);

  @override
  _DemandLocationPageState createState() => _DemandLocationPageState();
}

class _DemandLocationPageState extends State<DemandLocationPage> {
  TextEditingController _addressController = new TextEditingController();

  final geocoding = new GoogleMapsGeocoding(apiKey: Constant.kGoogleApiKey);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _addressController.text = widget.demand.googleLocation;

    return Scaffold(
      appBar: AppBar(
        title: Text("Où ai-je besoin d'aide ? "),
      ),
      body: new SingleChildScrollView(

          padding: EdgeInsets.all(40),
          child: Form(
            key: _formKey,
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sélectionnez l'emplacement de votre demande",
                  style: Theme.of(context).textTheme.headline,
                ),
                PlacesAutocompleteFormField(
                  apiKey: Constant.kGoogleApiKey,
                  controller: _addressController,
                  language: 'fr',
                  mode: Mode.overlay,
                  hint: "Choisissez votre adresse/quartier/commune",
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
      
    );
  }

  void _continue(context) async {
    if (_formKey.currentState.validate()) {
      widget.demand.googleLocation = _addressController.text;

      GeocodingResponse response =
          await geocoding.searchByAddress(_addressController.text);
      Map<String, double> coordinates = {
        'lat': response.results.first.geometry.location.lat,
        'lng': response.results.first.geometry.location.lng,
      };
      widget.demand.coordinates = coordinates;

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DemandTitleDescPage(demand: widget.demand)),
      );
    }
  }
}
