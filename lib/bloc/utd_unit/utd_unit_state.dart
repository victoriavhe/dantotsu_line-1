import 'package:dantotsu_line/model/unit/unit_response.dart';

abstract class UTDUnitsState {}

class UTDUnitUninitialized extends UTDUnitsState {

}

class UTDUnitLoading extends UTDUnitsState {

  String toString() => 'unitLoading';
}

class UTDUnitLoaded extends UTDUnitsState {
  final UnitResponse unitResponse;

  UTDUnitLoaded(this.unitResponse);

  String toString() => 'unitLoaded';
}

class UTDUnitEmpty extends UTDUnitsState {
  final String message;

  UTDUnitEmpty(this.message);
}

class UTDUnitError extends UTDUnitsState {
  final String message;

  UTDUnitError(this.message);

  String toString() => 'unitError';
}

class LogoutSuccess extends UTDUnitsState {
  final String message;

  LogoutSuccess(this.message);
}

class LogoutFailed extends UTDUnitsState {
  final String message;

  LogoutFailed(this.message);
}
