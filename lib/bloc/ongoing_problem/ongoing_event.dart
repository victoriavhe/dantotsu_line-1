import 'package:equatable/equatable.dart';

abstract class OngoingEvent extends Equatable {}

class FetchOngoingProblem extends OngoingEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}
