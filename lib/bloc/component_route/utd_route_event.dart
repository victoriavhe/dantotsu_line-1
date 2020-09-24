import 'package:equatable/equatable.dart';

abstract class RouteComponentEvent extends Equatable {}

class FetchRouteComponent extends RouteComponentEvent {
  final int componentID;

  FetchRouteComponent(this.componentID);

  @override
  List<Object> get props => throw UnimplementedError();
}
