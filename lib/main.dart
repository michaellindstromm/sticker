import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Sticker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController mapController;

  GoogleMapOptions _googleMapOptions = GoogleMapOptions(
    cameraPosition: CameraPosition(
      target: LatLng(33.7490, -84.3880),
      zoom: 11.0,
    ),
    myLocationEnabled: true,
    compassEnabled: true,
    trackCameraPosition: true,
    zoomGesturesEnabled: true,
  );

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _onMapTypeButtonPressed() {
    print('button pressed');
  }

  void _onAddMarkerButtonPressed() {
    mapController.addMarker(
      MarkerOptions(
        position: LatLng(
          mapController.cameraPosition.target.latitude,
          mapController.cameraPosition.target.longitude,
        ),
        infoWindowText: InfoWindowText('Random Place', '5 Star Rating'),
        icon: BitmapDescriptor.defaultMarker,
        draggable: true,
      ),
    );
  }

  void _onZoomIncrease() {
    mapController.updateMapOptions(
      GoogleMapOptions(
        cameraPosition: CameraPosition(
          target: LatLng(
            mapController.cameraPosition.target.latitude,
            mapController.cameraPosition.target.longitude,
          ),
          zoom: mapController.cameraPosition.zoom + 0.5,
        ),
      ),
    );
  }

  void _onZoomDecrease() {
    mapController.updateMapOptions(
      GoogleMapOptions(
        cameraPosition: CameraPosition(
          target: LatLng(
            mapController.cameraPosition.target.latitude,
            mapController.cameraPosition.target.longitude,
          ),
          zoom: mapController.cameraPosition.zoom - 0.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.title),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height,
            width: double.infinity,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              options: _googleMapOptions,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: _onMapTypeButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.green,
                    child: const Icon(
                      Icons.map,
                      size: 36.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  FloatingActionButton(
                    onPressed: _onAddMarkerButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.green,
                    child: const Icon(
                      Icons.add_location,
                      size: 36.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: _onZoomIncrease,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.green,
                    child: const Icon(
                      Icons.add,
                      size: 36.0,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  FloatingActionButton(
                    onPressed: _onZoomDecrease,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.green,
                    child: const Icon(
                      Icons.remove,
                      size: 36.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
