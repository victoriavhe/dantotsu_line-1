import 'package:bloc/bloc.dart';
import 'package:dantotsu_line/bloc/utd_chekpoint_group_leader/checkpoint_group_leader_event.dart';
import 'package:dantotsu_line/bloc/utd_chekpoint_group_leader/checkpoint_group_leader_state.dart';
import 'package:dantotsu_line/model/utd/group_leader_checkpoint_response.dart';
import 'package:dantotsu_line/model/utd/inspector_checkpoint_response.dart';
import 'package:dantotsu_line/model/utd/utd_checkpoint.dart';
import 'package:dantotsu_line/services/repository/utd/app_repository.dart';

class CheckpointGroupLeaderBloc
    extends Bloc<CheckpointGroupLeaderEvent, CheckpointGroupLeaderState> {
  AppRepository _appRepository = AppRepository();

  CheckpointGroupLeaderBloc(CheckpointGroupLeaderState initialState)
      : super(initialState);

  @override
  Stream<CheckpointGroupLeaderState> mapEventToState(
      CheckpointGroupLeaderEvent event) async* {
    if (event is PostCheckpointGroupLeader) {
      try {
        yield CheckpointGroupLeaderLoading();
        final GroupLeaderCpResponse response =
            await _appRepository.postCheckpointGroupLeader(event.body);

        if (response.result.toLowerCase() == "success") {
          yield CheckpointGroupLeaderLoaded(response);
        } else {
          yield CheckpointGroupLeaderError(response.message);
        }
      } on Exception catch (e) {
        yield CheckpointGroupLeaderError(e.toString());
      }
    } else if (event is FetchDetail) {
      try {
        yield CheckpointGroupLeaderLoading();
        final UtdCheckpoint response =
            await _appRepository.fetchSNComponent(event.componentRfidId);

        if (response.result.toLowerCase() == "success") {
          if (response.data != null || response.data.toString() != "{}") {
            yield DetailLoaded(response);
          } else {
            yield CheckpointGroupLeaderEmpty("No data. Try again.");
          }
        } else {
          yield CheckpointGroupLeaderError(response.message);
        }
      } on Exception catch (e) {
        yield CheckpointGroupLeaderError(e.toString());
      }
    } else if (event is PostCheckPointInspector) {
      try {
        yield CheckpointGroupLeaderLoading();
        final InspectorCpResponses response =
            await _appRepository.postCheckpointInspector(event.body);

        if (response.result.toLowerCase() == "success") {
          yield CPILoaded(response);
        } else {
          yield CheckpointGroupLeaderError(response.message);
        }
      } on Exception catch (e) {
        yield CheckpointGroupLeaderError(e.toString());
      }
    }
  }
}
