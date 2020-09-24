import 'package:bloc/bloc.dart';
import 'package:dantotsu_line/bloc/utd_list/utd_list_event.dart';
import 'package:dantotsu_line/bloc/utd_list/utd_list_state.dart';
import 'package:dantotsu_line/model/utd/utd_response.dart';
import 'package:dantotsu_line/services/repository/utd/app_repository.dart';

class UTDListBloc extends Bloc<UTDListEvent, UTDListState> {
  UTDListBloc(UTDListState initialState) : super(initialState);

  UTDListState get initialState => UTDListInitial();
  AppRepository _repository = AppRepository();

  @override
  Stream<UTDListState> mapEventToState(UTDListEvent event) async* {
    try {
      if (event is FetchUTDLIst) {
        yield UTDListLoading();

        UtdResponse response =
            await _repository.fetchListOfUTD(event.month, event.year);
        if (response.result.toString().toUpperCase() == "SUCCESS") {
          if (response.data == null) {
            yield UTDListEmpty("No data. Try again.");
          } else {
            yield UTDListLoaded(response);
          }
        } else if (response.result.toLowerCase() == "error") {
          yield UTDListError(response.message);
        }
      }
    } on Exception catch (_) {
      yield UTDListError("Server Error");
    }
  }
}
