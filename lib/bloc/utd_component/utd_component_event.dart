import 'package:equatable/equatable.dart';

abstract class UTDComponentEvent extends Equatable {}

class FetchUTDComponentProblem extends UTDComponentEvent {
  final int modelID;

  FetchUTDComponentProblem(this.modelID);

  @override
  List<Object> get props => throw UnimplementedError();
}
