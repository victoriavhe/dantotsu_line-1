import 'package:equatable/equatable.dart';

abstract class UTDEvent extends Equatable {}

class FetchUTDProblem extends UTDEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class Logout extends UTDEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}