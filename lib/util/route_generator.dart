import 'package:dantotsu_line/screen/flow_admin/0dashboard.dart';
import 'package:dantotsu_line/screen/flow_utd_group_leader/1log_pengecekan.dart';
import 'package:dantotsu_line/screen/flow_utd_inspector/0unit_produksi.dart';
import 'package:dantotsu_line/screen/flow_utd_inspector/1tipe_model.dart';
import 'package:dantotsu_line/screen/flow_utd_inspector/2pilih_component.dart';
import 'package:dantotsu_line/screen/flow_utd_inspector/3serial_number.dart';
import 'package:dantotsu_line/screen/flow_utd_inspector/4inspection_reject_checking.dart';
import 'package:dantotsu_line/screen/login_screen.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/1Amasalah_berjalan.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/1opsi_masalah.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/2unit_produksi.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/3tipe_model.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/4opsi_komponen.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/5jenis_tipe.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/6serial_number.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/7pilih_kendala.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/8status_repair.dart';
import 'package:dantotsu_line/screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Mendapat argument yang dikirimkan ketika memanggil Navigatior.pushNamed
    // final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => SplashScreen());
      // case '/dashboard':
      //   // Validasi apakah tipe data benar
      //   if (args is String) {
      //     return CupertinoPageRoute(
      //       builder: (_) => Dashboard(dataDashboard: args),
      //     );
      //   }
      //   return _errorRoute();
      case '/login':
        return CupertinoPageRoute(builder: (_) => LoginScreen());
//      case '/dashboard_report_problem':
//        return CupertinoPageRoute(builder: (_) => DashboardReportProblem());
      case '/opsimasalah_report_problem':
        return CupertinoPageRoute(builder: (_) => OpsiMasalahReportProblem());
      case '/unitproduksi_report_problem':
        return CupertinoPageRoute(builder: (_) => UnitProduksiReportProblem());
      case '/tipemodel_report_problem':
        return CupertinoPageRoute(builder: (_) => TipeModelReportPrbolem());
      case '/opsikomponen_report_problem':
        return CupertinoPageRoute(builder: (_) => OpsiKomponenReportProblem());
      case '/jenistipe_report_problem':
        return CupertinoPageRoute(builder: (_) => JenisTipeReportProblem());
      case '/serialnumber_report_problem':
        return CupertinoPageRoute(builder: (_) => SerialNumberReportProblem());
      case '/pilihkendala_report_problem':
        return CupertinoPageRoute(builder: (_) => PilihKendalaReportProblem());
      case '/statusrepair_report_problem':
        return CupertinoPageRoute(builder: (_) => StatusRepairReportProblem());
      case '/masalahberjalan_report_problem':
        return CupertinoPageRoute(
            builder: (_) => MasalahBerjalanReportProblem());
      case '/loghasilpengecekan':
        return CupertinoPageRoute(builder: (_) => LogHasilPengecekan());
      case '/dashboardadmin':
        return CupertinoPageRoute(builder: (_) => DashboardAdmin());
      case '/unitproduksi_inspector':
        return CupertinoPageRoute(builder: (_) => UnitProduksiInspector());
      case '/tipemodel_inspector':
        return CupertinoPageRoute(builder: (_) => TipeModelInspector());
      case '/pilihkomponen_inspector':
        return CupertinoPageRoute(builder: (_) => PilihKomponenInspector());
      case '/serialnumber_inspector':
        return CupertinoPageRoute(builder: (_) => SerialNumberInspector());
      case '/inspectionrejectchecking_inspector':
        return CupertinoPageRoute(
            builder: (_) => InspectionRejectCheckingInspector());
      // case '/detailPerson':
      //   return MaterialPageRoute(
      //       builder: (_) => DetailPerson(
      //             arguments: settings.arguments,
      //           ));
      // case '/edit_profile':
      //   return CupertinoPageRoute(builder: (_) => EditProfile());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR PAGE'),
        ),
      );
    });
  }
}
