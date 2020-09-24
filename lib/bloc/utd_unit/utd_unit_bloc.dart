import 'package:bloc/bloc.dart';
import 'package:dantotsu_line/bloc/utd_unit/utd_unit_event.dart';
import 'package:dantotsu_line/bloc/utd_unit/utd_unit_state.dart';
import 'package:dantotsu_line/model/authentication/logout_response.dart';
import 'package:dantotsu_line/model/unit/unit_response.dart';
import 'package:dantotsu_line/services/repository/auth/auth_repository.dart';
import 'package:dantotsu_line/services/repository/utd/app_repository.dart';

class UTDUnitsBloc extends Bloc<UTDUnitsEvent, UTDUnitsState> {
  AppRepository _utdRepository = AppRepository();
  AuthRepository _authRepository = AuthRepository();

  UTDUnitsBloc(UTDUnitsState initialState) : super(initialState);

  UTDUnitsState get initialState => UTDUnitUninitialized();

  @override
  Stream<UTDUnitsState> mapEventToState(UTDUnitsEvent event) async* {
    if (event is FetchUTDUnitsProblem) {
      yield UTDUnitLoading();
      try {
        yield UTDUnitLoading();
        UnitResponse response = await _utdRepository.fetchUTDUnits();

        print(response.result.toString());
        if (response.result.toString().toUpperCase() == "SUCCESS") {
          if (response.data == null) {
            yield UTDUnitEmpty("No data. Try again.");
          } else {
            yield UTDUnitLoaded(response);
          }
        } else {
          yield UTDUnitError(response.message);
        }
      } on Exception catch (e) {
        yield UTDUnitError(e.toString());
      }
    } else if (event is Logout) {
      yield UTDUnitLoading();
      try {
        LogoutResponse response = await _authRepository.doLogout();

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
