import 'package:startcomm/common/models/map_model.dart';

abstract class MapState {}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final List<MapMarker> markers;

  MapLoaded(this.markers);
}

class MapError extends MapState {
  final String message;

  MapError(this.message);
}