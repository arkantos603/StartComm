import 'package:flutter/material.dart';
import 'package:startcomm/common/models/map_model.dart';
import 'package:startcomm/features/map/map_state.dart';
import 'package:startcomm/repositories/map_repository.dart';

class MapController extends ChangeNotifier {
  final MapRepository _mapRepository;

  MapController(this._mapRepository);

  MapState _state = MapInitial();
  MapState get state => _state;

  Future<void> addMarker(MapMarker marker) async {
    _state = MapLoading();
    notifyListeners();

    try {
      await _mapRepository.addMarker(marker);
      _state = MapLoaded(_mapRepository.markers);
    } catch (e) {
      _state = MapError(e.toString());
    }

    notifyListeners();
  }

  Future<void> updateMarker(MapMarker marker) async {
    _state = MapLoading();
    notifyListeners();

    try {
      await _mapRepository.updateMarker(marker);
      _state = MapLoaded(_mapRepository.markers);
    } catch (e) {
      _state = MapError(e.toString());
    }

    notifyListeners();
  }

  Future<void> deleteMarker(String markerId) async {
    _state = MapLoading();
    notifyListeners();

    try {
      await _mapRepository.deleteMarker(markerId);
      _state = MapLoaded(_mapRepository.markers);
    } catch (e) {
      _state = MapError(e.toString());
    }

    notifyListeners();
  }

  Future<void> loadMarkers() async {
    _state = MapLoading();
    notifyListeners();

    try {
      final markers = await _mapRepository.getMarkers();
      _state = MapLoaded(markers);
    } catch (e) {
      _state = MapError(e.toString());
    }

    notifyListeners();
  }
}