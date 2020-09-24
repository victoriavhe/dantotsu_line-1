import 'package:dantotsu_line/model/transfer_problem/stop/stop_trf_problem_response.dart';
import 'package:equatable/equatable.dart';

abstract class DetailTransferState extends Equatable {}


class StopTPInitial extends DetailTransferState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class StopTPLoading extends DetailTransferState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class StopTPLoaded extends DetailTransferState {
  final StopTpResponse response;

  StopTPLoaded(this.response);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class StopTPEmpty extends DetailTransferState {
  final String message;

  StopTPEmpty(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class StopTPError extends DetailTransferState {
  final String message;

  StopTPError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
