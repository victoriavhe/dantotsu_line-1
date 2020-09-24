import 'package:bloc/bloc.dart';
import 'package:dantotsu_line/bloc/serial_number/serial_number_event.dart';
import 'package:dantotsu_line/bloc/serial_number/serial_number_state.dart';
import 'package:dantotsu_line/model/unit/serial_number/serial_number.dart';
import 'package:dantotsu_line/services/repository/utd/app_repository.dart';

class SerialNumberBloc extends Bloc<SerialNumberEvent, SerialNumberState> {
  SerialNumberBloc(SerialNumberState initialState) : super(initialState);
  AppRepository _repository = AppRepository();

  SerialNumberState get initialState => SNUninitialized();

  @override
  Stream<SerialNumberState> mapEventToState(SerialNumberEvent event) async* {
    if (event is FetchSerialNumber) {
      yield SNLoading();
      try {
        SerialNumberResponse response = await _repository.fetchSerialNumber(
            event.componentID, event.routeID);

        if (response.result.toString().toUpperCase() == "SUCCESS") {
          if (response.data == null) {
            yield SNEmpty("No Data.");
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
