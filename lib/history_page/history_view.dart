import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trizard/theme.dart';

class MapSample extends StatefulWidget {
  MapSample(
      {Key? key,
      required this.latitude,
      required this.longitude,
      required this.kondisi})
      : super(key: key);
  double latitude;
  double longitude;
  String kondisi;
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  MapSampleState({Key? key});

  @override
  Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = LatLng(5.548290, 95.323753);

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() async {
    var markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(10, 10)), 'assets/marker.png');

    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Emergency Car',
          snippet: widget.kondisi,
        ),
        icon: markerIcon,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    _onAddMarkerButtonPressed();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
              color: Colors.blueGrey,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Pemetaan Posisi",
            style: greenBlueStyle,
          ),
          centerTitle: true,
        ),
        body: Container(
          height: 620,
          child: Column(
            children: [
              SizedBox(
                height: 500,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    heightFactor: 0.3,
                    widthFactor: 2.5,
                    child: Stack(
                      children: <Widget>[
                        GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(widget.latitude, widget.longitude),
                            zoom: 11.0,
                          ),
                          mapType: _currentMapType,
                          markers: _markers,
                          onCameraMove: _onCameraMove,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              children: <Widget>[
                                FloatingActionButton.small(
                                  heroTag: "1",
                                  onPressed: _onMapTypeButtonPressed,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                  backgroundColor: Colors.green,
                                  child: const Icon(Icons.map, size: 25.0),
                                ),
                                SizedBox(height: 16.0),
                                FloatingActionButton.small(
                                  heroTag: "2",
                                  onPressed: _onAddMarkerButtonPressed,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                  backgroundColor: Colors.green,
                                  child: const Icon(Icons.location_pin,
                                      size: 25.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(41, 0, 0, 0),
                      blurStyle: BlurStyle.normal,
                      spreadRadius: 0.0001,
                      blurRadius: 5,
                      offset: Offset(5, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 20,
                      child: Text("EMERGENCY",
                          style:
                              redkkStyle.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width,
                      child: Text("Car Status : ${widget.kondisi}",
                          style: blackStyle),
                    ),
                    Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          "Location : ${widget.latitude}, ${widget.longitude}",
                          style: blackStyle),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
