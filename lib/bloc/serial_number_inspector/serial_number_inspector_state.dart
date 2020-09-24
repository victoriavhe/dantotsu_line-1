
import 'package:dantotsu_line/model/utd/utd_serial_numbers.dart';
import 'package:equatable/equatable.dart';

abstract class SNInspectorState extends Equatable {}

class SNUninitialized extends SNInspectorState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SNLoading extends SNInspectorState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SNLoaded extends SNInspectorState {
  final UtdSerialNumber response;

  SNLoaded(this.response);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SNEmpty extends SNInspectorState {
  final String message;

  SNEmpty(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SNError extends SNInspectorState {
  final String message;

  SNError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
