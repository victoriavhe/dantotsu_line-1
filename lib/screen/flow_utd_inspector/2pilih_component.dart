import 'package:dantotsu_line/bloc/utd_component/utd_component_bloc.dart';
import 'package:dantotsu_line/bloc/utd_component/utd_component_event.dart';
import 'package:dantotsu_line/bloc/utd_component/utd_component_state.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/model/unit/component/component_per_model.dart';
import 'package:dantotsu_line/util/widget.dart';
import 'package:dantotsu_line/widgets/app_dialog.dart';
import 'package:dantotsu_line/widgets/circular_progress_widget.dart';
import 'package:dantotsu_line/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '3serial_number.dart';

class PilihKomponenInspector extends StatefulWidget {
  final LoginResponse loginResponse;
  final int modelID;

  const PilihKomponenInspector({Key key, this.loginResponse, this.modelID})
      : super(key: key);

  @override
  _PilihKomponenInspectorState createState() => _PilihKomponenInspectorState();
}

class _PilihKomponenInspectorState extends State<PilihKomponenInspector> {
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
        appBar: appbarWithoutBottomNav(context, profile.data.name,
            profile.data.privilege, profile.data.image, isLeader: false, response: profile),
        body: buildInputProblem(context),
      ),
    );
  }

  Widget buildInputProblem(BuildContext context) {
    return BlocConsumer(
        listener: (context, state) {
          if (state is ComponentError) {
            showAppDialog(context, state.message);
          } else if (state is ComponentEmpty) {
            showAppDialog(context, state.message);
          }
        },
        bloc: utdComponentBloc,
        builder: (context, state) {
          if (state is ComponentUninitialized) {
            return Container();
          } else if (state is ComponentLoading) {
            return CircularProgressWidget();
          } else if (state is ComponentLoaded) {
            return _blocBuilder(state.componentResponse);
          }

          return Container();
        });
  }

  Widget _blocBuilder(ModelComponentResponse response) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          "Pilih Opsi Komponen",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 20),
        Expanded(
          child: GridView.count(
            childAspectRatio: 300 / 100,
            crossAxisCount: 2,
            padding: EdgeInsets.all(20),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: response.data.components
                .map(
                  (item) => FlatButton(
                color: (1 == 1) ? Colors.red[50] : Colors.red,
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
                          builder: (context) => SerialNumberInspector(
                            response: profile,
                            componentID: item.id,
                          )));
                },
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: TextWidget(
                      text: item.description.toUpperCase(),
                      fontSize: 30,
                    ),
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

  @override
  void dispose() {
    utdComponentBloc.close();
    super.dispose();
  }
}
