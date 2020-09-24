import 'package:bloc/bloc.dart';
import 'package:dantotsu_line/bloc/utd_option_problem/utd_option_problem_event.dart';
import 'package:dantotsu_line/bloc/utd_option_problem/utd_option_problem_state.dart';
import 'package:dantotsu_line/model/problem/problem_response.dart';
import 'package:dantotsu_line/model/reason_transfer_problem/reason_trf_problem_responses.dart';
import 'package:dantotsu_line/model/transfer_problem/detail_responses.dart';
import 'package:dantotsu_line/model/transfer_problem/manual/manual_response.dart';
import 'package:dantotsu_line/services/repository/utd/app_repository.dart';

import '../../model/reason_transfer_problem/reason_trf_problem_responses.dart';

class OptionProblemBloc extends Bloc<OptionProblemEvent, OptionProblemState> {
  OptionProblemBloc(OptionProblemState initialState) : super(initialState);
  AppRepository _utdRepository = AppRepository();
  AppRepository _repository = AppRepository();

  OptionProblemState get initialState => OPUninitialized();

  @override
  Stream<OptionProblemState> mapEventToState(OptionProblemEvent event) async* {
    if (event is FetchOptionsProblem) {
      yield OPLoading();
      try {
        ProblemResponse response =
            await _utdRepository.fetchOptionsProblem(event.transferProblemID);

        if (response.result.toString().toUpperCase() == "SUCCESS") {
          if (response.data == null) {
            yield OPEmpty("No data. Try again.");
          } else if (response.message.contains("not found")) {
            yield OPEmpty("No data. Try again.");
          } else {
            yield OPLoaded(response);
          }
        } else if (response.result.toString().toLowerCase() == "error") {
          yield OPError(response.message);
        }
      } on Exception catch (e) {
        yield OPError(e.toString());
      }
    } else if (event is PostTPByAlarm) {
      yield OPLoading();
      try {
        TpFromAlarmResponse response = await _repository.postSetReasonTP(event.body);

        if (response.result.toLowerCase() == "success") {
          yield SetReasonTPLoaded(response);
        } else {
          yield SetReasonTPError(response.message);
        }
      } on Exception catch (e) {
        yield SetReasonTPError(e.toString());
      }
    } else if (event is PostTPByProcess) {
      yield OPLoading();
      try {
        ManualResponse response = await _repository.postTPByProcess(event.body);

        if (response.result.toLowerCase() == "success") {
          yield SetTPByProessLoaded(response);
        } else {
          yield SetReasonTPError(response.message);
        }
      } on Exception catch (e) {
        yield SetReasonTPError(e.toString());
      }
    } else if (event is FetchDetailTransfer) {
      yield OPLoading();
      try {
        DetailResponses response =
            await _repository.getDetailResponse(event.transferProblemId);

        if (response.result.toString().toUpperCase() == "SUCCESS") {
          if (response.data == null) {
            yield OPEmpty("No data. Try again.");
          } else if (response.message.contains("not found")) {
            yield OPEmpty("No data. Try Again.");
          } else {
            yield DetailTransferLoaded(response);
          }
        } else if (response.result.toString().toLowerCase() == "error") {
          yield OPError(response.message);
        }
      } on Exception catch (e) {
        yield OPError(e.toString());
      }
    } else if (event is FetchProblemFromProcess) {
      yield OPLoading();
      try {
        ProblemResponse response = await _repository
            .fetchProblemFromProcess(event.transferComponentID);

        if (response.result.toLowerCase() == "success") {
          if (response.data == null) {
            yield OPEmpty("No data. Try Again.");
          } else {
            yield OPLoaded(response);
          }
        } else {
          yield OPError(response.message);
        }
      } on Exception catch (e) {
        yield OPError(e.toString());
      }
    }
  }
}
