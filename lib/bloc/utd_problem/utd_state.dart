import 'package:dantotsu_line/model/unreason_transfer_problem/unreason_transfer_problem.dart';
import 'package:equatable/equatable.dart';

abstract class UTDState extends Equatable {}

class UTDUninitialized extends UTDState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UTDLoading extends UTDState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UTDLoaded extends UTDState {
  final UnreasonTrfProblem unreasonTrfProblem;

  UTDLoaded(this.unreasonTrfProblem);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UTDEmpty extends UTDState {
  final String message;

  UTDEmpty(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UTDError extends UTDState {
  final String message;

  UTDError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LogoutSuccess extends UTDState {
  final String message;

  LogoutSuccess(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LogoutFailed extends UTDState {
  final String message;

  LogoutFailed(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

