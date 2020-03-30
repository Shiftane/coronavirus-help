import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirushelp/app/model/demand.dart';
import 'package:coronavirushelp/app/ui/map/selected-item-information.dart';
import 'package:flutter/material.dart';
import 'package:geohash/geohash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  GoogleMapController _controller;
  MarkerId selectedMarker;
  AllDemands demands;
  bool _informationVisible = false;
  SelectedItemInformation _selectedItemInformation = SelectedItemInformation();

  void _onMapCreated(GoogleMapController controller) {
    this._controller = controller;
    setState(() {
      _informationVisible = false;
    });

    getPosition().then((value) {
      Future<QuerySnapshot> snapshot = getSnapshot();
      snapshot.then((QuerySnapshot value) {
        setState(() {
          print(value.toString());
          demands = AllDemands.fromSnapshot(value);
          _showDemands();
        });
      });
    });
  }

  void _showDemands() {
    setState(() {
      demands.allDemands.forEach((demand) {
        final MarkerId markerId = MarkerId(demand.id);
        final Marker marker = Marker(
          alpha: 1.0,
          markerId: markerId,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position:
              LatLng(demand.coordinates['lat'], demand.coordinates['lng']),
          onTap: () => _onMarkerTapped(markerId),
        );
        markers[markerId] = marker;
      });
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(46.776477, 6.819583),
    zoom: 10.4746,
  );

  Position position;

  @override
  void initState() {
    super.initState();
  }

  Future<QuerySnapshot> getSnapshot() {
    Map<String, double> range =
        getGeohashRange(position.latitude, position.longitude, 1500);
    return Firestore.instance
        .collection('demands')
        .where(
          "geohash",
          isGreaterThan: Geohash.encode(range['lowerLat'], range['lowerLng']),
          isLessThan: Geohash.encode(range['upperLat'], range['upperLng']),
        ).where('status', 
          isEqualTo: 'waiting',
        )
        .getDocuments();
  }

  Map<String, double> getGeohashRange(
    double latitude,
    double longitude,
    double distance, // km
  ) {
    // lat => 1 deg = 110.574 km
    // lng => 1 deg = 111.320*cos(latitude)

    double lat = 1 / 110.574; // degrees latitude per mile
    double lon = 1 / (110.574 * cos(lat)); // degrees longitude per mile

    double lowerLat = latitude - lat * distance;
    double lowerLon = longitude - lon * distance;

    double upperLat = latitude + lat * distance;
    double upperLon = longitude + lon * distance;

    Map<String, double> range = {
      'lowerLat': lowerLat,
      'lowerLng': lowerLon,
      'upperLat': upperLat,
      'upperLng': upperLon
    };

    return range;
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        if (markers.containsKey(selectedMarker)) {
          final Marker resetOld = markers[selectedMarker]
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[selectedMarker] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
            iconParam: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
            );
        markers[markerId] = newMarker;
        
        Future<DocumentSnapshot> demandSnapshot = Firestore.instance.collection('demands').document(markerId.value).get();
        demandSnapshot.then((snapshot) {
          setState(() {
            _selectedItemInformation = SelectedItemInformation(demand: Demand.fromSnapshot(snapshot));
            _informationVisible = true;  
          });
          
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Carte"),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: _onMapCreated,
            markers: Set<Marker>.of(markers.values),
            compassEnabled: true,
            mapToolbarEnabled: false,
          ),
          AnimatedPositioned(
              bottom: _informationVisible ? (20) : (-100),
              right: 0,
              left: 0,
              duration: Duration(milliseconds: 200),
              // wrap it inside an Alignment widget to force it to be
              // aligned at the bottom of the screen
              child: Align(
                  alignment: Alignment.bottomCenter,
// wrap it inside a Container so we can provide the
// background white and rounded corners
// and nice breathing room with margins, a fixed height
// and a nice subtle shadow for a depth effect
                  child: Container(
                      margin: EdgeInsets.all(20),
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                blurRadius: 20,
                                offset: Offset.zero,
                                color: Colors.grey.withOpacity(0.5))
                          ]),
                      child: _selectedItemInformation,
                      ) // end of Container
                  ) // end of Align
              )
        ],
      ),
    );
  }

  void _goBack() {
    Navigator.of(context).pop();
  }

  Future<void> getPosition() async {
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 10.2799,
    );

    this
        ._controller
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}
