import 'package:dantotsu_line/helper/http_helper.dart';
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
import 'package:dantotsu_line/services/endpoints/app_endpoints.dart';

import '../../model/reason_transfer_problem/reason_trf_problem_responses.dart';

class AppAPI {
  //2
  Future<ConfigResponse> postConfigResponse(ConfigUpdate body) async {
    final response = await makePostRequest(
        await AppEndpoints.postConfig(), configUpdateToJson(body));

    return configResponseFromJson(response.body);
  }

  //3
  Future<UnreasonTrfProblem> fetchTransferProblem() async {
    final response =
        await makeGetRequest(await AppEndpoints.getTransferProblem());

    return unreasonTrfProblemFromJson(response.body);
  }

  //4
  Future<UnitResponse> fetchUnit() async {
    final response = await makeGetRequest(await AppEndpoints.getUnits());

    return unitResponseFromJson(response.body);
  }

  //5
  Future<UnitModelResponse> fetchModelPerUnit(int unitID) async {
    final response =
        await makeGetRequest(await AppEndpoints.getModelPerUnit(unitID));

    return unitModelResponseFromJson(response.body);
  }

  //6
  Future<ModelComponentResponse> fetchComponentPerModel(int modelID) async {
    final response =
        await makeGetRequest(await AppEndpoints.getComponentPerModel(modelID));
    return modelComponentResponseFromJson(response.body);
  }

  //7
  Future<ComponentRouteResponse> fetchRouteComponent(int componentID) async {
    final response = await makeGetRequest(
        await AppEndpoints.getRoutePerComponent(componentID));

    return componentRouteResponseFromJson(response.body);
  }

  //8
  Future<SerialNumberResponse> fetchSerialNumber(
      int componentID, int routeID) async {
    final response = await makeGetRequest(
        await AppEndpoints.getSerialNumber(componentID, routeID));

    return serialNumberResponseFromJson(response.body);
  }

  //9.1
  Future<ProblemResponse> fetchOptionProblem(int transferProblemID) async {
    final response = await makeGetRequest(
        await AppEndpoints.getOptionProblems(transferProblemID));

    return problemResponseFromJson(response.body);
  }

  //9.2
  Future<ProblemResponse> fetchProblemFromProcess(
      int transferComponentID) async {
    final response = await makeGetRequest(
        await AppEndpoints.getProblemFromProcess(transferComponentID));

    return problemResponseFromJson(response.body);
  }

  //10
  Future<TpFromAlarmResponse> postSetReasonForTP(
      ReasonTrfProblemBody body) async {
    final response = await makePostWithTokenRequest(
        await AppEndpoints.postSetReasonForProblem(),
        reasonTrfProblemBodyToJson(body));

    return tpFromAlarmResponseFromJson(response.body);
  }

  //11
  Future<DetailResponses> getDetailTP(int transferProblemID) async {
    final response = await makeGetRequest(
        await AppEndpoints.getDetailTransferProblem(transferProblemID));

    return detailResponsesFromJson(response.body);
  }

  //12
  Future<StopTpResponse> postStopTP(StopTrfProblemBody body) async {
    final response = await makePostWithTokenRequest(
        await AppEndpoints.postTransferProblemStop(),
        stopTrfProblemBodyToJson(body));

    return stopTpResponseFromJson(response.body);
  }

  //13
  Future<OngoingResponse> fetchOngoingTP() async {
    final response =
        await makeGetRequest(await AppEndpoints.getOngoingTransferProblem());

    return ongoingResponseFromJson(response.body);
  }

  //14
  Future<ManualResponse> postCreateManualTP(ManualBody body) async {
    final response = await makePostWithTokenRequest(
        await AppEndpoints.postProblemManual(), manualBodyToJson(body));

    return manualResponseFromJson(response.body);
  }

  /*UTD PROCESS */
  //15
  Future<UtdSerialNumber> getUTDSerialNumber(int componentID) async {
    final response = await makeGetRequest(
        await AppEndpoints.getUTDSerialNumber(componentID));

    return utdSerialNumberFromJson(response.body);
  }

  //16
  Future<UtdCheckpoint> getUTDCheckpoint(int componentRfidID) async {
    final response = await makeGetRequest(
        await AppEndpoints.getUTDCheckpoint(componentRfidID));

    return utdCheckpointFromJson(response.body);
  }

  //17
  Future<UtdResponse> fetchLogResultUTD(String month, String year) async {
    final response =
        await makeGetRequest(await AppEndpoints.getUTDLogResult(month, year));

    return utdResponseFromJson((response.body));
  }

  //18
  Future<InspectorCpResponses> postInspectorCP(InspectorCpBody body) async {
    final response = await makePostWithTokenRequest(
        await AppEndpoints.postCheckpointInspector(),
        inspectorCpBodyToJson(body));

    return inspectorCpResponsesFromJson(response.body);
  }

  //19
  Future<GroupLeaderCpResponse> postGroupLeaderCP(
      GroupLeaderCpBody body) async {
    final response = await makePostWithTokenRequest(
        await AppEndpoints.postCheckpointGroupLeader(),
        groupLeaderCpBodyToJson(body));

    return groupLeaderCpResponseFromJson(response.body);
  }
}
