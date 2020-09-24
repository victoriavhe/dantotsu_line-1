import 'package:dantotsu_line/bloc/utd_component/utd_component_bloc.dart';
import 'package:dantotsu_line/bloc/utd_component/utd_component_event.dart';
import 'package:dantotsu_line/bloc/utd_component/utd_component_state.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/model/unit/component/component_per_model.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/1Amasalah_berjalan.dart';
import 'package:dantotsu_line/util/widget.dart';
import 'package:dantotsu_line/widgets/app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '5jenis_tipe.dart';

class OpsiKomponenReportProblem extends StatefulWidget {
  final LoginResponse loginResponse;
  final int modelID;
  final bool isFromAlarm;

  const OpsiKomponenReportProblem(
      {Key key, this.loginResponse, this.modelID, this.isFromAlarm})
      : super(key: key);

  @override
  _OpsiKomponenReportProblemState createState() =>
      _OpsiKomponenReportProblemState();
}

class _OpsiKomponenReportProblemState extends State<OpsiKomponenReportProblem> {
  UTDComponentBloc utdComponentBloc;
  LoginResponse profile;

  @override
  void initState() {
    profile = widget.loginResponse;
    utdComponentBloc = UTDComponentBloc(ComponentUninitialized());
    utdComponentBloc.add(FetchUTDComponentProblem(widget.modelID));
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
          buildInputProblem(context),
          MasalahBerjalanReportProblem(response: profile, isFromAlarm: false),
        ]),
      ),
    );
  }

  Widget buildInputProblem(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          "Pilih Opsi Komponen".toUpperCase(),
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 20),
        BlocConsumer(
            bloc: utdComponentBloc,
            listener: (context, state) {
              if (state is ComponentError) {
                showAppDialog(context, state.message);
              } else if (state is ComponentEmpty) {
                showAppDialog(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is ComponentUninitialized) {
                return Container();
              } else if (state is ComponentLoading) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (state is ComponentLoaded) {
                return _blocBuilder(state.componentResponse);
              }

              return Container();
            })
      ],
    );
  }

  Widget _blocBuilder(ModelComponentResponse response) {
    return Expanded(
      child: GridView.count(
        childAspectRatio: 300 / 100,
        crossAxisCount: 2,
        padding: EdgeInsets.all(20),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: response.data.components
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
                          builder: (context) => JenisTipeReportProblem(
                                response: profile,
                                componentID: item.id,
                                isFromAlarm: widget.isFromAlarm,
                              )));
                },
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      item.description.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 37),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
