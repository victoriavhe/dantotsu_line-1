import 'package:dantotsu_line/bloc/utd_model/utd_model_bloc.dart';
import 'package:dantotsu_line/bloc/utd_model/utd_model_event.dart';
import 'package:dantotsu_line/bloc/utd_model/utd_model_state.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/model/unit/model/model_per_unit.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/1Amasalah_berjalan.dart';
import 'package:dantotsu_line/util/widget.dart';
import 'package:dantotsu_line/widgets/app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '4opsi_komponen.dart';

class TipeModelReportPrbolem extends StatefulWidget {
  final LoginResponse profile;
  final int unitID;
  final bool isFromAlarm;

  const TipeModelReportPrbolem(
      {Key key, this.profile, this.unitID, this.isFromAlarm})
      : super(key: key);

  @override
  _TipeModelReportPrbolemState createState() => _TipeModelReportPrbolemState();
}

class _TipeModelReportPrbolemState extends State<TipeModelReportPrbolem> {
  UTDModelBloc utdModelBloc;
  LoginResponse profile;

  @override
  void initState() {
    profile = widget.profile;
    utdModelBloc = UTDModelBloc(UTDModelUninitialized());
    utdModelBloc.add(FetchUTDModel(widget.unitID));
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
            buildInputProblem(context),
            MasalahBerjalanReportProblem(
              response: profile,
                isFromAlarm: false
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputProblem(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          child: Text(
            "Pilih Tipe Model".toUpperCase(),
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(height: 20),
        BlocConsumer<UTDModelBloc, UTDModelState>(
          bloc: utdModelBloc,
          listener: (context, state) {
            if (state is UTDModelError) {
              showAppDialog(context, state.message);
            } else if (state is UTDModelEmpty) {
              showAppDialog(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is UTDModelUninitialized) {
              return Container();
            } else if (state is UTDModelLoading) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state is UTDModelLoaded) {
              return _blocBuilder(state.response);
            }
            return Container();
          },
        )
      ],
    );
  }

  //TODO: pass the result
  Widget _blocBuilder(UnitModelResponse response) {
    return Expanded(
      child: GridView.count(
        childAspectRatio: 200 / 100,
        crossAxisCount: 2,
        padding: EdgeInsets.all(20),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: response.data.models
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
                          builder: (context) => OpsiKomponenReportProblem(
                                loginResponse: profile,
                                modelID: item.id,
                                isFromAlarm: widget.isFromAlarm,
                              )));
                },
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      item.name.toUpperCase(),
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
