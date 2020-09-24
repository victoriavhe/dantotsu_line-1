import 'package:dantotsu_line/common/colors.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/screen/flow_utd_inspector/0unit_produksi.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/0dashboard.dart';
import 'package:dantotsu_line/widgets/profile_image.dart';
import 'package:flutter/material.dart';

Widget appbarWithNav(
    BuildContext context, String name, String jobdesk, String imageUrl,
    {bool isLeader, LoginResponse response}) {
  return AppBar(
    backgroundColor: AppColors.primaryColor,
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          child: Icon(
            Icons.home,
            size: 65,
            color: Colors.white,
          ),
          onTap: isLeader
              ? () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DashboardReportProblem(response)),
                    (Route<dynamic> route) => false,
                  )
              : () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UnitProduksiInspector(loginResponse: response)),
                    (Route<dynamic> route) => false,
                  ),
        ),
        ProfileImage(
          imageUrl: imageUrl,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(name ?? "", style: TextStyle(fontSize: 15)),
            Text(jobdesk ?? "", style: TextStyle(fontSize: 15)),
          ],
        )
      ],
    ),
    bottom: TabBar(
        labelStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        tabs: [
          Tab(text: "Masalah Input"),
          Tab(text: "Masalah Berlangsung"),
        ]),
  );
}

Widget appbarWithoutBottomNav(
    BuildContext context, String name, String jobdesk, String imageUrl,
    {bool isLeader, LoginResponse response}) {
  return AppBar(
    backgroundColor: AppColors.primaryColor,
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          child: Icon(
            Icons.home,
            size: 65,
            color: Colors.white,
          ),
          onTap: isLeader
              ? () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DashboardReportProblem(response)),
                    (Route<dynamic> route) => false,
                  )
              : () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UnitProduksiInspector(loginResponse: response)),
                    (Route<dynamic> route) => false,
                  ),
        ),
        ProfileImage(
          imageUrl: imageUrl,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(name ?? "", style: TextStyle(fontSize: 15)),
            Text(jobdesk ?? "", style: TextStyle(fontSize: 15)),
          ],
        )
      ],
    ),
  );
}
