import 'package:dantotsu_line/model/transfer_problem/stop/stop_trf_problem_body.dart';
import 'package:equatable/equatable.dart';

abstract class DetailTransferEvent extends Equatable {}

class FetchDetailTransfer extends DetailTransferEvent {
  final int transferProblemId;

  FetchDetailTransfer(this.transferProblemId);

  @override
  List<Object> get props => throw UnimplementedError();
}

class PostStopTP extends DetailTransferEvent {
  final StopTrfProblemBody body;

  PostStopTP(this.body);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
