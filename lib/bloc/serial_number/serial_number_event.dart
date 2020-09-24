import 'package:equatable/equatable.dart';

abstract class SerialNumberEvent extends Equatable {}

class FetchSerialNumber extends SerialNumberEvent {
  final int componentID;
  final int routeID;

  FetchSerialNumber(this.componentID, this.routeID);

  @override
  List<Object> get props => throw UnimplementedError();
}
