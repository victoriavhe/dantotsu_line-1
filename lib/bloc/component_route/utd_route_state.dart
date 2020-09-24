import 'package:dantotsu_line/model/unit/route/route_per_component.dart';
import 'package:equatable/equatable.dart';

abstract class RouteComponentState extends Equatable {}

class RouteUninitialized extends RouteComponentState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RouteLoading extends RouteComponentState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RouteLoaded extends RouteComponentState {
  final ComponentRouteResponse routeResponse;

  RouteLoaded(this.routeResponse);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RouteEmpty extends RouteComponentState {
  final String message;

  RouteEmpty(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RouteError extends RouteComponentState {
  final String message;

  RouteError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
