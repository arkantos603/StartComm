import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:startcomm/common/models/map_model.dart';
import 'package:startcomm/common/widgets/custom_app_bar.dart';
import 'package:startcomm/repositories/map_repository.dart';

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
  final MapRepository _mapRepository = MapRepository();

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    final markers = await _mapRepository.getMarkers();
    setState(() {
      _markers.clear();
      for (var marker in markers) {
        _markers.add(
          Marker(
            markerId: MarkerId(marker.id),
            position: LatLng(marker.latitude, marker.longitude),
            infoWindow: InfoWindow(
              title: marker.title,
              snippet: marker.description,
            ),
            onTap: () => _showMarkerOptions(marker.id, LatLng(marker.latitude, marker.longitude)),
          ),
        );
      }
    });
  }

  void _addMarker(LatLng position) async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar Fornecedor'),
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
              onPressed: () async {
                final BuildContext currentContext = context; // Captura o contexto antes do await

                final String title = titleController.text;
                final String description = descriptionController.text;

                if (title.isNotEmpty && description.isNotEmpty) {
                  final marker = MapMarker(
                    id: position.toString(),
                    title: title,
                    description: description,
                    latitude: position.latitude,
                    longitude: position.longitude,
                  );

                  await _mapRepository.addMarker(marker);

                  if (!mounted) return; // Garante que o widget ainda está na árvore antes do setState

                  setState(() {
                    _markers.add(
                      Marker(
                        markerId: MarkerId(marker.id),
                        position: LatLng(marker.latitude, marker.longitude),
                        infoWindow: InfoWindow(
                          title: marker.title,
                          snippet: marker.description,
                        ),
                        onTap: () => _showMarkerOptions(marker.id, LatLng(marker.latitude, marker.longitude)),
                      ),
                    );
                  });

                  if (currentContext.mounted) { // Agora verifica diretamente no contexto capturado
                    Navigator.of(currentContext).pop();
                  }
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
          content: Text('Você deseja editar ou remover este Fornecedor?'),
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
              onPressed: () async {
                final BuildContext currentContext = context; // Captura o contexto antes do await

                final String title = titleController.text;
                final String description = descriptionController.text;

                if (title.isNotEmpty && description.isNotEmpty) {
                  final marker = MapMarker(
                    id: markerId,
                    title: title,
                    description: description,
                    latitude: position.latitude,
                    longitude: position.longitude,
                  );

                  await _mapRepository.updateMarker(marker);

                  if (!mounted) return; // Garante que o widget ainda está ativo antes do setState

                  setState(() {
                    _markers.removeWhere((m) => m.markerId.value == markerId);
                    _markers.add(
                      Marker(
                        markerId: MarkerId(marker.id),
                        position: LatLng(marker.latitude, marker.longitude),
                        infoWindow: InfoWindow(
                          title: marker.title,
                          snippet: marker.description,
                        ),
                        onTap: () => _showMarkerOptions(marker.id, LatLng(marker.latitude, marker.longitude)),
                      ),
                    );
                  });

                  if (currentContext.mounted) { // Verifica se o contexto ainda é válido antes de navegar
                    Navigator.of(currentContext).pop();
                  }
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

    if (confirm == true && mounted) {
      await _mapRepository.deleteMarker(markerId);
      setState(() {
        _markers.removeWhere((m) => m.markerId.value == markerId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: const CustomAppBar(title: 'Salvar Fornecedores'),
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