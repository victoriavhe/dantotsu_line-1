import 'package:dantotsu_line/model/utd/utd_response.dart';
import 'package:equatable/equatable.dart';

abstract class UTDListState extends Equatable {}

class UTDListInitial extends UTDListState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UTDListLoading extends UTDListState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UTDListLoaded extends UTDListState {
  final UtdResponse response;

  UTDListLoaded(this.response);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UTDListEmpty extends UTDListState {
  final String message;

  UTDListEmpty(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UTDListError extends UTDListState {
  final String message;

  UTDListError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
