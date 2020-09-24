import 'package:cached_network_image/cached_network_image.dart';
import 'package:dantotsu_line/bloc/utd_chekpoint_group_leader/checkpoint_group_leader_bloc.dart';
import 'package:dantotsu_line/bloc/utd_chekpoint_group_leader/checkpoint_group_leader_event.dart';
import 'package:dantotsu_line/bloc/utd_chekpoint_group_leader/checkpoint_group_leader_state.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/model/utd/inspector_checkpoint_body.dart';
import 'package:dantotsu_line/model/utd/utd_checkpoint.dart';
import 'package:dantotsu_line/util/widget.dart';
import 'package:dantotsu_line/widgets/app_dialog.dart';
import 'package:dantotsu_line/widgets/circular_progress_widget.dart';
import 'package:dantotsu_line/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '0unit_produksi.dart';

class InspectionRejectCheckingInspector extends StatefulWidget {
  final LoginResponse response;
  final String serialNumber;
  final int componentRfidID;

  const InspectionRejectCheckingInspector(
      {Key key, this.response, this.serialNumber, this.componentRfidID})
      : super(key: key);

  @override
  _InspectionRejectCheckingInspectorState createState() =>
      _InspectionRejectCheckingInspectorState();
}

class _InspectionRejectCheckingInspectorState
    extends State<InspectionRejectCheckingInspector> {
  PageController pageController;
  var user;
  CheckpointGroupLeaderBloc groupLeaderBloc;
  List<Checkpoint> checkpoints = [];
  List<ImageCP> images = [];
  List<TransferCheckPoint> transferCheckpoints = [];
  List<CheckPointNumber> checkPointNumbers = [];
  List<Inspector> inspectors = [];
  List<Inspector> manPowers = [];
  List<Model> defects = [];
  String _value;
  int initialCheckpoint = 0;
  Color defectColor = Colors.blue;
  List<int> defectIds = [];
  int selectedCPN = 0;
  CheckPointNumber selectedCheckPointNumber;
  Checkpoint selectedCheckpoint;
  bool isOk = false;
  TransferCheckPoint transCP;
  bool isRework = false;
  bool isButtonSHown = true;
  static const double _padding = 20.0;
  bool isEnable = true;

  TextEditingController defectLengthController = TextEditingController();
  TextEditingController defectFromController = TextEditingController();
  TextEditingController defectToController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  PageView pageView;

  @override
  void initState() {
    user = widget.response.data;
    pageController = PageController(initialPage: 1);
    groupLeaderBloc = CheckpointGroupLeaderBloc(CheckpointGroupLeaderInitial());
    groupLeaderBloc.add(FetchDetail(widget.componentRfidID));
    super.initState();
  }

  Widget initializePageView() {
    return pageView = PageView(
      controller: pageController,
      children:
          images?.map((e) => _inspectionPage(e)).toList() ?? [setNullPage()],
    );
  }

  Widget setNullPage() {
    return Material(
      child: Container(
        child: Center(
          child: TextWidget(
            text: "Data is empty",
            fontSize: 40,
          ),
        ),
      ),
    );
  }

  Future<void> onRefresh() async {
    groupLeaderBloc.add(FetchDetail(widget.componentRfidID));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: BlocConsumer(
          listener: (context, state) {
            if (state is CPILoaded) {
              showAppDialog(context, "Data Successfully Saved!",
                  buttonText: "OK", onTap: () {
                Navigator.pop(context);
                groupLeaderBloc.add(FetchDetail(widget.componentRfidID));
              });
            } else if (state is DetailLoaded) {
              if (state.response.data != null) {
                setState(() {
                  images = state.response.data.images;
                  defects = state.response.data.defects;
                });
              }
            } else if (state is CheckpointGroupLeaderError) {
              showAppDialog(context, state.message);
            } else if (state is CheckpointGroupLeaderEmpty) {
              showAppDialog(context, state.message);
            }
          },
          bloc: groupLeaderBloc,
          builder: (context, state) {
            if (state is CheckpointGroupLeaderInitial) {
              return Container();
            }
            if (state is CheckpointGroupLeaderLoading) {
              return CircularProgressWidget();
            }
            if (state is DetailLoaded) {
              if (state.response.data != null) {
                return initializePageView();
              }
            }

            return initializePageView();
          }),
    );
  }

  Widget _inspectionPage(ImageCP imageCP) {
    return Scaffold(
      appBar: appbarWithoutBottomNav(
          context, user.name, user.privilege, user.image,
          isLeader: false, response: widget.response),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            padding: EdgeInsets.all(_padding),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - ((_padding * 2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildSerialNumber(),
                SizedBox(
                  height: 30,
                ),
                buildImage(imageCP),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildDropDown(imageCP),
                    buildInspectorManPower(),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                buildDetailInfo(),
                SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: isButtonSHown,
                  child: Container(
                    height: 75,
                    child: Stack(children: [
                      Positioned(
                        top: 0,
                        bottom: 12,
                        child: buildButton(),
                      ),
                    ]),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget buildInspectorManPower() {
    if (transCP != null) {
      return Row(
        children: [
          transCP.inspectors.length > 0
              ? Container(
                  height: 100,
                  width: 200,
                  color: Colors.blueGrey[100],
                  child: ListView.separated(
                      itemBuilder: (context, i) {
                        return listUser("Inspector", transCP.inspectors[i]);
                      },
                      separatorBuilder: (context, i) {
                        return Divider();
                      },
                      itemCount: transCP.inspectors.length),
                )
              : Container(
                  height: 100,
                  width: 200,
                  color: Colors.blueGrey[100],
                  child: Center(
                    child: TextWidget(
                      text: "No Data Inspector",
                    ),
                  ),
                ),
          VerticalDivider(
            thickness: 2,
            color: Colors.white,
            width: 1.5,
          ),
          transCP.manPowers.length > 0
              ? Container(
                  height: 100,
                  width: 200,
                  color: Colors.blueGrey[100],
                  child: ListView.separated(
                      itemBuilder: (context, i) {
                        return listUser("Man Power", transCP.manPowers[i]);
                      },
                      separatorBuilder: (context, i) {
                        return Divider();
                      },
                      itemCount: transCP.manPowers.length),
                )
              : Container(
                  height: 100,
                  width: 200,
                  color: Colors.blueGrey[100],
                  child: Center(
                    child: TextWidget(
                      text: "No Data ManPower",
                    ),
                  ),
                )
        ],
      );
    } else {
      return Container(
        height: 100,
        width: 400,
        color: Colors.blueGrey[100],
        child: Center(
          child: TextWidget(
            text: "No Data Inspector/ManPower",
            fontSize: 20,
          ),
        ),
      );
    }
  }

  Widget buildButton() {
    return Container(
      height: 75,
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
          color: Colors.orangeAccent,
          onPressed: () {
            if (defectLengthController.text.isEmpty) {
              showAppDialog(context, "Defect Length tidak boleh kosong");
            } else {
              if (defectLengthController.text
                      .toString()
                      .contains(RegExp(r"[^0-9\.]")) ||
                  defectFromController.text
                      .toString()
                      .contains(RegExp(r"[^0-9\.]")) ||
                  defectToController.text
                      .toString()
                      .contains(RegExp(r"[^0-9\.]"))) {
                showAppDialog(
                    context, "Tidak bisa input selain angka dan titik.");
              } else {
                showQuestionDialog(
                  context,
                  "Simpan Data",
                  onYes: () {
                    groupLeaderBloc.add(
                      PostCheckPointInspector(
                        InspectorCpBody(
                          componentRfidId: widget.componentRfidID.toString(),
                          checkPointId: selectedCheckpoint.id.toString(),
                          defectDepthTo:
                              defectLengthController.text.toString() == "0"
                                  ? "0"
                                  : defectToController.text.toString(),
                          defectDepthFrom:
                              defectLengthController.text.toString() == "0"
                                  ? "0"
                                  : defectFromController.text.toString(),
                          defectLength: defectLengthController.text.toString(),
                          result: status,
                          remark: remarkController.text.toString(),
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  onNo: () => Navigator.pop(context),
                );
              }
            }
          },
          child: Text(
            "Save",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white),
          )),
    );
  }

  void setEnabling() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        if (defectLengthController.text.toString().isNotEmpty &&
            double.parse(defectLengthController.text
                    .toString()
                    .replaceAll(RegExp(r"[^0-9\.]"), "")) >
                0) {
          isEnable = true;
        } else {
          isEnable = false;
        }
      });
    });
  }

  TransferCheckPoint selectedTCP;

  Widget buildDetailInfo() {
    setEnabling();

    return transferCheckpoints.length > 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (transferCheckpoints.length > 0) {
                          setState(() {
                            transCP = transferCheckpoints[index];
                            isRework = transCP.sequence >= 1;
                          });
                        }
                      });

                      return detailInfoItem(
                        transferCheckPoint: transferCheckpoints[index],
                        position: transferCheckpoints.length - index,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: transferCheckpoints.length),
              ),
            ],
          )
        : detailInfoItem();
  }

  String status;

  void setStatus(TransferCheckPoint transferCheckPoint) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (transferCheckPoint != null) {
        setState(() {
          transCP = transferCheckPoint;
        });
      } else {
        if (defectLengthController.text.toString().isNotEmpty &&
            double.parse(defectLengthController.text
                    .toString()
                    .replaceAll(RegExp(r"[^0-9\.]"), "")) >
                0) {
          setState(() {
            status = "NG";
          });
        } else {
          setState(() {
            status = "OK";
          });
        }
      }
    });
  }

  static String allowNumberOnly(String s) =>
      s.replaceAll(RegExp(r"[^0-9\.]"), "");

  Widget detailInfoItem({
    TransferCheckPoint transferCheckPoint,
    int position,
  }) {
    defectLengthController.addListener(() {
      if (defectLengthController.text.isNotEmpty ||
          defectFromController.text.isNotEmpty ||
          defectToController.text.isNotEmpty) {
        allowNumberOnly(defectLengthController.text.toString());
        allowNumberOnly(defectFromController.text.toString());
        allowNumberOnly(defectToController.text.toString());
      }
    });

    setStatus(transferCheckPoint);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: isRework,
          child: TextWidget(
            text: transferCheckPoint != null
                ? transferCheckPoint?.sequence >= 1
                    ? "Rework ${transferCheckPoint?.sequence}"
                    : "" ?? ""
                : "",
            color: Colors.red,
            fontSize: 25,
          ),
        ),
        Card(
          elevation: 2,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextWidget(
                      text:
                          "Welding Length : ${selectedCheckpoint?.weldingLength ?? ""} mm",
                      fontSize: 22,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        TextWidget(
                          text: "Defect Length : ",
                          fontSize: 22,
                        ),
                        Container(
                          width: 120,
                          height: 50,
                          child: TextField(
                            enabled: isButtonSHown,
                            //enabling textField if TCP is null else is disabled
                            controller: defectLengthController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black26, width: 1.0)),
                              hintText:
                                  "${transferCheckPoint?.defectLength ?? ""}",
                            ),
                          ),
                        ),
                        TextWidget(
                          text: "  mm",
                          fontSize: 22,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        TextWidget(
                          text: "Depth of Defect :  ",
                          fontSize: 22,
                        ),
                        Container(
                          width: 120,
                          height: 50,
                          child: TextField(
                            enabled: isEnable,
                            controller: defectFromController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black26, width: 1.0)),
                              hintText:
                                  "${transferCheckPoint?.defectDepthFrom ?? ""}",
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: TextWidget(
                            text: "-",
                            fontSize: 22,
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 50,
                          child: TextField(
                            enabled: isEnable,
                            controller: defectToController,
                            keyboardType: TextInputType.number,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black26, width: 1.0)),
                              hintText:
                                  "${transferCheckPoint?.defectDepthTo ?? ""}",
                            ),
                          ),
                        ),
                        TextWidget(
                          text: " / ${selectedCheckpoint?.depth} mm",
                          fontSize: 22,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: <Widget>[
                        TextWidget(
                          text: "Status : ",
                          fontSize: 22,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 22,
                              width: 22,
                              color: (defectLengthController.text.isNotEmpty) &&
                                          double.parse(defectLengthController
                                                  .text
                                                  .toString()
                                                  .replaceAll(
                                                      RegExp(r"[^0-9\.]"),
                                                      "")) >
                                              0 ||
                                      (transferCheckPoint != null &&
                                              transferCheckPoint
                                                  .defectLength.isNotEmpty) &&
                                          double.parse(transferCheckPoint
                                                  .defectLength
                                                  .replaceAll(
                                                      RegExp(r"[^0-9\.]"),
                                                      "")) >
                                              0
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        TextWidget(
                          text: (defectLengthController.text.isNotEmpty) &&
                                      double.parse(defectLengthController.text
                                              .toString()
                                              .replaceAll(
                                                  RegExp(r"[^0-9\.]"), "")) >
                                          0 ||
                                  (transferCheckPoint != null &&
                                          transferCheckPoint
                                              .defectLength.isNotEmpty) &&
                                      double.parse(transferCheckPoint
                                              .defectLength
                                              .replaceAll(
                                                  RegExp(r"[^0-9\.]"), "")) >
                                          0
                              ? "NG"
                              : "OK",
                          fontSize: 22,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: <Widget>[
                        TextWidget(
                          text: "Remark : ",
                          fontSize: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.60,
                          height: 60,
                          child: TextField(
                            enabled: isButtonSHown,
                            controller: remarkController,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black26, width: 1.0)),
                              hintText: "${transferCheckPoint?.remark ?? ""}",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Visibility(
                  visible: transferCheckpoints.isNotEmpty && position == 1,
                  child: FloatingActionButton(
                    heroTag: "floating",
                    child: Center(
                      child: TextWidget(
                        text: "+",
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isButtonSHown = true;
                      });

                      showNewFormDialog(context);
                    },
                    backgroundColor: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget listUser(String name, Inspector user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: TextWidget(
              text: name,
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                child: CachedNetworkImage(
                  imageUrl: user.image,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(width: 10),
              Column(
                children: <Widget>[
                  TextWidget(
                    text: user.name,
                  ),
                  TextWidget(
                    text: user.nrp,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildDropDown(ImageCP imagecp) {
    return selectedCheckPointNumber != null
        ? Row(
            children: [
              TextWidget(
                text: "${selectedCheckPointNumber.number}.",
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              DropdownButton(
                hint: TextWidget(
                  text: "  Pilih Area",
                  fontSize: 32,
                ),
                value: _value,
                items: selectedCheckPointNumber.checkpoints
                        .map(
                          (e) => DropdownMenuItem(
                            child: Center(
                              child: TextWidget(
                                text: " ${e.name.toString()}" ??
                                    "Tidak ada data.",
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            value: e.name.toString(),
                            onTap: () {
                              setState(() {
                                selectedCheckpoint = e;
                                transCP = null;
                                transferCheckpoints =
                                    selectedCheckpoint.transferCheckPoints;

                                if (transferCheckpoints == null ||
                                    transferCheckpoints.isEmpty) {
                                  isButtonSHown = true;
                                  isEnable = true;
                                } else {
                                  isButtonSHown = false;
                                  isEnable = false;
                                }
                              });
                            },
                          ),
                        )
                        .toList() ??
                    TextWidget(
                      text: "Tidak ada data.",
                    ),
                onChanged: (String value) {
                  _value = value;
                  print("value $_value");
                },
              ),
            ],
          )
        : TextWidget(
            text: "Silakan Pilih Checkpoint.",
            fontSize: 25,
          );
  }

  Widget buildImage(ImageCP imageCP) {
    var comparison = double.parse(imageCP.width) /
        (MediaQuery.of(context).size.width - ((_padding * 2) + 10));

    return Stack(children: [
      Center(
        child: Container(
          width: double.parse(imageCP.width),
          height: double.parse(imageCP.height) / comparison,
          child: CachedNetworkImage(
            imageUrl: imageCP.image,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      Container(
        width: double.parse(imageCP.width),
        height: double.parse(imageCP.height) / comparison,
        child: Stack(
          children: imageCP.checkPointNumbers
              .map((e) => Positioned(
                    left: double.parse(e.x) / comparison,
                    bottom: double.parse(e.y) / comparison,
                    child: Container(
                      height: 30,
                      width: 30,
                      child: InkWell(
                        child: Container(
                          height: 20,
                          width: 20,
                          child: Container(
                            color: Colors.red[200],
                            child: Center(
                              child: TextWidget(
                                text: e?.number?.toString() ?? "",
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _value = null;
                            selectedCheckPointNumber = e;
                            selectedCheckpoint = null;
                            transCP = null;
                            defectLengthController.text = "";
                            defectFromController.text = "";
                            defectToController.text = "";
                            remarkController.text = "";
                          });
                        },
                      ),
                    ),
                  ))
              .toList(),
        ),
      )
    ]);
  }

  Widget buildSerialNumber() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextWidget(
              text: "SN",
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            SizedBox(
              width: 20,
            ),
            TextWidget(
              text: widget.serialNumber,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }

  void showNewFormDialog(BuildContext context) {
    TextEditingController _con = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(),
              child: StatefulBuilder(
                builder: (context, stateSetter) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (transCP != null) {
                      stateSetter(() {
                        transCP = transCP;
                      });
                    }

                    if (_con.text.toString().isNotEmpty &&
                        double.parse(_con.text.toString().replaceAll(",", "")) >
                            0) {
                      stateSetter(() {
                        status = "NG";
                      });
                    } else {
                      stateSetter(() {
                        status = "OK";
                      });
                    }
                  });

                  return Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(18),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: TextWidget(
                            text: "New Rework",
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 2,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        TextWidget(
                                          text:
                                              "Welding Length : ${selectedCheckpoint?.weldingLength ?? ""} mm",
                                          fontSize: 22,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            TextWidget(
                                              text: "Defect Length : ",
                                              fontSize: 22,
                                            ),
                                            Container(
                                              width: 120,
                                              height: 50,
                                              child: TextField(
                                                enabled: true,
                                                //enabling textField if TCP is null else is disabled
                                                controller: _con,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 20),
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black26,
                                                          width: 1.0)),
                                                  hintText:
                                                      "${transCP?.defectLength ?? ""}",
                                                ),
                                              ),
                                            ),
                                            TextWidget(
                                              text: "  mm",
                                              fontSize: 22,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            TextWidget(
                                              text: "Depth of Defect :  ",
                                              fontSize: 22,
                                            ),
                                            Container(
                                              width: 120,
                                              height: 50,
                                              child: TextField(
                                                enabled:
                                                    _con.text.toString() != "0",
                                                controller:
                                                    defectFromController,
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                style: TextStyle(fontSize: 20),
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black26,
                                                          width: 1.0)),
                                                  hintText:
                                                      "${transCP?.defectDepthFrom ?? ""}",
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0, right: 16.0),
                                              child: TextWidget(
                                                text: "-",
                                                fontSize: 22,
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              height: 50,
                                              child: TextField(
                                                enabled:
                                                    _con.text.toString() != "0",
                                                controller: defectToController,
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 20),
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black26,
                                                          width: 1.0)),
                                                  hintText:
                                                      "${transCP?.defectDepthTo ?? ""}",
                                                ),
                                              ),
                                            ),
                                            TextWidget(
                                              text:
                                                  " / ${selectedCheckpoint?.depth} mm",
                                              fontSize: 22,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            TextWidget(
                                              text: "Status : ",
                                              fontSize: 22,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  height: 22,
                                                  width: 22,
                                                  color: _con.text
                                                              .toString()
                                                              .isNotEmpty &&
                                                          double.parse(_con.text
                                                                  .toString()
                                                                  .replaceAll(
                                                                      ",",
                                                                      "")) >
                                                              0
                                                      ? Colors.red
                                                      : Colors.green,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            TextWidget(
                                              text: _con.text
                                                          .toString()
                                                          .isNotEmpty &&
                                                      double.parse(_con.text
                                                              .toString()
                                                              .replaceAll(
                                                                  ",", "")) >
                                                          0
                                                  ? "NG"
                                                  : "OK",
                                              fontSize: 22,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.70,
                                          child: Row(
                                            children: <Widget>[
                                              TextWidget(
                                                text: "Remark : ",
                                                fontSize: 22,
                                              ),
                                              Expanded(
                                                child: TextField(
                                                  enabled: true,
                                                  //enabling textField if TCP is null else is disabled
                                                  controller: remarkController,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black26,
                                                            width: 1.0)),
                                                    hintText:
                                                        "${transCP?.remark ?? ""}",
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 50,
                            color: Colors.orange,
                            child: Center(
                                child: TextWidget(
                              text: "SAVE",
                              fontSize: 20,
                            )),
                          ),
                          onTap: () {
                            Navigator.pop(context);

                            groupLeaderBloc.add(
                              PostCheckPointInspector(
                                InspectorCpBody(
                                  componentRfidId:
                                      widget.componentRfidID.toString(),
                                  checkPointId:
                                      selectedCheckpoint.id.toString(),
                                  defectDepthTo: _con.text.toString() == "0"
                                      ? "0"
                                      : defectToController.text.toString(),
                                  defectDepthFrom: _con.text.toString() == "0"
                                      ? "0"
                                      : defectFromController.text.toString(),
                                  defectLength: _con.text.toString(),
                                  result: status,
                                  remark: remarkController.text.toString(),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  );
                },
              ));
        });
  }

  @override
  void didUpdateWidget(covariant InspectionRejectCheckingInspector oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    groupLeaderBloc.close();
    super.dispose();
  }
}
