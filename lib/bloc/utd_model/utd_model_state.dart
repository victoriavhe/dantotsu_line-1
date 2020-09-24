import 'package:dantotsu_line/model/unit/model/model_per_unit.dart';
import 'package:equatable/equatable.dart';

abstract class UTDModelState extends Equatable {}

class UTDModelUninitialized extends UTDModelState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UTDModelLoading extends UTDModelState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UTDModelLoaded extends UTDModelState {
  final UnitModelResponse response;

  UTDModelLoaded(this.response);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UTDModelEmpty extends UTDModelState {
  final String message;

  UTDModelEmpty(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UTDModelError extends UTDModelState {
  final String message;

  UTDModelError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
