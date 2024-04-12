import 'package:equatable/equatable.dart';


abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object> get props => [];
}

class ConnectivityConnected extends ConnectivityEvent {}

class ConnectivityDisconnected extends ConnectivityEvent {}
