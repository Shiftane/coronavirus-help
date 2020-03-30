import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';

class DemandForm extends StatefulWidget {
  DemandForm({Key key}) : super(key: key);

  @override
  _DemandFormState createState() => _DemandFormState();
}

                          
class _DemandFormState extends State<DemandForm> {
  final _formKey = GlobalKey<FormState>();
  


  @override
  Widget build(BuildContext context) {

    return Container(
       child: Padding(
         padding: const EdgeInsets.all(10.0),
         child: Form(
           key: _formKey,
           child: Column(children: <Widget>[
             TextFormField(
               validator: (value){
                if (value.isEmpty) {
                  return 'Ce champ doit contenir une valeur';
                }
                return null;
               },
               maxLength: 50,
               decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Votre demande (max 50 caractères)'
              ),
             ),
             TextFormField(
               validator: (value){
                if (value.isEmpty) {
                  return 'Ce champ doit contenir une valeur';
                }
                return null;
               },
               decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Votre nom'
              ),
             ),
             TextFormField(
                keyboardType: TextInputType.multiline,

               validator: (value){
                if (value.isEmpty) {
                  return 'Ce champ doit contenir une valeur';
                }
                return null;
               },
               decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Votre demande (longue)'
              ),
              
             ),
         ],)),
       ),
    );
  }
}