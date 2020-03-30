import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirushelp/app/model/person.dart';
import 'package:geohash/geohash.dart';

class Demand {
  String id;
  String title;
  Person demander;
  String description;
  DateTime creationDatetime;
  DateTime demandDatetime;
  String googleLocation;
  Map coordinates;
  String status;
  String accepterUniquePhoneId;

  Demand(
      {this.id,
      this.title,
      this.description,
      this.demander,
      this.demandDatetime,
      this.creationDatetime,
      this.googleLocation,
      this.coordinates,
      this.status,
      this.accepterUniquePhoneId}) {
    creationDatetime = DateTime.now();
  }

  Demand.fromJson(Map<String, dynamic> data, String id)
      : this(
          id: id,
          title: data['title'],
          description: data['description'],
          demander: Person.fromJson(data['demander']),
          demandDatetime: (data['demandDateTime'] as Timestamp).toDate(),
          creationDatetime: (data['creationDateTime'] as Timestamp).toDate(),
          googleLocation: data['googleLocation'],
          coordinates: data['coordinates'],
          status : data['status'],
          accepterUniquePhoneId : data['accepterUniquePhoneId'],
        );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'demander': demander.toJson(),
        'creationDateTime': creationDatetime,
        'demandDateTime': demandDatetime,
        'googleLocation': googleLocation,
        'coordinates': coordinates,
        'geohash': Geohash.encode(coordinates['lat'], coordinates['lng']),
        'status' : 'waiting',
        'accepterUniquePhoneId' : ''
      };

  static Demand fromSnapshot(DocumentSnapshot snapshot) {
    return Demand.fromJson(snapshot.data, snapshot.documentID);
  }
}

class AllDemands {
  List<Demand> allDemands;
  AllDemands(this.allDemands);

  factory AllDemands.fromSnapshot(QuerySnapshot s) {
    List<Demand> demands = s.documents.map((DocumentSnapshot ds) {
      return new Demand.fromJson(ds.data, ds.documentID);
    }).toList();
    return AllDemands(demands);
  }
}
