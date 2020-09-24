import 'package:bloc/bloc.dart';
import 'package:dantotsu_line/bloc/utd_component/utd_component_event.dart';
import 'package:dantotsu_line/bloc/utd_component/utd_component_state.dart';
import 'package:dantotsu_line/model/unit/component/component_per_model.dart';
import 'package:dantotsu_line/services/repository/utd/app_repository.dart';

class UTDComponentBloc extends Bloc<UTDComponentEvent, UTDComponentState> {
  UTDComponentBloc(UTDComponentState initialState) : super(initialState);
  AppRepository _repository = AppRepository();

  UTDComponentState get initialState => ComponentUninitialized();

  @override
  Stream<UTDComponentState> mapEventToState(UTDComponentEvent event) async* {
    if (event is FetchUTDComponentProblem) {
      yield ComponentLoading();
      try {
        ModelComponentResponse response =
            await _repository.fetchComponent(event.modelID);

        if (response.result.toString().toUpperCase() == "SUCCESS") {
          if (response.data == null || response.data.toString() == "{}") {
            yield ComponentEmpty("No data. Try Again.");
          } else {
            yield ComponentLoaded(response);
          }
        } else if (response.result.toString().toLowerCase() == "error") {
          yield ComponentError(response.message);
        }
      } on Exception catch (e) {
        yield ComponentError(e.toString());
      }
    }
  }
}
