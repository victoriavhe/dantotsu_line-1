import 'package:equatable/equatable.dart';

abstract class UTDListEvent extends Equatable {}

class FetchUTDLIst extends UTDListEvent {
  final String month, year;

  FetchUTDLIst(this.month, this.year);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
