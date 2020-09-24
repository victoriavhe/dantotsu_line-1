import 'package:dantotsu_line/model/transfer_problem/ongoing/ongoing_response.dart';
import 'package:equatable/equatable.dart';

abstract class OngoingState extends Equatable {}

class OngoingUninitialized extends OngoingState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class OngoingLoading extends OngoingState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class OngoingLoaded extends OngoingState {
  final OngoingResponse response;

  OngoingLoaded(this.response);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class OngoingEmpty extends OngoingState {
  final String message;

  OngoingEmpty(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class OngoingError extends OngoingState {
  final String message;

  OngoingError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
