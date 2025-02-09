import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startcomm/common/models/map_model.dart';
import 'package:startcomm/services/db_firestore.dart';

class MapRepository {
  final FirebaseFirestore _firestore = DBFirestore.get();
  final List<MapMarker> _markers = [];

  List<MapMarker> get markers => List.unmodifiable(_markers);

  Future<void> addMarker(MapMarker marker) async {
    _markers.add(marker);
    await _firestore.collection('markers').doc(marker.id).set(marker.toMap());
  }

  Future<void> updateMarker(MapMarker marker) async {
    final index = _markers.indexWhere((m) => m.id == marker.id);
    if (index != -1) {
      _markers[index] = marker;
      await _firestore.collection('markers').doc(marker.id).update(marker.toMap());
    }
  }

  Future<void> deleteMarker(String id) async {
    _markers.removeWhere((marker) => marker.id == id);
    await _firestore.collection('markers').doc(id).delete();
  }

  Future<List<MapMarker>> getMarkers() async {
    final querySnapshot = await _firestore.collection('markers').get();
    _markers.clear();
    for (var doc in querySnapshot.docs) {
      _markers.add(MapMarker.fromMap(doc.data(), doc.id));
    }
    return _markers;
  }

  Future<void> loadMarkers() async {
    final querySnapshot = await _firestore.collection('markers').get();
    _markers.clear();
    for (var doc in querySnapshot.docs) {
      _markers.add(MapMarker.fromMap(doc.data(), doc.id));
    }
  }
}