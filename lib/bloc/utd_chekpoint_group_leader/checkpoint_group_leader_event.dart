import 'package:dantotsu_line/model/utd/group_leader_checkpoint_body.dart';
import 'package:dantotsu_line/model/utd/inspector_checkpoint_body.dart';
import 'package:equatable/equatable.dart';

class CheckpointGroupLeaderEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class PostCheckpointGroupLeader extends CheckpointGroupLeaderEvent {
  final GroupLeaderCpBody body;

  PostCheckpointGroupLeader(this.body);
}

class FetchDetail extends CheckpointGroupLeaderEvent {
  final int componentRfidId;

  FetchDetail(this.componentRfidId);
}

class PostCheckPointInspector extends CheckpointGroupLeaderEvent {
  final InspectorCpBody body;

  PostCheckPointInspector(this.body);
}
