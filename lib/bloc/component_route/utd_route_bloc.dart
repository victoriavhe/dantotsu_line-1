import 'package:bloc/bloc.dart';
import 'package:dantotsu_line/bloc/component_route/utd_route_event.dart';
import 'package:dantotsu_line/bloc/component_route/utd_route_state.dart';
import 'package:dantotsu_line/model/unit/route/route_per_component.dart';
import 'package:dantotsu_line/services/repository/utd/app_repository.dart';

class RouteComponentBloc
    extends Bloc<RouteComponentEvent, RouteComponentState> {
  RouteComponentBloc(RouteComponentState initialState) : super(initialState);
  AppRepository _repository = AppRepository();

  RouteComponentState get initialState => RouteUninitialized();

  @override
  Stream<RouteComponentState> mapEventToState(
      RouteComponentEvent event) async* {
    if (event is FetchRouteComponent) {
      yield RouteLoading();
      try {
        ComponentRouteResponse response =
            await _repository.fetchRouteComponent(event.componentID);

        if (response.result.toString().toUpperCase() == "SUCCESS") {
          if (response.data == null) {
            yield RouteEmpty("Data is Empty. Try Again.");
          } else {
            yield RouteLoaded(response);
          }
        } else {
          yield RouteError(response.message);
        }
      } on Exception catch (e) {
        yield RouteError(e.toString());
      }
    }
  }
}
