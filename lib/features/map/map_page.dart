import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin<MapPage> {
  @override
  bool get wantKeepAlive => true;
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
        onTap: () => _showMarkerOptions('initialPosition', _initialPosition),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('CASA'),
        position: LatLng(-5.1119271, -42.77068),
        infoWindow: InfoWindow(
          title: 'casita',
          snippet: 'não entre',
        ),
        onTap: () => _showMarkerOptions('CASA', LatLng(-5.1119271, -42.77068)),
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
        onTap: () => _showMarkerOptions('thiagim', LatLng(-4.5791836, -42.8590046)),
      ),
    );
  }

  void _addMarker(LatLng position) async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar Marcador'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final String title = titleController.text;
                final String description = descriptionController.text;

                if (title.isNotEmpty && description.isNotEmpty) {
                  setState(() {
                    _markers.add(
                      Marker(
                        markerId: MarkerId(position.toString()),
                        position: position,
                        infoWindow: InfoWindow(
                          title: title,
                          snippet: description,
                        ),
                        onTap: () => _showMarkerOptions(position.toString(), position),
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _showMarkerOptions(String markerId, LatLng position) async {
    final bool? action = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Opções do Marcador'),
          content: Text('Você deseja editar ou remover este marcador?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Remover'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: Text('Editar'),
            ),
          ],
        );
      },
    );

    if (action == true) {
      _removeMarker(markerId);
    } else if (action == null) {
      _editMarker(markerId, position);
    }
  }

  void _editMarker(String markerId, LatLng position) async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Marcador'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final String title = titleController.text;
                final String description = descriptionController.text;

                if (title.isNotEmpty && description.isNotEmpty) {
                  setState(() {
                    _markers.removeWhere((marker) => marker.markerId.value == markerId);
                    _markers.add(
                      Marker(
                        markerId: MarkerId(markerId),
                        position: position,
                        infoWindow: InfoWindow(
                          title: title,
                          snippet: description,
                        ),
                        onTap: () => _showMarkerOptions(markerId, position),
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _removeMarker(String markerId) async {
    final bool? confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Remover Marcador'),
          content: Text('Você tem certeza que deseja remover este marcador?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Remover'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      setState(() {
        _markers.removeWhere((marker) => marker.markerId.value == markerId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Salvar Fornecedores'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 13.0,
        ),
        markers: _markers,
        onTap: _addMarker,
      ),
    );
  }
}