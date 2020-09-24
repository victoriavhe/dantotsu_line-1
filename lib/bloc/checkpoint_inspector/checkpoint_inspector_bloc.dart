import 'package:bloc/bloc.dart';
import 'package:dantotsu_line/bloc/checkpoint_inspector/checkpoint_inspector_event.dart';
import 'package:dantotsu_line/bloc/checkpoint_inspector/checkpoint_inspector_state.dart';
import 'package:dantotsu_line/model/utd/inspector_checkpoint_response.dart';
import 'package:dantotsu_line/services/repository/utd/app_repository.dart';

class CPInspectorBloc extends Bloc<CPInspectorEvent, CPInspectorState> {
  CPInspectorBloc(CPInspectorState initialState) : super(initialState);

  CPInspectorState get initialState => CPIUnintiallized();
  AppRepository _appRepository = AppRepository();

  @override
  Stream<CPInspectorState> mapEventToState(CPInspectorEvent event) async* {
    try {
      if (event is PostCheckPointInspector) {
        yield CPILoading();

        //TODO is there data for it
        final InspectorCpResponses responses =
            await _appRepository.postCheckpointInspector(event.body);

        if (responses.result.toUpperCase() == "SUCCESS") {
          yield CPILoaded(responses);
        } else {
          yield CPIError(responses.message);
        }
      }
    } on Exception catch (e) {
      yield CPIError(e.toString());
    }
  }
}
