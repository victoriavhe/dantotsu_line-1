import 'package:dantotsu_line/helper/http_helper.dart';
import 'package:dantotsu_line/model/problem/problem_response.dart';
import 'package:dantotsu_line/model/unit/component/component_per_model.dart';
import 'package:dantotsu_line/model/unit/model/model_per_unit.dart';
import 'package:dantotsu_line/model/unit/route/route_per_component.dart';
import 'package:dantotsu_line/model/unit/unit_response.dart';
import 'package:dantotsu_line/model/unreason_transfer_problem/unreason_transfer_problem.dart';
import 'package:dantotsu_line/model/utd/utd_response.dart';
import 'package:dantotsu_line/services/endpoints/utd/utd_endpoint.dart';

class UTDApi {
  Future<UnreasonTrfProblem> fetchUTD() async {
    final response = await makeGetRequest(await UTDEndpoints.getUTDEndpoint());

    return unreasonTrfProblemFromJson(response.body);
  }

  Future<UnitResponse> fetchUTDUnits() async {
    final response = await makeGetRequest(await UTDEndpoints.getUTDUnits());

    return unitResponseFromJson(response.body);
  }

  Future<ModelComponentResponse> fetchComponent(int id) async {
    final response =
        await makeGetRequest(await UTDEndpoints.getComponentEndpoint(id));
    return modelComponentResponseFromJson(response.body);
  }

  Future<ComponentRouteResponse> fetchRouteComponent(int id) async {
    final response = await makeGetRequest(await UTDEndpoints.getRouteComponent(id));

    return componentRouteResponseFromJson(response.body);
  }


  Future<UnitModelResponse> fetchModelUnit(int id) async {
    final response = await makeGetRequest(await UTDEndpoints.getUTDModel(id));

    return unitModelResponseFromJson(response.body);
  }

  Future<UtdResponse> fetchListOfUTD(String month, String year) async {
    final response =
        await makeGetRequest(await UTDEndpoints.getListOfUTD(month, year));

    return utdResponseFromJson((response.body));
  }
}
