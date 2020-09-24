import 'package:dantotsu_line/services/url_base.dart';

class AppEndpoints {
  //2
  static Future<String> postConfig() async {
    return "${await baseUrl()}"
        '/config/update';
  }

  /* TRANSFER PROBLEM ENDPOINTS*/

  //3
  static Future<String> getTransferProblem() async {
    return "${await baseUrl()}"
        '/transfer-problem/unreason';
  }

  //4
  static Future<String> getUnits() async {
    return "${await baseUrl()}"
        '/unit';
  }

  //5
  static Future<String> getModelPerUnit(int unitID) async {
    return "${await baseUrl()}"
        '/model/unitId/'
        '$unitID';
  }

  //6
  static Future<String> getComponentPerModel(int modelID) async {
    return "${await baseUrl()}"
        '/component/modelId/'
        '$modelID';
  }

  //7
  static Future<String> getRoutePerComponent(int componentID) async {
    return "${await baseUrl()}"
        '/route/componentId/'
        '$componentID';
  }

  //8
  static Future<String> getSerialNumber(int componentID, int routeID) async {
    return "${await baseUrl()}"
        '/serial-number/componentId/'
        '$componentID/'
        'routeId/'
        '$routeID';
  }

  //9.1
  static Future<String> getOptionProblems(int transferProblemID) async {
    return "${await baseUrl()}"
        '/problem/list/transferProblemId/'
        '$transferProblemID';
  }

  //9.2
  static Future<String> getProblemFromProcess(int transferComponentID) async {
    return "${await baseUrl()}"
        '/problem/list/transferComponentId/'
        '$transferComponentID';
  }

  //10
  static Future<String> postSetReasonForProblem() async {
    return "${await baseUrl()}"
        '/transfer-problem/set-reason';
  }

  //11
  static Future<String> getDetailTransferProblem(int transferProblemID) async {
    return "${await baseUrl()}"
        '/transfer-problem/detail/transferProblemId/$transferProblemID';
  }

  //12
  static Future<String> postTransferProblemStop() async {
    return "${await baseUrl()}"
        '/transfer-problem/stop';
  }

  /*Closing of TransferProblem Endpoints*/

  //13
  static Future<String> getOngoingTransferProblem() async {
    return "${await baseUrl()}"
        '/transfer-problem/ongoing';
  }

  //14
  static Future<String> postProblemManual() async {
    return "${await baseUrl()}"
        '/transfer-problem/create';
  }

  /*UTD PROCESS*/

  //15 - Get On Process Serial Number a Component in UTD Process
  static Future<String> getUTDSerialNumber(int componentID) async {
    return "${await baseUrl()}"
        '/utd/serial-number/componentId/$componentID';
  }

  //16
  static Future<String> getUTDCheckpoint(int componentRfidID) async {
    return "${await baseUrl()}"
        '/utd/checkpoint/componentRfidId/$componentRfidID';
  }

  //17
  static Future<String> getUTDLogResult(String month, String year) async {
    //MM - YYYY

    return "${await baseUrl()}"
        '/utd/result/month/$month/year/$year';
  }

  //18
  static Future<String> postCheckpointInspector() async {
    return "${await baseUrl()}"
        '/utd/checkpoint/inspector';
  }

  //19
  static Future<String> postCheckpointGroupLeader() async {
    return "${await baseUrl()}"
        '/utd/checkpoint/groupleader';
  }
}
