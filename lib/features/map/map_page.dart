import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final LatLng _initialPosition = LatLng(-5.0888351, -42.811246);
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: MarkerId('initialPosition'),
        position: _initialPosition,
        infoWindow: InfoWindow(
          title: 'IFPI',
          snippet: 'Instituto Federal do Piauí.',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('CASA'),
        position: LatLng(-5.1119271, -42.77068),
        infoWindow: InfoWindow(
          title: 'casita',
          snippet: 'xd.',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('thiagim'),
        position: LatLng(-4.5791836, -42.8590046),
        infoWindow: InfoWindow(
          title: 'INFERNO DA PESTE',
          snippet: 'casa do goat.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Example'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 18.0,
        ),
        markers: _markers,
      ),
    );
  }
}