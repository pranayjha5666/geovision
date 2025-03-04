import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geovision/user_model/location_model.dart';

class LocationScreen extends StatefulWidget {
  final LocationModel location;
  const LocationScreen({super.key, required this.location});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late GoogleMapController mapController;
  late LatLng _selectedLocation;

  @override
  void initState() {
    super.initState();
    // Ensure latitude and longitude are parsed as doubles
    double latitude = double.tryParse(widget.location.latitude.toString()) ?? 0.0;
    double longitude = double.tryParse(widget.location.longitude.toString()) ?? 0.0;
    _selectedLocation = LatLng(latitude, longitude);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMapTapped(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
  }

  void _onContinuePressed() {
    // Handle continue button action (e.g., save selected location)
    print("Selected Location: $_selectedLocation");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.location.name)),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _selectedLocation,
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('selected-location'),
                  position: _selectedLocation,
                ),
              },
              onTap: _onMapTapped,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _onContinuePressed,
              child: const Text("Continue"),
            ),
          ),
        ],
      ),
    );
  }
}
