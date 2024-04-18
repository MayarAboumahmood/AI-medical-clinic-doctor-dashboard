import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/location_service.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class SelectLocationMapPage extends StatefulWidget {
  const SelectLocationMapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<SelectLocationMapPage> {
  final MapController _mapController = MapController();
  LocationData? _initialPosition;
  LocationService locationService = LocationService();
  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  void _handleTap(LatLng latlng) {
    print("Latitude: ${latlng.latitude}, Longitude: ${latlng.longitude}");
  }

  Future<void> _determinePosition() async {
    _initialPosition = await locationService.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    if (_initialPosition == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("OpenStreetMap")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("OpenStreetMap"),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: LatLng(
              _initialPosition!.latitude!,
              _initialPosition!
                  .longitude!), 
          initialZoom: 13.0,
          onTap: (_, latlng) => _handleTap(latlng),
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
        ],
      ),
    );
  }
}
