import 'package:dantotsu_line/model/config/config_body.dart';
import 'package:equatable/equatable.dart';

class AdminEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class PostDataConfig extends AdminEvent {
  final ConfigUpdate body;

  PostDataConfig(this.body);
}

class UpdateConfig extends AdminEvent {
  final ConfigUpdate body;

  UpdateConfig(this.body);
}
