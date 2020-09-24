import 'package:dantotsu_line/model/config/config_response.dart';
import 'package:equatable/equatable.dart';

class AdminState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminLoaded extends AdminState {
  final ConfigResponse response;

  AdminLoaded(this.response);
}

class AdminEmpty extends AdminState {
  final String message;

  AdminEmpty(this.message);
}

class AdminError extends AdminState {
  final String message;

  AdminError(this.message);
}
