import 'dart:ui';

import 'package:dantotsu_line/bloc/utd_list/utd_list_bloc.dart';
import 'package:dantotsu_line/bloc/utd_list/utd_list_event.dart';
import 'package:dantotsu_line/bloc/utd_list/utd_list_state.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/model/utd/utd_response.dart';
import 'package:dantotsu_line/screen/flow_utd_group_leader/inspection_screen.dart';
import 'package:dantotsu_line/util/widget.dart';
import 'package:dantotsu_line/widgets/app_dialog.dart';
import 'package:dantotsu_line/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class LogHasilPengecekan extends StatefulWidget {
  final LoginResponse loginResponse;

  const LogHasilPengecekan({Key key, this.loginResponse}) : super(key: key);

  @override
  _LogHasilPengecekanState createState() => _LogHasilPengecekanState();
}

class _LogHasilPengecekanState extends State<LogHasilPengecekan> {
  LoginResponse userData;
  DateTime pickedDate;
  UtdResponse response = UtdResponse();
  UTDListBloc utdListBloc;
  bool isOK = false;
  String monthName = "";

  @override
  void initState() {
    userData = widget.loginResponse;
    pickedDate = DateTime.now();
    utdListBloc = UTDListBloc(UTDListInitial());
    dispatchInitial();
    super.initState();
  }

  void dispatchInitial() {
    utdListBloc.add(
        FetchUTDLIst(pickedDate.month.toString(), pickedDate.year.toString()));
  }

  String time(int month) {
    switch (month) {
      case 1:
        {
          monthName = "Januari";
        }
        break;
      case 2:
        {
          monthName = "Febuari";
        }
        break;
      case 3:
        {
          monthName = "Maret";
        }
        break;
      case 4:
        {
          monthName = "April";
        }
        break;
      case 5:
        {
          monthName = "Mei";
        }
        break;
      case 6:
        {
          monthName = "Juni";
        }
        break;
      case 7:
        {
          monthName = "Juli";
        }
        break;
      case 8:
        {
          monthName = "Agustus";
        }
        break;
      case 9:
        {
          monthName = "September";
        }
        break;
      case 10:
        {
          monthName = "Oktober";
        }
        break;
      case 11:
        {
          monthName = "November";
        }
        break;
      case 12:
        {
          monthName = "Desember";
        }
        break;
    }
    return monthName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWithoutBottomNav(context, userData.data.name,
          userData.data.jobdesk, userData.data.image,
          isLeader: true, response: userData),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              "LOG HASIL PENGECEKAN",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ListTile(
                    onTap: runDatePicker,
                    title: TextWidget(
                      text: "${pickedDate.year}, ${time(pickedDate.month)}",
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    trailing: Icon(Icons.arrow_drop_down),
                  ),
                ),
              ],
            ),
            BlocConsumer<UTDListBloc, UTDListState>(
              bloc: utdListBloc,
              listener: (context, state) {
                if (state is UTDListError) {
                  showAppDialog(context, state.message);
                } else if (state is UTDListEmpty) {
                  showAppDialog(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is UTDListInitial) {
                  return Container();
                } else if (state is UTDListLoading) {
                  return Center(
                      child: CupertinoActivityIndicator(
                    radius: 10,
                  ));
                } else if (state is UTDListLoaded) {
                  var response = state.response;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: loadDataPengecekan(response.data.componentRfids),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  DataTable loadDataPengecekan(List<ComponentRfid> components) {
    return DataTable(
      showCheckboxColumn: false,
      sortAscending: false,
      sortColumnIndex: 1,
      columns: [
        DataColumn(
            label: Text(
              "Model",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            numeric: false,
            tooltip: "Model"),
        DataColumn(
            label: Text(
              "Part No.",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            numeric: false,
            tooltip: "Part No."),
        DataColumn(
            label: Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            numeric: false,
            tooltip: "Description Part"),
        DataColumn(
            label: Text(
              "SN",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            numeric: false,
            tooltip: "Serial Number"),
        DataColumn(
            label: Text(
              "Status",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            numeric: false,
            tooltip: "Status")
      ],
      rows: components
          .map(
            (data) => DataRow(
              onSelectChanged: (bool selected) {
                if (selected) {
                  print('Selected ${data.model.name}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
//                          InspectionChecking(
//                        userData: userData,
//                        componentRfidId: data.id,
//                      ),
                          InspectionScreen(
                        userData: userData,
                        serialNumber: data.serialNumber,
                        componetRfidID: data.id,
                      ),
                    ),
                  );
                }
              },
              cells: [
                DataCell(
                  Text(
                    data.model.name ?? "",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                ),
                DataCell(
                  Text(
                    data.component.partNo ?? "",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                ),
                DataCell(
                  Text(
                    data.component.description ?? "",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                ),
                DataCell(
                  Text(
                    data.serialNumber ?? "",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                ),
                DataCell(
                  Row(
                    children: <Widget>[
                      Visibility(
                        visible: data.status != null,
                        child: Container(
                          height: 20,
                          width: 20,
                          color: data?.status?.toLowerCase() == "ok"
                              ? Colors.green
                              : Colors.red,
                          child: Center(
                              child: Icon(
                            data?.status?.toLowerCase() == "ok"
                                ? Icons.check
                                : Icons.close,
                            color: data?.status?.toLowerCase() == "ok"
                                ? Colors.black
                                : Colors.white,
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        data.status ?? "-",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                    ],
                  ),
//                  onTap: () {
//                    print('Selected ${data.status}');
//                  },
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  runDatePicker() {
    DatePicker.showDatePicker(
      context,
      dateFormat: "yyyy-MMMM",
      minDateTime: DateTime(DateTime.now().year - 5),
      maxDateTime: DateTime(DateTime.now().year + 5),
      initialDateTime: pickedDate,
      locale: DATETIME_PICKER_LOCALE_DEFAULT,
      pickerMode: DateTimePickerMode.date,
      onConfirm: (date, index) {
        setState(() {
          pickedDate = date;
        });
        utdListBloc
            .add(FetchUTDLIst(date.month.toString(), date.year.toString()));
      },
      onChange: (date, index) {
        setState(() {
          pickedDate = date;
        });
      },
    );
  }
}
