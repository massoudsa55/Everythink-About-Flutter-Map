import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:evrythink_about_flutter_map/widgets/drawer.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class TapToAddPage extends StatefulWidget {
  static const String route = '/tap';

  const TapToAddPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TapToAddPageState();
  }
}

class TapToAddPageState extends State<TapToAddPage> {
  List<LatLng> tappedPoints = [];

  @override
  Widget build(BuildContext context) {
    final markers = tappedPoints.map((latlng) {
      print("Location, lat = ${latlng.latitude} long = ${latlng.longitude}");
      return Marker(
        width: 80,
        height: 80,
        point: latlng,
        builder: (ctx) => const Icon(
          Icons.location_on,
          color: Colors.red,
          size: 50,
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Tap to add pins Messaoud')),
      drawer: buildDrawer(context, TapToAddPage.route),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Text('Tap to add pins Messaoud'),
            ),
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                    center: LatLng(34.886540, 3.492616),
                    zoom: 18,
                    onTap: _handleTap),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://api.mapbox.com/styles/v1/messaoud-mobdev123/cl828luuy000314mqcyvki039/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWVzc2FvdWQtbW9iZGV2MTIzIiwiYSI6ImNsNnJ5M3J2cTA0YmIzZHFqMndlYXFhYjAifQ.RsXETDC_kMW9bbCcdV0R7w',
                    additionalOptions: const {
                      'accessToken':
                          'pk.eyJ1IjoibWVzc2FvdWQtbW9iZGV2MTIzIiwiYSI6ImNsNnJ5M3J2cTA0YmIzZHFqMndlYXFhYjAifQ.RsXETDC_kMW9bbCcdV0R7w',
                      'id': 'mapbox.satellite',
                    },
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: tappedPoints,
                        color: Colors.redAccent,
                        strokeWidth: 3.0,
                      ),
                    ],
                  ),
                  MarkerLayer(markers: markers),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    setState(() {
      tappedPoints.add(latlng);
    });
  }
}
