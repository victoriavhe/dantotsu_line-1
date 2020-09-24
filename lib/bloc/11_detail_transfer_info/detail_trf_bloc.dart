import 'package:bloc/bloc.dart';
import 'package:dantotsu_line/model/transfer_problem/stop/stop_trf_problem_response.dart';
import 'package:dantotsu_line/services/repository/utd/app_repository.dart';

import 'detail_trf_event.dart';
import 'detail_trf_state.dart';

class DetailTransferBloc
    extends Bloc<DetailTransferEvent, DetailTransferState> {
  DetailTransferBloc(DetailTransferState initialState) : super(initialState);
  AppRepository _repository = AppRepository();

  DetailTransferState get initialState => StopTPInitial();

  @override
  Stream<DetailTransferState> mapEventToState(
      DetailTransferEvent event) async* {
    if (event is PostStopTP) {
      yield StopTPLoading();
      try {
        StopTpResponse response = await _repository.postStopTP(event.body);

        if (response.result.toString().toUpperCase() == "SUCCESS") {
          if (response.data == null) {
            yield StopTPEmpty("No Data.");
          } else {
            yield StopTPLoaded(response);
          }
        } else {
          yield StopTPError(response.message);
        }
      } on Exception catch (e) {
        yield StopTPError(e.toString());
      }
    }
  }
}
