import 'package:dantotsu_line/services/url_base.dart';

class UTDEndpoints {
  static Future<String> getUTDEndpoint() async {
    return "${await baseUrl()}"
        '/transfer-problem/unreason';
  }

  static Future<String> getComponentEndpoint(int id) async {
    return "${await baseUrl()}"
        '/component/modelId/'
        '$id';
  }

  static Future<String> getRouteComponent(int id) async {
    return "${await baseUrl()}"
        '/route/componentId/'
        '$id';
  }

  static Future<String> getListOfUTD(String month, String year) async {
    return "${await baseUrl()}"
        '/utd/result/month/'
        '$month/'
        'year/'
        '$year';
  }

  static Future<String> getUTDUnits() async {
    return "${await baseUrl()}"
        '/unit';
  }

  static Future<String> getUTDModel(int unitID) async {
    return "${await baseUrl()}"
        '/model/unitId/'
        '$unitID';
  }

}
