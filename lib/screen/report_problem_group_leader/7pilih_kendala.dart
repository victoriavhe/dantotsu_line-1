import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dantotsu_line/bloc/utd_option_problem/utd_option_problem_bloc.dart';
import 'package:dantotsu_line/bloc/utd_option_problem/utd_option_problem_event.dart';
import 'package:dantotsu_line/bloc/utd_option_problem/utd_option_problem_state.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/model/problem/problem_response.dart';
import 'package:dantotsu_line/model/reason_transfer_problem/reason_trf_problem_body.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/1Amasalah_berjalan.dart';
import 'package:dantotsu_line/util/widget.dart';
import 'package:dantotsu_line/widgets/app_dialog.dart';
import 'package:dantotsu_line/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/utd_option_problem/utd_option_problem_event.dart';
import '../../bloc/utd_option_problem/utd_option_problem_state.dart';
import '../../model/reason_transfer_problem/reason_trf_problem_body.dart';
import '../../model/transfer_problem/manual/manual_body.dart';
import '../../widgets/app_dialog.dart';
import '8status_repair.dart';

class PilihKendalaReportProblem extends StatefulWidget {
  final int transferProblemID;
  final String name;
  final LoginResponse userData;
  final bool isFromAlarm;
  final int transferComponentID;

  const PilihKendalaReportProblem(
      {Key key,
      this.transferProblemID,
      this.name,
      this.userData,
      this.isFromAlarm,
      this.transferComponentID})
      : super(key: key);

  @override
  _PilihKendalaReportProblemState createState() =>
      _PilihKendalaReportProblemState();
}

class _PilihKendalaReportProblemState extends State<PilihKendalaReportProblem> {
  OptionProblemBloc opBloc;
  ProblemResponse problemResponse;
  Problem _problem;
  LoginResponse userData;
  int processTPID;

  @override
  void initState() {
    userData = widget.userData;
    opBloc = OptionProblemBloc(OPUninitialized());
    _addBlocEvent();
    super.initState();
  }

  _addBlocEvent() {
    if (widget.isFromAlarm) {
      opBloc.add(FetchOptionsProblem(widget.transferProblemID));
    } else {
      opBloc.add(FetchProblemFromProcess(widget.transferComponentID));
    }
  }

  Widget buildInputProblem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          widget.isFromAlarm
              ? Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CachedNetworkImage(
                          height: 200,
                          imageUrl:
                              'https://www.fas.scot/wp-content/uploads/2018/02/RD-158-DANGER-TRIANGLE.png'),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "ANDA TELAH MELEBIHI WAKTU STANDART PROSES, PILIH KENDALA YANG DIHADAPI DENGAN SERIAL NUMBER ${widget.name}",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                )
              : RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "SN ",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                      children: [
                        TextSpan(
                          text: "${widget.name}",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w700,
                              color: Colors.red),
                        ),
                        TextSpan(
                          text: "\n PILIH OPSI MASALAH",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        )
                      ]),
                ),
          SizedBox(height: 50),
          BlocConsumer(
            bloc: opBloc,
            listener: (context, state) {
              if (state is DetailTransferLoaded) {
                var response = state.response;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StatusRepairReportProblem(
                      problemName: _problem.name,
                      processName: problemResponse.data.route.processName,
                      time: response.data.transferProblem.start,
                      serialNumber: problemResponse.data.serialNumber,
                      transferProblemId:
                          problemResponse.data.transferProblemId ?? null,
                      loginResponse: userData,
                      isFromAlarm: widget.isFromAlarm,
                      processTPID: processTPID ?? null,
                    ),
                  ),
                );
              } else if (state is OPError) {
                showAppDialog(context, state.message);
              } else if (state is OPEmpty || state is SetReasonTPEmpty) {
                showAppDialog(context, state.message);
              } else if (state is OPLoaded) {
                problemResponse = state.response;
              } else if (state is SetTPByProessLoaded) {
                processTPID = state.response.data.transferProblemId;
                showAppDialog(context, state.response.message, onTap: () {
                  Navigator.pop(context);
                  opBloc.add(FetchDetailTransfer(
                    state.response.data.transferProblemId,
                  ));
                }, buttonText: "OK");
              } else if (state is SetReasonTPLoaded) {
                showAppDialog(context, state.response.message, onTap: () {
                  Navigator.pop(context);
                  opBloc.add(FetchDetailTransfer(widget.transferProblemID));
                }, buttonText: "OK");
              }
            },
            builder: (context, state) {
              if (state is OPUninitialized || state is SetReasonTPInitial) {
                return Container();
              } else if (state is OPLoading || state is SetReasonTPLoading) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (state is OPLoaded) {
                return blocLoaded(state.response);
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget blocLoaded(ProblemResponse response) {
    return Expanded(
      child: GridView.count(
        childAspectRatio: 200 / 100,
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: response.data.problems
            .map(
              (item) => FlatButton(
                color: Colors.red[50],
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.red[800],
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  setState(() {
                    _problem = item;
                  });
                  showScreenDialog(context, item.name, response, item);
                },
                child: Text(
                  item.name.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appbarWithNav(context, userData.data.name, userData.data.jobdesk,
            userData.data.image,
            isLeader: true,
            response: userData
        ),
        body: TabBarView(
          children: [
            buildInputProblem(context),
            MasalahBerjalanReportProblem(
                response: userData, isFromAlarm: false),
          ],
        ),
      ),
    );
  }

  void showScreenDialog(BuildContext context, String problem,
      ProblemResponse response, Problem exactProblem) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(),
              child: Container(
                height: 300,
                width: 300,
                padding: EdgeInsets.all(18),
                color: Colors.red[50],
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 200,
                      child: TextWidget(
                        text:
                            "SN ${widget.name} pada proses ${response.data.route.processName} Mengalami $problem"
                                .toUpperCase(),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                              child: Container(
                                width: 100,
                                height: 50,
                                color: Colors.orange,
                                child: Center(child: Text("YA")),
                              ),
                              onTap: () {
                                _onClick(exactProblem);
                                Navigator.pop(context);
                              }),
                          SizedBox(
                            width: 30,
                          ),
                          InkWell(
                              child: Container(
                                width: 100,
                                height: 50,
                                color: Colors.orange,
                                child: Center(child: Text("TIDAK")),
                              ),
                              onTap: () => Navigator.pop(context)),
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  _onClick(Problem exactProblem) {
    if (widget.isFromAlarm) {
      opBloc.add(PostTPByAlarm(ReasonTrfProblemBody(
          problemId: exactProblem.id.toString(),
          transferProblemId: widget.transferProblemID.toString())));
    } else {
      opBloc.add(PostTPByProcess(
        ManualBody(
            problemId: exactProblem.id.toString(),
            transferComponentId: widget.transferComponentID.toString()),
      ));
    }
  }
}
