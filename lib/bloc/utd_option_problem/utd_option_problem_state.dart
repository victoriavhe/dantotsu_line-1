import 'package:dantotsu_line/model/problem/problem_response.dart';
import 'package:dantotsu_line/model/reason_transfer_problem/reason_trf_problem_responses.dart';
import 'package:dantotsu_line/model/transfer_problem/detail_responses.dart';
import 'package:dantotsu_line/model/transfer_problem/manual/manual_response.dart';
import 'package:equatable/equatable.dart';

import '../../model/reason_transfer_problem/reason_trf_problem_responses.dart';

abstract class OptionProblemState extends Equatable {}

class OPUninitialized extends OptionProblemState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class OPLoading extends OptionProblemState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class OPLoaded extends OptionProblemState {
  final ProblemResponse response;

  OPLoaded(this.response);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class OPEmpty extends OptionProblemState {
  final String message;

  OPEmpty(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class OPError extends OptionProblemState {
  final String message;

  OPError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SetReasonTPInitial extends OptionProblemState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SetReasonTPLoading extends OptionProblemState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SetReasonTPLoaded extends OptionProblemState {
  final TpFromAlarmResponse response;

  SetReasonTPLoaded(this.response);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SetTPByProessLoaded extends OptionProblemState {
  final ManualResponse response;

  SetTPByProessLoaded(this.response);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SetReasonTPEmpty extends OptionProblemState {
  final String message;

  SetReasonTPEmpty(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SetReasonTPError extends OptionProblemState {
  final String message;

  SetReasonTPError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class DetailTransferLoaded extends OptionProblemState {
  final DetailResponses response;

  DetailTransferLoaded(this.response);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
