import 'package:bloc/bloc.dart';
import 'package:dantotsu_line/bloc/ongoing_problem/ongoing_event.dart';
import 'package:dantotsu_line/bloc/ongoing_problem/ongoing_state.dart';
import 'package:dantotsu_line/model/transfer_problem/ongoing/ongoing_response.dart';
import 'package:dantotsu_line/services/repository/utd/app_repository.dart';

class OngoingBloc extends Bloc<OngoingEvent, OngoingState> {
  OngoingBloc(OngoingState initialState) : super(initialState);
  AppRepository _repository = AppRepository();

  OngoingState get initialState => OngoingUninitialized();

  @override
  Stream<OngoingState> mapEventToState(OngoingEvent event) async* {
    if (event is FetchOngoingProblem) {
      yield OngoingLoading();
      try {
        OngoingResponse response = await _repository.fetchOngoingTP();

        if (response.result.toString().toUpperCase() == "SUCCESS") {
          if (response.data == null) {
            yield OngoingEmpty("No Data. Try Again.");
          } else {
            yield OngoingLoaded(response);
          }
        } else {
          yield OngoingError(response.message);
        }
      } on Exception catch (e) {
        yield OngoingError(e.toString());
      }
    }
  }
}
