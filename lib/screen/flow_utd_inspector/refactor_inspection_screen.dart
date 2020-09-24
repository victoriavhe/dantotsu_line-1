import 'package:cached_network_image/cached_network_image.dart';
import 'package:dantotsu_line/bloc/utd_chekpoint_group_leader/checkpoint_group_leader_bloc.dart';
import 'package:dantotsu_line/bloc/utd_chekpoint_group_leader/checkpoint_group_leader_event.dart';
import 'package:dantotsu_line/bloc/utd_chekpoint_group_leader/checkpoint_group_leader_state.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/model/utd/utd_checkpoint.dart';
import 'package:dantotsu_line/screen/flow_utd_inspector/widgets/atomic_serial_number.dart';
import 'package:dantotsu_line/screen/flow_utd_inspector/widgets/atomic_spacer.dart';
import 'package:dantotsu_line/screen/flow_utd_inspector/widgets/molecule_image_numbers.dart';
import 'package:dantotsu_line/screen/flow_utd_inspector/widgets/null_page_screen.dart';
import 'package:dantotsu_line/util/widget.dart';
import 'package:dantotsu_line/widgets/app_dialog.dart';
import 'package:dantotsu_line/widgets/circular_progress_widget.dart';
import 'package:dantotsu_line/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RefactorInspectionScreen extends StatefulWidget {
  final bool isInspector;
  final LoginResponse response;
  final int componentRfidID;
  final String serialNumber;

  const RefactorInspectionScreen(
      {Key key,
      this.isInspector,
      this.response,
      this.componentRfidID,
      this.serialNumber})
      : super(key: key);

  @override
  _RefactorInspectionScreenState createState() =>
      _RefactorInspectionScreenState();
}

class _RefactorInspectionScreenState extends State<RefactorInspectionScreen> {
  bool _isInspector;
  CheckpointGroupLeaderBloc _checkpointBloc;
  PageController _pageController;

  List<Checkpoint> checkpoints = [];
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
  bool isEnable = true;

  static const double _screenPadding = 20.0;

  @override
  void initState() {
    _isInspector = widget.isInspector;
    _pageController = PageController(initialPage: 1);
    _initializeBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWithoutBottomNav(context, widget.response.data.name,
          widget.response.data.privilege, widget.response.data.image),
      body: BlocConsumer(
          listener: (context, state) {
            if (state is CPILoaded) {
              showAppDialog(context, "Data berhasil disimpan!",
                  buttonText: "OK", onTap: () {
                Navigator.pop(context);
                _checkpointBloc.add(
                  FetchDetail(widget.componentRfidID),
                );
              });
            } else if (state is DetailLoaded) {
              defects = state.response.data.defects;
            } else if (state is CheckpointGroupLeaderError) {
              showAppDialog(context, state.message);
            } else if (state is CheckpointGroupLeaderEmpty) {
              showAppDialog(context, state.message);
            }
          },
          bloc: _checkpointBloc,
          builder: (context, state) {
            if (state is CheckpointGroupLeaderInitial) {
              return Container();
            }
            if (state is CheckpointGroupLeaderLoading) {
              return CircularProgressWidget();
            }
            if (state is DetailLoaded) {
              return _initializePageView(state.response.data.images);
            }

            return Container();
          }),
    );
  }

  void _initializeBloc() {
    _checkpointBloc = CheckpointGroupLeaderBloc(CheckpointGroupLeaderInitial());
    _checkpointBloc.add(FetchDetail(widget.componentRfidID));
  }

  Widget _initializePageView(List<ImageCP> images) {
    return PageView(
      controller: _pageController,
      children: images?.map((image) => _itemScreen(image)).toList() ??
          [NullPageScreen()],
    );
  }

  Widget _itemScreen(ImageCP imageCP) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: EdgeInsets.all(_screenPadding),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            (_screenPadding * 2), //top and bottom padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            AtomicSerialNumber(
              serialNumber: widget.serialNumber,
            ),
            AtomicSpacer(
              isHeight: true,
              size: 30,
            ),
            _imageAndNumbers(imageCP),
            AtomicSpacer(),
            _checkpointDropdown(imageCP),
          ],
        ),
      ),
    );
  }

  Widget _checkpointDropdown(ImageCP imagecp) {
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

  Widget _imageAndNumbers(ImageCP imageCP) {
    var comparison = double.parse(imageCP.width) /
        (MediaQuery.of(context).size.width - ((_screenPadding * 2) + 10));

    return MoleculeImageNumbers(
      imageCP: imageCP,
      children: imageCP.checkPointNumbers
          .map((e) => Positioned(
                left: double.parse(e.x) / comparison,
                bottom: double.parse(e.y) / comparison,
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
//                  defectLengthController.text = "";
//                  defectFromController.text = "";
//                  defectToController.text = "";
                    });
                  },
                ),
              ))
          .toList(),
    );
  }
}
