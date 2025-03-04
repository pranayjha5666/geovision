import 'package:geovision/user_model/location_model.dart';

abstract class SearchLocationEvent {}

class FetchLocationsEvent extends SearchLocationEvent {}

class FilterLocationsEvent extends SearchLocationEvent {
  final String query;
  FilterLocationsEvent(this.query);
}

// class SelectLocationEvent extends SearchLocationEvent {
//   final LocationModel location;
//   SelectLocationEvent(this.location);
// }


