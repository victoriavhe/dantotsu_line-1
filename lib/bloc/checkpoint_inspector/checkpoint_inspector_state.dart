import 'package:dantotsu_line/model/utd/inspector_checkpoint_response.dart';
import 'package:equatable/equatable.dart';

abstract class CPInspectorState extends Equatable {}

class CPIUnintiallized extends CPInspectorState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CPILoading extends CPInspectorState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CPILoaded extends CPInspectorState {
  final InspectorCpResponses responses;

  CPILoaded(this.responses);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CPIEmpty extends CPInspectorState {
  final String message;

  CPIEmpty(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CPIError extends CPInspectorState {
  final String message;

  CPIError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
