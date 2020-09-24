import 'package:dantotsu_line/model/utd/group_leader_checkpoint_response.dart';
import 'package:dantotsu_line/model/utd/inspector_checkpoint_response.dart';
import 'package:dantotsu_line/model/utd/utd_checkpoint.dart';
import 'package:equatable/equatable.dart';

class CheckpointGroupLeaderState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CheckpointGroupLeaderInitial extends CheckpointGroupLeaderState {}

class CheckpointGroupLeaderLoading extends CheckpointGroupLeaderState {}

class CheckpointGroupLeaderLoaded extends CheckpointGroupLeaderState {
  final GroupLeaderCpResponse response;

  CheckpointGroupLeaderLoaded(this.response);
}

class CheckpointGroupLeaderEmpty extends CheckpointGroupLeaderState {
  final String message;

  CheckpointGroupLeaderEmpty(this.message);
}

class CheckpointGroupLeaderError extends CheckpointGroupLeaderState {
  final String message;

  CheckpointGroupLeaderError(this.message);
}

class DetailLoaded extends CheckpointGroupLeaderState {
  final UtdCheckpoint response;

  DetailLoaded(this.response);
}

class CPILoaded extends CheckpointGroupLeaderState {
  final InspectorCpResponses responses;

  CPILoaded(this.responses);
}
