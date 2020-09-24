
import 'package:dantotsu_line/model/unit/serial_number/serial_number.dart';
import 'package:equatable/equatable.dart';

abstract class SerialNumberState extends Equatable {}

class SNUninitialized extends SerialNumberState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SNLoading extends SerialNumberState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SNLoaded extends SerialNumberState {
  final SerialNumberResponse response;

  SNLoaded(this.response);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SNEmpty extends SerialNumberState {
  final String message;

  SNEmpty(this.message);
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SNError extends SerialNumberState {
  final String message;

  SNError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
