import 'package:bloc/bloc.dart';
import 'package:dantotsu_line/bloc/utd_model/utd_model_event.dart';
import 'package:dantotsu_line/bloc/utd_model/utd_model_state.dart';
import 'package:dantotsu_line/model/unit/model/model_per_unit.dart';
import 'package:dantotsu_line/services/repository/utd/app_repository.dart';

class UTDModelBloc extends Bloc<UTDModelEvent, UTDModelState> {
  UTDModelBloc(UTDModelState initialState) : super(initialState);
  AppRepository _utdRepository = AppRepository();

  UTDModelState get initialState => UTDModelUninitialized();

  @override
  Stream<UTDModelState> mapEventToState(UTDModelEvent event) async* {
    if (event is FetchUTDModel) {
      yield UTDModelLoading();
      try {
        UnitModelResponse response =
            await _utdRepository.fetchModelUnit(event.unitID);

        if (response.result.toString().toUpperCase() == "SUCCESS") {
          if (response.data == null) {
            yield UTDModelEmpty("No data. Try again.");
          } else {
            yield UTDModelLoaded(response);
          }
        } else {
          yield UTDModelError(response.message);
        }
      } on Exception catch (e) {
        yield UTDModelError(e.toString());
      }
    }
  }
}
