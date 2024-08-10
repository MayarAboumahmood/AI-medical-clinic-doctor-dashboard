import 'package:bloc/bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_blocs/connectivity_bloc/connectivity_event.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_blocs/connectivity_bloc/connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityBloc() : super(ConnectivityInitial()) {
    // Listen to the connectivity status
    // _connectivitySubscription = _connectivity.onConnectivityChanged
    //     .listen((List<ConnectivityResult> connectivityResults) {
    //   bool isDisconnected =
    //       connectivityResults.contains(ConnectivityResult.none) ||
    //           (connectivityResults.contains(ConnectivityResult.none) &&
    //               connectivityResults.contains(ConnectivityResult.vpn)) ||
    //           (connectivityResults.contains(ConnectivityResult.none) &&
    //               connectivityResults.contains(ConnectivityResult.bluetooth));

    //   // Add additional checks for VPN and Bluetooth if required by your app logic
    //   if (isDisconnected) {
    //     add(ConnectivityDisconnected());
    //   } else {
    //     add(ConnectivityConnected());
    //   }
    // });

    // Handle connectivity events
    on<ConnectivityConnected>((event, emit) => emit(ConnectivityOnline()));
    on<ConnectivityDisconnected>((event, emit) => emit(ConnectivityOffline()));
  }

  // @override
  // Future<void> close() {
  //   _connectivitySubscription.cancel();
  //   return super.close();
  // }
}
