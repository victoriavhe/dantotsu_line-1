import 'package:equatable/equatable.dart';

abstract class SNInspectorEvent extends Equatable {}

class FetchUTDSNInspector extends SNInspectorEvent {
  final int componentID;

  FetchUTDSNInspector(this.componentID);

  @override
  List<Object> get props => throw UnimplementedError();
}
