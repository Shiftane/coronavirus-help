import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

class Constant{
  static String kGoogleApiKey = "AIzaSyAYKs2QlaT5rVl4WbqX0nD4DdnQeHnDV48";


  static void saveIdInDB(BuildContext context){
    Future<String> deviceId = getId(context); 
    deviceId.then((value) async =>{
      Firestore.instance.collection('log-app').add({
        'id' : value,
        'datetime' : DateTime.now()
      })
    });
  }

  static Future<String> getId(BuildContext context) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

}

