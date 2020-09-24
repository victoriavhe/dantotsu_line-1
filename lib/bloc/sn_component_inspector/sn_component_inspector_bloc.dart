import 'package:bloc/bloc.dart';
import 'package:dantotsu_line/bloc/sn_component_inspector/sn_component_inspector_event.dart';
import 'package:dantotsu_line/bloc/sn_component_inspector/sn_component_inspector_state.dart';
import 'package:dantotsu_line/model/utd/utd_checkpoint.dart';
import 'package:dantotsu_line/services/repository/utd/app_repository.dart';

class SNComponentInspectorBloc
    extends Bloc<SNComponentInspectorEvent, SNComponentInspectorState> {
  SNComponentInspectorBloc(SNComponentInspectorState initialState)
      : super(initialState);
  AppRepository _repository = AppRepository();

  SNComponentInspectorState get initialState => SNCUninitialized();

  @override
  Stream<SNComponentInspectorState> mapEventToState(
      SNComponentInspectorEvent event) async* {
    if (event is FetchSNComponent) {
      yield SNCLoading();
      try {
        UtdCheckpoint response =
            await _repository.fetchSNComponent(event.componentRfidID);

        if (response.result.toString().toUpperCase() == "SUCCESS") {
          if (response.data == null) {
            yield SNCEmpty("No Data. Try Again.");
          } else {
            yield SNCLoaded(response);
          }
        } else {
          yield SNCError(response.message);
        }
      } on Exception catch (e) {
        yield SNCError(e.toString());
      }
    }
  }
}
