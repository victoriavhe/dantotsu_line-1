import 'package:dantotsu_line/model/utd/utd_checkpoint.dart';
import 'package:equatable/equatable.dart';

abstract class SNComponentInspectorState extends Equatable {}

class SNCUninitialized extends SNComponentInspectorState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SNCLoading extends SNComponentInspectorState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SNCLoaded extends SNComponentInspectorState {
  final UtdCheckpoint response;

  SNCLoaded(this.response);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SNCEmpty extends SNComponentInspectorState {
  final String message;

  SNCEmpty(this.message);
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SNCError extends SNComponentInspectorState {
  final String message;

  SNCError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
