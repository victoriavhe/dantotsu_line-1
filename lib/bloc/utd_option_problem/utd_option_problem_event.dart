import 'package:dantotsu_line/model/reason_transfer_problem/reason_trf_problem_body.dart';
import 'package:dantotsu_line/model/transfer_problem/manual/manual_body.dart';
import 'package:equatable/equatable.dart';

class OptionProblemEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class FetchOptionsProblem extends OptionProblemEvent {
  final int transferProblemID;

  FetchOptionsProblem(this.transferProblemID);
}

class PostTPByAlarm extends OptionProblemEvent {
  final ReasonTrfProblemBody body;

  PostTPByAlarm(this.body);
}

class PostTPByProcess extends OptionProblemEvent {
  final ManualBody body;

  PostTPByProcess(this.body);
}

class FetchDetailTransfer extends OptionProblemEvent {
  final int transferProblemId;

  FetchDetailTransfer(this.transferProblemId);
}

class FetchProblemFromProcess extends OptionProblemEvent{
  final int transferComponentID;

  FetchProblemFromProcess(this.transferComponentID);
}

