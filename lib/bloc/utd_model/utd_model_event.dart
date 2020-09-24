import 'package:equatable/equatable.dart';

abstract class UTDModelEvent extends Equatable {}

class FetchUTDModel extends UTDModelEvent {
  final int unitID;

  FetchUTDModel(this.unitID);

  @override
  List<Object> get props => throw UnimplementedError();
}