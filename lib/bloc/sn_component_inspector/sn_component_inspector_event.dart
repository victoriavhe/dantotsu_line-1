import 'package:equatable/equatable.dart';

abstract class SNComponentInspectorEvent extends Equatable {}

class FetchSNComponent extends SNComponentInspectorEvent {
  final int componentRfidID;

  FetchSNComponent(this.componentRfidID);

  @override
  List<Object> get props => throw UnimplementedError();
}
