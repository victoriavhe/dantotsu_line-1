import 'package:bloc/bloc.dart';
import 'package:dantotsu_line/bloc/serial_number_inspector/serial_number_inspector_event.dart';
import 'package:dantotsu_line/bloc/serial_number_inspector/serial_number_inspector_state.dart';
import 'package:dantotsu_line/model/utd/utd_serial_numbers.dart';
import 'package:dantotsu_line/services/repository/utd/app_repository.dart';

class SNInspectorBloc extends Bloc<SNInspectorEvent, SNInspectorState> {
  SNInspectorBloc(SNInspectorState initialState) : super(initialState);
  AppRepository _repository = AppRepository();

  SNInspectorState get initialState => SNUninitialized();

  @override
  Stream<SNInspectorState> mapEventToState(SNInspectorEvent event) async* {
    if (event is FetchUTDSNInspector) {
      yield SNLoading();
      try {
        UtdSerialNumber response =
            await _repository.fetchSNInspector(event.componentID);

        if (response.result.toString().toUpperCase() == "SUCCESS") {
          if (response.data == null) {
            yield SNEmpty("No data. Try Again.");
          } else {
            yield SNLoaded(response);
          }
        } else {
          yield SNError(response.message);
        }
      } on Exception catch (e) {
        yield SNError(e.toString());
      }
    }
  }
}
