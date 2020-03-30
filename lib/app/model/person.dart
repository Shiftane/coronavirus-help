import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geohash/geohash.dart';

class Person{
  String uniquePhoneId;
  String name;
  String email;
  String phone;


  Person({this.name, this.email, this.phone, this.uniquePhoneId});

  

  Person.fromJson(Map<String, dynamic> data)
    : this(
      name : data['name'],
      email : data['email'],
      phone : data['phone'],
      uniquePhoneId : data['uniquePhoneId'],
    );  

    Map<String, dynamic> toJson() =>
    {
      'name': name,
      'email' : email,
      'phone' : phone,
      'uniquePhoneId' : uniquePhoneId,
    };

}