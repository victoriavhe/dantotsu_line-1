import 'package:dantotsu_line/model/config/config_body.dart';
import 'package:dantotsu_line/model/config/config_response.dart';
import 'package:dantotsu_line/model/problem/problem_response.dart';
import 'package:dantotsu_line/model/reason_transfer_problem/reason_trf_problem_body.dart';
import 'package:dantotsu_line/model/reason_transfer_problem/reason_trf_problem_responses.dart';
import 'package:dantotsu_line/model/transfer_problem/detail_responses.dart';
import 'package:dantotsu_line/model/transfer_problem/manual/manual_body.dart';
import 'package:dantotsu_line/model/transfer_problem/manual/manual_response.dart';
import 'package:dantotsu_line/model/transfer_problem/ongoing/ongoing_response.dart';
import 'package:dantotsu_line/model/transfer_problem/stop/stop_trf_problem_body.dart';
import 'package:dantotsu_line/model/transfer_problem/stop/stop_trf_problem_response.dart';
import 'package:dantotsu_line/model/unit/component/component_per_model.dart';
import 'package:dantotsu_line/model/unit/model/model_per_unit.dart';
import 'package:dantotsu_line/model/unit/route/route_per_component.dart';
import 'package:dantotsu_line/model/unit/serial_number/serial_number.dart';
import 'package:dantotsu_line/model/unit/unit_response.dart';
import 'package:dantotsu_line/model/unreason_transfer_problem/unreason_transfer_problem.dart';
import 'package:dantotsu_line/model/utd/group_leader_checkpoint_body.dart';
import 'package:dantotsu_line/model/utd/group_leader_checkpoint_response.dart';
import 'package:dantotsu_line/model/utd/inspector_checkpoint_body.dart';
import 'package:dantotsu_line/model/utd/inspector_checkpoint_response.dart';
import 'package:dantotsu_line/model/utd/utd_checkpoint.dart';
import 'package:dantotsu_line/model/utd/utd_response.dart';
import 'package:dantotsu_line/model/utd/utd_serial_numbers.dart';
import 'package:dantotsu_line/services/api/app_api.dart';
import 'package:dantotsu_line/services/api/utd/utd_api.dart';

import '../../../model/reason_transfer_problem/reason_trf_problem_responses.dart';

class AppRepository {
  final UTDApi _utdApi = UTDApi();
  final AppAPI _appAPI = AppAPI();

  Future<UnreasonTrfProblem> fetchUTD() => _utdApi.fetchUTD();

  Future<UtdResponse> fetchListOfUTD(String month, String year) =>
      _utdApi.fetchListOfUTD(month, year);

  Future<UnitResponse> fetchUTDUnits() => _utdApi.fetchUTDUnits();

  Future<ModelComponentResponse> fetchComponent(int id) =>
      _utdApi.fetchComponent(id);

  Future<ComponentRouteResponse> fetchRouteComponent(int id) =>
      _utdApi.fetchRouteComponent(id);

  //2
  Future<ConfigResponse> postConfigUpdate(ConfigUpdate body) =>
      _appAPI.postConfigResponse(body);

  Future<SerialNumberResponse> fetchSerialNumber(
          int componentID, int routeID) =>
      _appAPI.fetchSerialNumber(componentID, routeID);

  //9.1
  Future<ProblemResponse> fetchOptionsProblem(int id) =>
      _appAPI.fetchOptionProblem(id);

  //9.2
  Future<ProblemResponse> fetchProblemFromProcess(int transferComponentID) =>
      _appAPI.fetchProblemFromProcess(transferComponentID);

  Future<UnitModelResponse> fetchModelUnit(int id) =>
      _utdApi.fetchModelUnit(id);

  //10
  Future<TpFromAlarmResponse> postSetReasonTP(ReasonTrfProblemBody body) =>
      _appAPI.postSetReasonForTP(body);

  //11
  Future<DetailResponses> getDetailResponse(int transferProblemID) =>
      _appAPI.getDetailTP(transferProblemID);

  //12
  Future<StopTpResponse> postStopTP(StopTrfProblemBody body) =>
      _appAPI.postStopTP(body);

  //13
  Future<OngoingResponse> fetchOngoingTP() => _appAPI.fetchOngoingTP();

  //14
  Future<ManualResponse> postTPByProcess(ManualBody body) =>
      _appAPI.postCreateManualTP(body);

  //15
  Future<UtdSerialNumber> fetchSNInspector(int componentID) =>
      _appAPI.getUTDSerialNumber(componentID);

  //16
  Future<UtdCheckpoint> fetchSNComponent(int componentRfidID) =>
      _appAPI.getUTDCheckpoint(componentRfidID);

  //18
  Future<InspectorCpResponses> postCheckpointInspector(InspectorCpBody body) =>
      _appAPI.postInspectorCP(body);

  //19
  Future<GroupLeaderCpResponse> postCheckpointGroupLeader(
          GroupLeaderCpBody body) =>
      _appAPI.postGroupLeaderCP(body);
}
