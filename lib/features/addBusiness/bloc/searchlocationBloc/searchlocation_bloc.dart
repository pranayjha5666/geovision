import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geovision/features/addBusiness/bloc/data/searchlocationrepo/searchlocationlist_repo.dart';
import 'package:geovision/features/addBusiness/bloc/searchlocationBloc/searchlocation_event.dart';
import 'package:geovision/features/addBusiness/bloc/searchlocationBloc/searchlocation_state.dart';
import 'package:geovision/user_model/location_model.dart';

// class SearchLocationBloc extends Bloc<SearchLocationEvent, SearchLocationState> {
//   final SearchlocationlistRepo locationRepository;
//
//   SearchLocationBloc(this.locationRepository) : super(SearchLocationInitial()) {
//     on<FetchLocationsEvent>(_onFetchLocations);
//     on<FilterLocationsEvent>(_onFilterLocations);
//     on<SelectLocationEvent>(_onSelectLocation);
//   }
//
//   Future<void> _onFetchLocations(FetchLocationsEvent event, Emitter<SearchLocationState> emit) async {
//     emit(SearchLocationLoading());
//     try {
//       final locations = await locationRepository.fetchLocations();
//       emit(SearchLocationLoaded(locations));
//     } catch (e) {
//       emit(SearchLocationError("Failed to load locations"));
//     }
//   }
//
//   void _onFilterLocations(FilterLocationsEvent event, Emitter<SearchLocationState> emit) {
//     if (state is SearchLocationLoaded) {
//       final currentState = state as SearchLocationLoaded;
//       final filtered = currentState.locations
//           .where((location) => location.name.toLowerCase().contains(event.query.toLowerCase()))
//           .toList();
//       emit(SearchLocationLoaded(currentState.locations));
//     }
//   }
//
//   void _onSelectLocation(SelectLocationEvent event, Emitter<SearchLocationState> emit) {
//     emit(LocationSelectedState(event.location));
//   }
// }


class LocationBloc extends Bloc<SearchLocationEvent, SearchLocationState> {
  final SearchlocationlistRepo searchlocationlistRepo;
  List<LocationModel> allLocations = [];

  LocationBloc(this.searchlocationlistRepo) : super(SearchLocationLoading()) {
    on<FetchLocationsEvent>((event, emit) async {
      try {
        final locations = await SearchlocationlistRepo().fetchLocations();
        if (locations.isEmpty) {
          emit(SearchLocationError("No locations found"));
          return;
        }
        allLocations=locations;
        emit(SearchLocationLoaded(allLocations));
      } catch (e) {
        emit(SearchLocationError("Error fetching locations: ${e.toString()}"));
      }
    });

    on<FilterLocationsEvent>((event, emit) {
      final filtered = allLocations.where((location) => location.name.toLowerCase().contains(event.query.toLowerCase())).toList();
      emit(SearchLocationLoaded(filtered));
    });
  }
}