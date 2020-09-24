import 'package:bloc/bloc.dart';
import 'package:dantotsu_line/bloc/utd_problem/utd_event.dart';
import 'package:dantotsu_line/bloc/utd_problem/utd_state.dart';
import 'package:dantotsu_line/model/authentication/logout_response.dart';
import 'package:dantotsu_line/model/unreason_transfer_problem/unreason_transfer_problem.dart';
import 'package:dantotsu_line/services/repository/auth/auth_repository.dart';
import 'package:dantotsu_line/services/repository/utd/app_repository.dart';

class UTDBloc extends Bloc<UTDEvent, UTDState> {
  UTDBloc(UTDState initialState) : super(initialState);
  AppRepository _utdRepository = AppRepository();
  AuthRepository authRepository = AuthRepository();

  UTDState get initialState => UTDUninitialized();

  @override
  Stream<UTDState> mapEventToState(UTDEvent event) async* {
    if (event is FetchUTDProblem) {
      yield UTDLoading();
      try {
        UnreasonTrfProblem response = await _utdRepository.fetchUTD();

        if (response.result.toString().toUpperCase() == "SUCCESS") {
          if (response.data == null) {
            yield UTDEmpty("No data. Try again");
          } else {
            yield UTDLoaded(response);
          }
        } else {
          yield UTDError(response.message);
        }
      } on Exception catch (e) {
        yield UTDError(e.toString());
      }
    } else if (event is Logout) {
      yield UTDLoading();
      try {
        LogoutResponse response = await authRepository.doLogout();

        if (response.result.toLowerCase() == "success") {
          yield LogoutSuccess(response.message);
        } else {
          yield LogoutFailed(response.message);
        }
      } on Exception catch (e) {
        yield LogoutFailed(e.toString());
      }
    }
  }
}
