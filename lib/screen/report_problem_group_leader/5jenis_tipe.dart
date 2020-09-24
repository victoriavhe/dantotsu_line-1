import 'package:cached_network_image/cached_network_image.dart';
import 'package:dantotsu_line/bloc/component_route/utd_route_bloc.dart';
import 'package:dantotsu_line/bloc/component_route/utd_route_event.dart';
import 'package:dantotsu_line/bloc/component_route/utd_route_state.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/model/unit/route/route_per_component.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/1Amasalah_berjalan.dart';
import 'package:dantotsu_line/util/widget.dart';
import 'package:dantotsu_line/widgets/app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '6serial_number.dart';

class JenisTipeReportProblem extends StatefulWidget {
  final int componentID;
  final LoginResponse response;
  final bool isFromAlarm;

  const JenisTipeReportProblem(
      {Key key, this.componentID, this.response, this.isFromAlarm})
      : super(key: key);

  @override
  _JenisTipeReportProblemState createState() => _JenisTipeReportProblemState();
}

class _JenisTipeReportProblemState extends State<JenisTipeReportProblem> {
  RouteComponentBloc routeBloc;
  LoginResponse profile;

  @override
  void initState() {
    profile = widget.response;
    routeBloc = RouteComponentBloc(RouteUninitialized());
    routeBloc.add(FetchRouteComponent(widget.componentID));
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
          children: <Widget>[
            buildInputProblem(context),
            MasalahBerjalanReportProblem(response: profile, isFromAlarm: false),
          ],
        ),
      ),
    );
  }

  Widget buildInputProblem(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        BlocConsumer(
          bloc: routeBloc,
          listener: (context, state) {
            if (state is RouteError) {
              showAppDialog(context, state.message);
            } else if (state is RouteEmpty) {
              showAppDialog(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is RouteUninitialized) {
              return Container();
            } else if (state is RouteLoading) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state is RouteLoaded) {
              return blocLoaded(state.routeResponse);
            }

            return Container();
          },
        )
      ],
    );
  }

  Widget blocLoaded(ComponentRouteResponse response) {
    return Expanded(
      child: GridView.count(
        childAspectRatio: 200 / 100,
        crossAxisCount: 2,
        padding: EdgeInsets.all(20),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: response.data.routes
            .map(
              (item) => FlatButton(
                color: widget.isFromAlarm && item.totalProblem > 0
                    ? Colors.red
                    : Colors.green,
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
                          builder: (context) => SerialNumberReportProblem(
                                componentID: widget.componentID,
                                routeID: item.id,
                                loginResponse: profile,
                                isFromAlarm: widget.isFromAlarm,
                              )));
                },
                child: Container(
                  color: widget.isFromAlarm && item.totalProblem > 0
                      ? Colors.red
                      : Colors.green,
                  width: double.maxFinite,
                  child: Stack(
                    alignment: const Alignment(0, 0),
                    children: [
                      Opacity(
                        opacity: 0.2,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              "https://www.kindadusty.com/wp-content/uploads/2016/05/engineering.jpg",
                        ),
                      ),
                      Text(
                        item.processName.toUpperCase(),
                        style: TextStyle(fontSize: 40),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
