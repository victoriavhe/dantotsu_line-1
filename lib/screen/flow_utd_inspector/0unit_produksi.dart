import 'package:dantotsu_line/bloc/utd_unit/utd_unit_bloc.dart';
import 'package:dantotsu_line/bloc/utd_unit/utd_unit_event.dart';
import 'package:dantotsu_line/bloc/utd_unit/utd_unit_state.dart';
import 'package:dantotsu_line/common/colors.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/model/unit/unit_response.dart';
import 'package:dantotsu_line/widgets/app_dialog.dart';
import 'package:dantotsu_line/widgets/circular_progress_widget.dart';
import 'package:dantotsu_line/widgets/profile_image.dart';
import 'package:dantotsu_line/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login_screen.dart';
import '1tipe_model.dart';

class UnitProduksiInspector extends StatefulWidget {
  final LoginResponse loginResponse;

  const UnitProduksiInspector({Key key, this.loginResponse}) : super(key: key);

  @override
  _UnitProduksiInspectorState createState() => _UnitProduksiInspectorState();
}

class _UnitProduksiInspectorState extends State<UnitProduksiInspector> {
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
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Row(
            children: <Widget>[
              ProfileImage(
                imageUrl: profile?.data?.image ?? "",
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextWidget(
                    text: profile?.data?.name.toString() ?? "",
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  TextWidget(
                    text: profile?.data?.privilege ?? "",
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ],
              )
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
                utdUnitsBloc.add(Logout());
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextWidget(
                  text: "Logout",
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
        body: buildInputProblem(),
      ),
    );
  }

  Widget buildInputProblem() {
    return BlocConsumer<UTDUnitsBloc, UTDUnitsState>(
      bloc: utdUnitsBloc,
      listener: (context, state) {
        if (state is UTDUnitError) {
          showAppDialog(
            context,
            state.message,
          );
        } else if (state is UTDUnitEmpty) {
          showAppDialog(context, state.message);
        } else if (state is LogoutSuccess) {
          showAppDialog(context, state.message, buttonText: "OK", onTap: () {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false,
            );
          });
        } else if (state is LogoutFailed) {
          showAppDialog(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is UTDUnitUninitialized) {
          return Container();
        } else if (state is UTDUnitLoading) {
          return CircularProgressWidget();
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
            "Pilih Unit Produksi",
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
            children: response.data.units
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
                              builder: (context) => TipeModelInspector(
                                    profile: profile,
                                    unitID: item.id,
                                  )));
                    },
                    child: Center(
                      child: TextWidget(
                        text: item.name.toUpperCase(),
                        fontSize: 30,
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
    utdUnitsBloc.close();
    super.dispose();
  }
}
