import 'package:dantotsu_line/model/utd/inspector_checkpoint_body.dart';
import 'package:equatable/equatable.dart';

abstract class CPInspectorEvent extends Equatable {}

class PostCheckPointInspector extends CPInspectorEvent {
  final InspectorCpBody body;

  PostCheckPointInspector(this.body);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
