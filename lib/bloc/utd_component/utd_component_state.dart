import 'package:dantotsu_line/model/unit/component/component_per_model.dart';
import 'package:equatable/equatable.dart';

abstract class UTDComponentState extends Equatable {}

class ComponentUninitialized extends UTDComponentState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ComponentLoading extends UTDComponentState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ComponentLoaded extends UTDComponentState {
  final ModelComponentResponse componentResponse;

  ComponentLoaded(this.componentResponse);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ComponentEmpty extends UTDComponentState {
  final String message;

  ComponentEmpty(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ComponentError extends UTDComponentState {
  final String message;

  ComponentError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
