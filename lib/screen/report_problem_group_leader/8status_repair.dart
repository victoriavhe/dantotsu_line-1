import 'dart:async';

import 'package:dantotsu_line/bloc/11_detail_transfer_info/detail_trf_bloc.dart';
import 'package:dantotsu_line/bloc/11_detail_transfer_info/detail_trf_event.dart';
import 'package:dantotsu_line/bloc/11_detail_transfer_info/detail_trf_state.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/model/transfer_problem/stop/stop_trf_problem_body.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/1Amasalah_berjalan.dart';
import 'package:dantotsu_line/util/widget.dart';
import 'package:dantotsu_line/widgets/app_dialog.dart';
import 'package:dantotsu_line/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '0dashboard.dart';

class StatusRepairReportProblem extends StatefulWidget {
  final LoginResponse loginResponse;
  final String time;
  final String processName;
  final String problemName;
  final String serialNumber;
  final String transferProblemId;
  final bool isFromAlarm;
  final int processTPID;
  final bool fromOngoing;

  const StatusRepairReportProblem(
      {Key key,
      this.time,
      this.processName,
      this.problemName,
      this.serialNumber,
      this.transferProblemId,
      this.loginResponse,
      this.isFromAlarm,
      this.processTPID,
      this.fromOngoing: false})
      : super(key: key);

  @override
  _StatusRepairReportProblemState createState() =>
      _StatusRepairReportProblemState();
}

class _StatusRepairReportProblemState extends State<StatusRepairReportProblem> {
  LoginResponse userData;
  DetailTransferBloc _detailTransferBloc;
  int _hour = 0, _minute = 0, _second = 0;
  bool isUpdated = false;
  bool updateSec = false;
  bool updateHour = false;
  bool updateMinute = false;
  Timer timer;
  final DateTime currentTime = DateTime.now();

  @override
  void initState() {
    userData = widget.loginResponse;
    setInitTime(widget.time);
    setAllTimer();
    _detailTransferBloc = DetailTransferBloc(StopTPInitial());
    super.initState();
  }

  void setAllTimer() {
    setSecondTimer();
  }

