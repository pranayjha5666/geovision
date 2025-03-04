import 'package:geovision/user_model/location_model.dart';

abstract class SearchLocationState {}

class SearchLocationLoading extends SearchLocationState {}

class SearchLocationLoaded extends SearchLocationState {
  final List<LocationModel> locations;
  SearchLocationLoaded(this.locations);
}

class SearchLocationError extends SearchLocationState {
  final String message;
  SearchLocationError(this.message);
}