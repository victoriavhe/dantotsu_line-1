import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/1Amasalah_berjalan.dart';
import 'package:dantotsu_line/util/widget.dart';
import 'package:flutter/material.dart';

import '2unit_produksi.dart';

class OpsiMasalahReportProblem extends StatefulWidget {
  final LoginResponse loginResponse;
  final bool isMoreThanOne;

  const OpsiMasalahReportProblem(
      {Key key, this.loginResponse, this.isMoreThanOne})
      : super(key: key);

  @override
  _OpsiMasalahReportProblemState createState() =>
      _OpsiMasalahReportProblemState();
}

class _OpsiMasalahReportProblemState extends State<OpsiMasalahReportProblem> {
  PageController pageController = PageController(initialPage: 0);
  int pageChanged = 0;
  LoginResponse profile;

  @override
  initState() {
    profile = widget.loginResponse;
    super.initState();
  }

  Widget buildInputProblem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          "Pilih Opsi Masalah".toUpperCase(),
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  FlatButton(
                    color: widget.isMoreThanOne ? Colors.red : Colors.red[50],
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: widget.isMoreThanOne
                                ? Colors.red[800]
                                : Colors.red[50],
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UnitProduksiReportProblem(
                                    loginResponse: widget.loginResponse,
                                    isFromAlarm: true,
                                  )));
//                      pageController.animateToPage(0, duration: Duration(milliseconds: 150), curve: Curves.slowMiddle);
                    },
                    child: LimitedBox(
                      maxHeight: 250,
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Masalah dengan Alarm".toUpperCase(),
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                    color: Colors.red[50],
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.red[800],
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UnitProduksiReportProblem(
                                    loginResponse: widget.loginResponse,
                                    isFromAlarm: false,
                                  )));
                    },
                    child: LimitedBox(
                      maxHeight: 250,
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Masalah dengan Proses".toUpperCase(),
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget pageView() {
    return PageView(
      children: [
        buildInputProblem(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appbarWithNav(context, profile.data.name, profile.data.jobdesk,
            profile.data.image,
          isLeader: true,
          response: profile
        ),
        body: TabBarView(
          children: [
            pageView(),
            MasalahBerjalanReportProblem(
              response: profile,
              isFromAlarm: false,
            )
          ],
        ),
      ),
    );
  }
}
