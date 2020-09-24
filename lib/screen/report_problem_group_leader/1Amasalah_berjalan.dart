import 'package:dantotsu_line/bloc/ongoing_problem/ongoing_bloc.dart';
import 'package:dantotsu_line/bloc/ongoing_problem/ongoing_event.dart';
import 'package:dantotsu_line/bloc/ongoing_problem/ongoing_state.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/model/transfer_problem/ongoing/ongoing_response.dart';
import 'package:dantotsu_line/widgets/app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '8status_repair.dart';

class MasalahBerjalanReportProblem extends StatefulWidget {
  final LoginResponse response;
  final bool isFromAlarm;

  const MasalahBerjalanReportProblem({Key key, this.response, this.isFromAlarm})
      : super(key: key);

  @override
  _MasalahBerjalanReportProblemState createState() =>
      _MasalahBerjalanReportProblemState();
}

class _MasalahBerjalanReportProblemState
    extends State<MasalahBerjalanReportProblem> {
  OngoingBloc ongoingBloc;

  @override
  void initState() {
    ongoingBloc = OngoingBloc(OngoingUninitialized());
    ongoingBloc.add(FetchOngoingProblem());
    super.initState();
  }

  DataTable dataBody(OngoingResponse response) {
    return DataTable(
      dataRowHeight: 65,
      showCheckboxColumn: false,
      dividerThickness: 1,
      sortAscending: false,
      sortColumnIndex: 1,
      columnSpacing: 18.5,
      columns: [
        DataColumn(
            label: Expanded(
              child: Text(
                "Komponen",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
            numeric: false,
            tooltip: "Tipe Masalah"),
        DataColumn(
            label: Expanded(
              child: Text(
                "SN",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
            numeric: false,
            tooltip: "Serial Number"),
        DataColumn(
            label: Expanded(
              child: Text(
                "Lokasi",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
            numeric: false,
            tooltip: "Lokasi"),
        DataColumn(
            label: Expanded(
              child: Text(
                "Masalah",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
            numeric: false,
            tooltip: "Masalah"),
        DataColumn(
            label: Expanded(
              child: Text(
                "Waktu Mulai",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
            numeric: false,
            tooltip: "Waktu")
      ],
      rows: response.data.transferProblems
          .map(
            (data) => DataRow(
              onSelectChanged: (bool selected) {
                if (selected) {
                  print('Selected ${data.problemName}');

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatusRepairReportProblem(
                        time: data.start,
                        transferProblemId: data.id.toString(),
                        processName: data.processName,
                        problemName: data.problemName,
                        serialNumber: data.serialNumber,
                        loginResponse: widget.response,
                        isFromAlarm: widget.isFromAlarm,
                        processTPID: data.id,
                        fromOngoing: true,
                      ),
                    ),
                  );
                }
              },
              cells: [
                DataCell(
                  Text(
                    data.componentName ?? "",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                ),
                DataCell(
                  Text(
                        data.serialNumber,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ) ??
                      "",
                ),
                DataCell(
                  Text(
                    data.processName,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 17),
                  ) ??
                      "",
                ),
                DataCell(
                  Container(
                    width: 150,
                    child: Text(
                      data.problemName ?? "",
                      overflow: data.problemName != null &&
                              data.problemName.length > 20
                          ? TextOverflow.ellipsis
                          : TextOverflow.clip,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                DataCell(
                  Text(
                        data.start,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ) ??
                      "",
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  "MASALAH YANG BERJALAN",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: BlocConsumer<OngoingBloc, OngoingState>(
                    bloc: ongoingBloc,
                    listener: (context, state) {
                      if (state is OngoingError) {
                        showAppDialog(context, state.message);
                      } else if (state is OngoingEmpty) {
                        showAppDialog(context, state.message);
                      }
                    },
                    builder: (context, state) {
                      if (state is OngoingUninitialized) {
                        return Container();
                      } else if (state is OngoingLoading) {
                        return Center(
                          child: CupertinoActivityIndicator(),
                        );
                      } else if (state is OngoingLoaded) {
                        return dataBody(state.response);
                      }

                      return Container();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
