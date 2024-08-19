import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/cubit/registration_data_complete_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/location_service.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class SelectLocationMapPage extends StatefulWidget {
  const SelectLocationMapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

//TODO set argument I send from the prev screen and if it's from seting the info or editing I act defrently.
LocationData? _initialPosition;

class MapPageState extends State<SelectLocationMapPage> {
  final MapController _mapController = MapController();
  LocationService locationService = LocationService();
  late RegistrationDataCompleteCubit registrationDataCompleteCubit;
  List<Marker> markers = []; // List to hold markers
  List<Marker> userCurrentLocationmarkers = []; // List to hold markers
  @override
  void initState() {
    super.initState();
    _determinePosition();
    registrationDataCompleteCubit =
        context.read<RegistrationDataCompleteCubit>();
  }

  void animateToUserLocation() {
    if (_initialPosition != null) {
      _mapController.move(
        LatLng(_initialPosition!.latitude!, _initialPosition!.longitude!),
        13.0,
      );
      LatLng userLatLng =
          LatLng(_initialPosition!.latitude!, _initialPosition!.longitude!);
      setState(() {
        addUserLocationMarker(userLatLng);
      });
    }
  }

  void _handleLongTap(LatLng latlng) {
    setState(() {
      addMarker(latlng);
    });
    registrationDataCompleteCubit.setUserLating(latlng);
  }

  void addMarker(LatLng latlng) {
    markers.clear();
    markers.add(
      Marker(
        width: 80.0,
        height: 80.0,
        point: latlng,
        child: const Icon(Icons.location_on, size: 40.0, color: Colors.red),
      ),
    );
  }

  void addUserLocationMarker(LatLng latlng) {
    userCurrentLocationmarkers.clear();
    userCurrentLocationmarkers.add(
      Marker(
        width: 80.0,
        height: 80.0,
        point: latlng,
        child: Icon(Icons.location_on, size: 40.0, color: customColors.primary),
      ),
    );
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

  List<Polygon> polygons = [];

  Scaffold buildMapBody() {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: responsiveUtil.screenHeight * .7),
        child: Column(
          children: [
            markers.isNotEmpty
                ? floatingActionSingleButtom(
                    Icons.assistant_navigation,
                    () {
                      if (registrationDataCompleteCubit.userLatLng != null) {
                        navigationService
                            .navigateTo(completeCertificationsPage);
                      } else {
                        customSnackBar(
                            'You should select your clinic location', context,
                            isFloating: true);
                      }
                    },
                  )
                : const SizedBox(
                    height: 40,
                  ),
            const SizedBox(
              height: 10,
            ),
            floatingActionSingleButtom(
                Icons.my_location_outlined, animateToUserLocation),
          ],
        ),
      ),
      appBar: appBarPushingScreens('Select your Clinic location',
          isFromScaffold: true),
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
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const [],
          ),
          MarkerLayer(
            markers:
                markers + userCurrentLocationmarkers, // Use the markers list
          ),
          PolygonLayer(polygons: polygons),
          MobileLayerTransformer(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('Long press on your clinic location to define it'.tr(),
                style: customTextStyle.bodyLarge
                    .copyWith(color: customColors.primary)),
          ))
        ],
      ),
    );
  }

  GestureDetector floatingActionSingleButtom(
      IconData icon, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: customColors.primaryBackGround,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Icon(
            icon,
            color: customColors.primary,
          ),
        ),
      ),
    );
  }

  Scaffold circularProgressScafold() {
    return Scaffold(
      appBar: appBarPushingScreens('Select your Clinic location',
          isFromScaffold: true),
      backgroundColor: customColors.primaryBackGround,
      body: Center(
          child: CircularProgressIndicator(
        color: customColors.primary,
      )),
    );
  }
}
