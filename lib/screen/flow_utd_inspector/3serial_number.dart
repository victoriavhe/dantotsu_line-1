import 'package:dantotsu_line/bloc/serial_number_inspector/serial_number_inspector_bloc.dart';
import 'package:dantotsu_line/bloc/serial_number_inspector/serial_number_inspector_event.dart';
import 'package:dantotsu_line/bloc/serial_number_inspector/serial_number_inspector_state.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/model/utd/utd_serial_numbers.dart';
import 'package:dantotsu_line/util/widget.dart';
import 'package:dantotsu_line/widgets/app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '4inspection_reject_checking.dart';

class SerialNumberInspector extends StatefulWidget {
  final int componentID;
  final LoginResponse response;

  const SerialNumberInspector({Key key, this.componentID, this.response})
      : super(key: key);

  @override
  _SerialNumberInspectorState createState() => _SerialNumberInspectorState();
}

class _SerialNumberInspectorState extends State<SerialNumberInspector> {
  SNInspectorBloc sniBloc;
  LoginResponse profile;

  @override
  void initState() {
    profile = widget.response;
    sniBloc = SNInspectorBloc(SNUninitialized());
    sniBloc.add(FetchUTDSNInspector(widget.componentID));
    super.initState();
  }

  Widget buildSerialNumber(BuildContext context, UtdSerialNumber response) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        Text(
          "Pilih Serial Number",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: response.data.serialNumbers.length,
            itemBuilder: (BuildContext context, int index) {
              return LimitedBox(
                maxHeight: 100,
                child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: FlatButton(
                    color: (1 == 1) ? Colors.white : Colors.red,
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
                          builder: (context) =>
                              InspectionRejectCheckingInspector(
                            response: widget.response,
                            componentRfidID: response
                                .data.serialNumbers[index].componentRfidId,
                            serialNumber:
                                response.data.serialNumbers[index].serialNumber,
                          ),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        response.data.serialNumbers[index].serialNumber,
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarWithoutBottomNav(context, profile.data.name,
            profile.data.privilege, profile.data.image,
            isLeader: false, response: profile),
        body: BlocConsumer<SNInspectorBloc, SNInspectorState>(
          bloc: sniBloc,
          listener: (context, state) {
            if (state is SNError) {
              showAppDialog(context, state.message.toString());
            } else if (state is SNEmpty) {
              showAppDialog(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is SNUninitialized) {
              return Container();
            } else if (state is SNLoading) {
              return Center(
                child: CupertinoActivityIndicator(
                  radius: 10,
                ),
              );
            } else if (state is SNLoaded) {
              print(state.response);
              return buildSerialNumber(context, state.response);
            }

            return Container();
          },
        ));
  }
}
