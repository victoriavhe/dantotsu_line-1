import 'package:dantotsu_line/bloc/utd_unit/utd_unit_bloc.dart';
import 'package:dantotsu_line/bloc/utd_unit/utd_unit_event.dart';
import 'package:dantotsu_line/bloc/utd_unit/utd_unit_state.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/model/unit/unit_response.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/1Amasalah_berjalan.dart';
import 'package:dantotsu_line/util/widget.dart';
import 'package:dantotsu_line/widgets/app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '3tipe_model.dart';

class UnitProduksiReportProblem extends StatefulWidget {
  final LoginResponse loginResponse;
  final bool isFromAlarm;

  const UnitProduksiReportProblem(
      {Key key, this.loginResponse, this.isFromAlarm})
      : super(key: key);

  @override
  _UnitProduksiReportProblemState createState() =>
      _UnitProduksiReportProblemState();
}

class _UnitProduksiReportProblemState extends State<UnitProduksiReportProblem> {
  UTDUnitsBloc utdUnitsBloc;
  LoginResponse profile;

  @override
  void initState() {
    profile = widget.loginResponse;
    utdUnitsBloc = UTDUnitsBloc(UTDUnitUninitialized());
    utdUnitsBloc.add(FetchUTDUnitsProblem());
    super.initState();
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
            buildInputProblem(),
            MasalahBerjalanReportProblem(response: profile, isFromAlarm: false),
          ],
        ),
      ),
    );
  }

  Widget buildInputProblem() {
    return BlocConsumer<UTDUnitsBloc, UTDUnitsState>(
      bloc: utdUnitsBloc,
      listener: (context, state) {
        if (state is UTDUnitError) {
          showAppDialog(context, state.message);
        } else if (state is UTDUnitEmpty) {
          showAppDialog(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is UTDUnitUninitialized) {
          return Container();
        } else if (state is UTDUnitLoading) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is UTDUnitLoaded) {
          var listOfUnit = state.unitResponse;
          return blocLoaded(listOfUnit);
        }

        return Container();
      },
    );
  }

  Widget blocLoaded(UnitResponse response) {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          child: Text(
            "Pilih Unit Produksi".toUpperCase(),
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: GridView.count(
            childAspectRatio: 200 / 100,
            crossAxisCount: 2,
            padding: EdgeInsets.all(20),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: response.data.units
                .map(
                  (item) => FlatButton(
                    color: widget.isFromAlarm && item.totalProblem > 0
                        ? Colors.red
                        : Colors.red[50],
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
                              builder: (context) => TipeModelReportPrbolem(
                                    profile: profile,
                                    unitID: item.id,
                                    isFromAlarm: widget.isFromAlarm,
                                  )));
                    },
                    child: Center(
                      child: Text(
                        item.name.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 37),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
