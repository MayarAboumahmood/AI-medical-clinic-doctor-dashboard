import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/cubit/registration_data_complete_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/location_service.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class SelectLocationMapPage extends StatefulWidget {
  const SelectLocationMapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

LocationData? _initialPosition;

class MapPageState extends State<SelectLocationMapPage> {
  final MapController _mapController = MapController();
  LocationService locationService = LocationService();
  late RegistrationDataCompleteCubit registrationDataCompleteCubit;
  List<Marker> markers = []; // List to hold markers
  @override
  void initState() {
    super.initState();
    _determinePosition();
    registrationDataCompleteCubit =
        context.read<RegistrationDataCompleteCubit>();
  }

  void _handleLongTap(LatLng latlng) {
    print(
        "user long pressed on: Latitude: ${latlng.latitude}, Longitude: ${latlng.longitude}");
    setState(() {
      markers.clear();
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: latlng,
          child: const Icon(Icons.location_on, size: 40.0, color: Colors.red),
        ),
      );
    });
    registrationDataCompleteCubit.setUserLating(latlng);
  }

  Future<void> _determinePosition() async {
    _initialPosition = await locationService.getCurrentLocation();
    if (kDebugMode) {
      print('user current location: $_initialPosition');
    }
    registrationDataCompleteCubit.gettingUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (pop) {
        print('user current location poped');
        registrationDataCompleteCubit.emitInitState();
      },
      child: BlocConsumer<RegistrationDataCompleteCubit,
          RegistrationDataCompleteState>(
        listener: (context, state) {
          if (state is GettingUserLocationState && _initialPosition == null) {
            _determinePosition();
          }
        },
        builder: (context, state) {
          print('user current location $state');
          if (state is GettingUserLocationState) {
            return buildMapBody();
          }
          return circularProgressScafold();
        },
      ),
    );
  }

  Scaffold buildMapBody() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigationService.navigateTo(completeCertificationsPage);
        },
        child: Icon(
          Icons.assistant_navigation,
          color: customColors.primary,
        ),
      ),
      appBar: AppBar(
        title:
            appBarPushingScreens('Select your locaiton', isFromScaffold: true),
      ),
      backgroundColor: customColors.primaryBackGround,
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          backgroundColor: customColors.primaryBackGround,
          keepAlive: true,
          onLongPress: (_, latlng) => _handleLongTap(latlng),
          initialCenter:
              LatLng(_initialPosition!.latitude!, _initialPosition!.longitude!),
          initialZoom: 13.0,
          // onTap: (_, latlng) => _handleTap(latlng),
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const [],
          ),
          MarkerLayer(
            markers: markers, // Use the markers list
          ),
        ],
      ),
    );
  }

  Scaffold circularProgressScafold() {
    return Scaffold(
      appBar: AppBar(
        title:
            appBarPushingScreens('Select your locaiton', isFromScaffold: true),
      ),
      backgroundColor: customColors.primaryBackGround,
      body: Center(
          child: CircularProgressIndicator(
        color: customColors.primary,
      )),
    );
  }
}