  void setSecondTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        updateSec = true;
        if (_second >= 60) {
          _second = 0;
          _minute += 1;
        } else if (_minute >= 60) {
          _minute = 0;
          _hour += 1;
        } else {
          _second = _second;
          _minute = _minute;
          _hour = _hour;
        }
      });
    });
  }

  format(Duration d) => d.toString().split(".").first.padLeft(8, "0");

  void setInitTime(String startTime) {
    DateTime sentTime = DateTime.parse(startTime);
    var difference = DateTime.now().difference(sentTime).inSeconds;

    print(difference);
    String calculatedTime = format(Duration(seconds: difference));
    print("this : $calculatedTime");

    print(DateTime.now());

    _hour = widget.fromOngoing || widget.isFromAlarm
        ?  int.parse(calculatedTime.substring(0, 2))
        : 0;
    _minute = widget.fromOngoing || widget.isFromAlarm
        ? int.parse(calculatedTime.substring(3, 5))
        : 0;
    _second = widget.fromOngoing || widget.isFromAlarm
        ?  int.parse(calculatedTime.substring(6, 8))
        : 0;

    if (_hour.isNegative) {
      _hour = 0;
    }
    if (_minute.isNegative) {
      _minute = 0;
    }
    if (_second.isNegative) {
      _second = 0;
    }

    print("time $_hour - $_minute - $_second");
  }

  Widget buildInputProblem(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: widget.fromOngoing
                          ? "SAAT INI SEDANG REPAIR DENGAN SERIAL NUMBER "
                          : "SAAT INI SEDANG REPAIR PADA ",
                      style: TextStyle(
                          fontSize: 45,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: widget.fromOngoing
                          ? "${widget.serialNumber} ".toUpperCase()
                          : "PROSES ${widget.processName} ".toUpperCase(),
                      style: TextStyle(
                          fontSize: 45,
                          color: Colors.red,
                          fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: widget.fromOngoing ? "PADA " : "DENGAN KATEGORI ",
                      style: TextStyle(
                          fontSize: 45,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: widget.fromOngoing
                          ? "PROSES ${widget.processName} ".toUpperCase()
                          : "${widget.problemName} ".toUpperCase(),
                      style: TextStyle(
                          fontSize: 45,
                          color: Colors.red,
                          fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: widget.fromOngoing
                          ? "DENGAN KATEGORI "
                          : "DENGAN SERIAL NUMBER ",
                      style: TextStyle(
                          fontSize: 45,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: widget.fromOngoing
                          ? "${widget.problemName} ".toUpperCase()
                          : "${widget.serialNumber} ".toUpperCase(),
                      style: TextStyle(
                          fontSize: 45,
                          color: Colors.red,
                          fontWeight: FontWeight.w700),
                    ),
                  ])),
            ),
            SizedBox(height: 40),
            BlocConsumer<DetailTransferBloc, DetailTransferState>(
              bloc: _detailTransferBloc,
              listener: (context, state) {
                if (state is StopTPError) {
                  showAppDialog(context, state.message);
                } else if (state is StopTPEmpty) {
                  showAppDialog(context, state.message);
                } else if (state is StopTPLoaded) {
                  var message = state.response.message;
                  var time = state.response.data.transferProblem.totalTime;

                  showAppDialog(
                      context, "$message \nProses Repair memakan waktu: $time",
                      onTap: () {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardReportProblem(
                          widget.loginResponse,
                        ),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  }, buttonText: "OK");
                }
              },
              builder: (context, state) {
                if (state is StopTPInitial) {
                  return Container();
                } else if (state is StopTPLoading) {
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                }

                return Container();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(110)),
                      border: Border.all(
                          width: 5,
                          color: Colors.red[900],
                          style: BorderStyle.solid)),
                  child: Center(
                      child: Text(
                    "$_hour",
                    style: TextStyle(fontSize: 55, fontWeight: FontWeight.w600),
                  )),
                ),
                Text(":", style: TextStyle(fontSize: 60)),
                Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(110)),
                      border: Border.all(
                          width: 5,
                          color: Colors.red[900],
                          style: BorderStyle.solid)),
                  child: Center(
                      child: Text(
                    "$_minute",
                    style: TextStyle(fontSize: 55, fontWeight: FontWeight.w600),
                  )),
                ),
                Text(":", style: TextStyle(fontSize: 60)),
                Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(110)),
                      border: Border.all(
                          width: 5,
                          color: Colors.red[900],
                          style: BorderStyle.solid)),
                  child: Center(
                      child: Text(
                    updateSec ? "${_second += 1}" : "0",
                    style: TextStyle(fontSize: 55, fontWeight: FontWeight.w600),
                  )),
                ),
              ],
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                showScreenDialog();
              },
              child: Container(
                width: 250,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: Text(
                    "SELESAI REPAIR",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 33, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appbarWithNav(context, userData.data.name,
            userData.data.jobdesk, userData.data.image,
            isLeader: true, response: userData),
        body: TabBarView(
          children: <Widget>[
            buildInputProblem(context),
            MasalahBerjalanReportProblem(
                response: userData, isFromAlarm: false),
          ],
        ),
      ),
    );
  }

  void showScreenDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(),
              child: Container(
                height: 300,
                width: 300,
                padding: EdgeInsets.all(18),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 200,
                      child: TextWidget(
                        text:
                            "Repair ${widget.problemName} pada proses ${widget.processName} selesai?",
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
                              _detailTransferBloc.add(
                                PostStopTP(
                                  StopTrfProblemBody(
                                    transferProblemId: widget.isFromAlarm
                                        ? widget.transferProblemId.toString()
                                        : widget.processTPID.toString(),
                                  ),
                                ),
                              );
                            },
                          ),
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

  @override
  void dispose() {
    timer.cancel();
    _detailTransferBloc.close();
    super.dispose();
  }
}
