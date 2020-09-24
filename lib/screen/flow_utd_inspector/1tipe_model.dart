import 'package:dantotsu_line/bloc/utd_model/utd_model_bloc.dart';
import 'package:dantotsu_line/bloc/utd_model/utd_model_event.dart';
import 'package:dantotsu_line/bloc/utd_model/utd_model_state.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/model/unit/model/model_per_unit.dart';
import 'package:dantotsu_line/util/widget.dart';
import 'package:dantotsu_line/widgets/app_dialog.dart';
import 'package:dantotsu_line/widgets/circular_progress_widget.dart';
import 'package:dantotsu_line/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '2pilih_component.dart';

class TipeModelInspector extends StatefulWidget {
  final LoginResponse profile;
  final int unitID;

  const TipeModelInspector({Key key, this.profile, this.unitID})
      : super(key: key);

  @override
  _TipeModelInspectorState createState() => _TipeModelInspectorState();
}

class _TipeModelInspectorState extends State<TipeModelInspector> {
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
        appBar: appbarWithoutBottomNav(context, profile.data.name,
            profile.data.privilege, profile.data.image, isLeader: false, response: profile),
        body: buildInputProblem(context),
      ),
    );
  }

  Widget buildInputProblem(BuildContext context) {
    return BlocConsumer<UTDModelBloc, UTDModelState>(
      listener: (context, state) {
        if (state is UTDModelError) {
          showAppDialog(context, state.message);
        } else if (state is UTDModelEmpty) {
          showAppDialog(context, state.message);
        }
      },
      bloc: utdModelBloc,
      builder: (context, state) {
        if (state is UTDModelUninitialized) {
          return Container();
        } else if (state is UTDModelLoading) {
          return CircularProgressWidget();
        } else if (state is UTDModelLoaded) {
          return _blocBuilder(state.response);
        }
        return Container();
      },
    );
  }

  Widget _blocBuilder(UnitModelResponse response) {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          child: Text(
            "Pilih Tipe Model",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
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
            children: response.data.models
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
                          builder: (context) => PilihKomponenInspector(
                            loginResponse: profile,
                            modelID: item.id,
                          )));
                },
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: TextWidget(
                      text: item.name.toUpperCase(),
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
    utdModelBloc.close();
    super.dispose();
  }
}
