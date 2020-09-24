import 'package:bloc/bloc.dart';
import 'package:dantotsu_line/bloc/admin/admin_event.dart';
import 'package:dantotsu_line/bloc/admin/admin_state.dart';
import 'package:dantotsu_line/model/config/config_response.dart';
import 'package:dantotsu_line/services/repository/utd/app_repository.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc(AdminState initialState) : super(initialState);
  AppRepository appRepository = AppRepository();

  @override
  Stream<AdminState> mapEventToState(AdminEvent event) async* {
    if (event is PostDataConfig) {
      try {
        yield AdminLoading();
        ConfigResponse response =
            await appRepository.postConfigUpdate(event.body);
        if (response.result.toLowerCase() == "success") {
          if (response.data != null || response.data.toString() != "{}") {
            yield AdminLoaded(response);
          } else {
            yield AdminEmpty("Data is Empty");
          }
        } else if (response.result.toLowerCase() == "error") {
          yield AdminError(response.message);
        }
      } on Exception catch (e) {
        yield AdminError(e.toString());
      }
    }
  }
}
