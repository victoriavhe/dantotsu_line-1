import 'package:dantotsu_line/bloc/serial_number/serial_number_bloc.dart';
import 'package:dantotsu_line/bloc/serial_number/serial_number_event.dart';
import 'package:dantotsu_line/bloc/serial_number/serial_number_state.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/model/unit/serial_number/serial_number.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/1Amasalah_berjalan.dart';
import 'package:dantotsu_line/util/widget.dart';
import 'package:dantotsu_line/widgets/app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '7pilih_kendala.dart';

class SerialNumberReportProblem extends StatefulWidget {
  final int componentID, routeID;
  final LoginResponse loginResponse;
  final bool isFromAlarm;

  const SerialNumberReportProblem(
      {Key key,
      this.componentID,
      this.routeID,
      this.loginResponse,
      this.isFromAlarm})
      : super(key: key);

  @override
  _SerialNumberReportProblemState createState() =>
      _SerialNumberReportProblemState();
}

class _SerialNumberReportProblemState extends State<SerialNumberReportProblem> {
  SerialNumberBloc snBloc;
  LoginResponse profile;
  bool isFromAlarm;

  @override
  void initState() {
    print("From Alarm $isFromAlarm");
    isFromAlarm = widget.isFromAlarm;
    profile = widget.loginResponse;
    snBloc = SerialNumberBloc(SNUninitialized());
    snBloc.add(FetchSerialNumber(widget.componentID, widget.routeID));
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
        body: TabBarView(children: [
          buildInputProblem(),
          MasalahBerjalanReportProblem(response: profile, isFromAlarm: false),
        ]),
      ),
    );
  }

  Widget buildInputProblem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        Text(
          "Pilih Serial Number".toUpperCase(),
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 20),
        BlocConsumer(
          bloc: snBloc,
          listener: (context, state) {
            if (state is SNError) {
              showAppDialog(context, state.message);
            } else if (state is SNEmpty) {
              showAppDialog(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is SNUninitialized) {
              return Container();
            } else if (state is SNLoading) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state is SNLoaded) {
              return blocLoaded(state.response);
            }

            return Container();
          },
        )
      ],
    );
  }

  Widget blocLoaded(SerialNumberResponse response) {
    return Expanded(
      child: ListView.builder(
        itemCount: response.data.serialNumbers.length,
        itemBuilder: (BuildContext context, int index) {
          return LimitedBox(
            maxHeight: 100,
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: FlatButton(
                color: widget.isFromAlarm &&
                        response.data.serialNumbers[index].totalProblem > 0
                    ? Colors.red
                    : Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.red[800],
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () => _onClickButton(response, index),
                child: Center(
                  child: Text(
                    response.data.serialNumbers[index].serialNumber
                        .toUpperCase(),
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickButton(SerialNumberResponse response, int index) {
    if (isFromAlarm) {
      if (response.data?.serialNumbers[index]?.problems == null ||
          response.data.serialNumbers[index].problems.isEmpty) {
        showAppDialog(context, "This action cannot be done.");
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PilihKendalaReportProblem(
              transferProblemID:
                  response.data.serialNumbers[index].problems[0].id,
              name: response.data.serialNumbers[index].serialNumber,
              userData: profile,
              isFromAlarm: widget.isFromAlarm,
              transferComponentID: null,
            ),
          ),
        );
      }
    } else if (!isFromAlarm) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PilihKendalaReportProblem(
            transferProblemID: null,
            name: response.data.serialNumbers[index].serialNumber,
            userData: profile,
            isFromAlarm: widget.isFromAlarm,
            transferComponentID: int.parse(
                response.data.serialNumbers[index].transferComponentId),
          ),
        ),
      );
    }
  }
}
