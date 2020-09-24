import 'dart:io';import 'package:cached_network_image/cached_network_image.dart';import 'package:dantotsu_line/bloc/utd_chekpoint_group_leader/checkpoint_group_leader_bloc.dart';import 'package:dantotsu_line/bloc/utd_chekpoint_group_leader/checkpoint_group_leader_event.dart';import 'package:dantotsu_line/bloc/utd_chekpoint_group_leader/checkpoint_group_leader_state.dart';import 'package:dantotsu_line/common/colors.dart';import 'package:dantotsu_line/helper/shared_preferences_helper.dart';import 'package:dantotsu_line/model/authentication/login_response.dart';import 'package:dantotsu_line/model/utd/group_leader_checkpoint_body.dart';import 'package:dantotsu_line/model/utd/group_leader_checkpoint_response.dart';import 'package:dantotsu_line/model/utd/utd_checkpoint.dart';import 'package:dantotsu_line/services/endpoints/app_endpoints.dart';import 'package:dantotsu_line/util/widget.dart';import 'package:dantotsu_line/widgets/app_dialog.dart';import 'package:dantotsu_line/widgets/circular_progress_widget.dart';import 'package:dantotsu_line/widgets/text_widget.dart';import 'package:dio/dio.dart';import 'package:flutter/cupertino.dart';import 'package:flutter/material.dart';import 'package:flutter_bloc/flutter_bloc.dart';import 'package:image_picker/image_picker.dart';import 'package:http/http.dart' as http;import 'package:http_parser/http_parser.dart';import 'button_item.dart';class InspectionScreen extends StatefulWidget {  final LoginResponse userData;  final String serialNumber;  final int componetRfidID;  const InspectionScreen(      {Key key, this.userData, this.serialNumber, this.componetRfidID})      : super(key: key);  @override  _InspectionScreenState createState() => _InspectionScreenState();}class _InspectionScreenState extends State<InspectionScreen> {  File _image;  final picker = ImagePicker();  PageController pageController;  CheckpointGroupLeaderBloc groupLeaderBloc;  List<Checkpoint> checkpoints = [];  List<ImageCP> images = [];  List<TransferCheckPoint> transferCheckpoints = [];  List<CheckPointNumber> checkPointNumbers = [];  List<Inspector> inspectors = [];  List<Inspector> manPowers = [];  List<Model> defects = [];  String _value;  List<int> defectIds = [];  int selectedCPN = 0;  CheckPointNumber selectedCheckPointNumber;  Checkpoint selectedCheckpoint;  TransferCheckPoint transCP;  bool isRework = false;  static const double _padding = 20;  var user;  SharedPrefsHelper _sharedPrefsHelper = SharedPrefsHelper();  String token;  PageView pageView;  @override  void initState() {    user = widget.userData.data;    pageController = PageController(initialPage: 1);    groupLeaderBloc = CheckpointGroupLeaderBloc(CheckpointGroupLeaderInitial());    groupLeaderBloc.add(FetchDetail(widget.componetRfidID));    getToken();    super.initState();  }  Future<String> getToken() async {    return token = await _sharedPrefsHelper.getToken();  }  Widget initializePageView() {    return pageView = PageView(      controller: pageController,      children:          images.map((e) => _inspectionPage(e)).toList() ?? [setNullPage()],    );  }  Future<String> getUserToken(isForceRefresh) async {    String apiKey;    var savedToken = (await _sharedPrefsHelper.getToken()) ?? "";    print("savedToken = $savedToken");    if (savedToken.isNotEmpty && !isForceRefresh) {      var lastSavedToken = await _sharedPrefsHelper.getLastSavedToken();      print("lastSaved on $lastSavedToken");      var duration = DateTime.now().difference(lastSavedToken).inMinutes;      print("saved on $duration minutes ago");      if (duration > 45) {        print("refresh token");      } else {        apiKey = savedToken;      }    }    return apiKey;  }  Widget setNullPage() {    return Material(      child: Container(        child: Center(          child: TextWidget(            text: "Data is empty",            fontSize: 40,          ),        ),      ),    );  }  Future getImage() async {    final pickedFile = await picker.getImage(source: ImageSource.camera);    setState(() {      _image = File(pickedFile.path);    });  }  @override  Widget build(BuildContext context) {    return BlocConsumer(        listener: (context, state) {          if (state is DetailLoaded) {            if (state.response.data != null) {              images = state.response.data.images;              defects = state.response.data.defects;            }          } else if (state is CheckpointGroupLeaderError) {            showAppDialog(context, state.message);          } else if (state is CheckpointGroupLeaderEmpty) {            showAppDialog(context, state.message);          }        },        bloc: groupLeaderBloc,        builder: (context, state) {          if (state is CheckpointGroupLeaderInitial) {            return Container();          } else if (state is CheckpointGroupLeaderLoading) {            return CircularProgressWidget();          } else if (state is DetailLoaded) {            if (state.response.data != null) {              return initializePageView();            }          }          return Container();        });  }  Widget _inspectionPage(ImageCP imageCP) {    return Scaffold(      appBar: appbarWithoutBottomNav(          context, user.name, user.jobdesk, user.image,          isLeader: true, response: widget.userData),      body: SingleChildScrollView(        scrollDirection: Axis.vertical,        child: Container(            padding: EdgeInsets.all(_padding),            width: MediaQuery.of(context).size.width,            height: MediaQuery.of(context).size.height,            child: Column(              crossAxisAlignment: CrossAxisAlignment.start,              mainAxisAlignment: MainAxisAlignment.spaceEvenly,              children: <Widget>[                buildSerialNumber(),                buildImage(imageCP),                Row(                  crossAxisAlignment: CrossAxisAlignment.start,                  mainAxisAlignment: MainAxisAlignment.spaceBetween,                  children: <Widget>[                    buildDropDown(imageCP),                    buildInspectorManPower(),                  ],                ),                buildDetailInfo(imageCP),                buildDefectType(),                buildUploadFoto(),                buildButton(),              ],            )),      ),    );  }  Widget buildDefectType() {    return Column(      children: [        TextWidget(          text: "Pilih Tipe Defect",          fontSize: 30,          fontWeight: FontWeight.bold,        ),        Wrap(            direction: Axis.horizontal,            children: defects                .map((e) => Container(                      height: 75,                      width: 220,                      child: ButtonItem(                        defect: e,                        isSelected: (value) {                          if (value) {                            defectIds.add(e.id);                          } else {                            defectIds.remove(e.id);                          }                          print("${e.name}-${e.id} : $value");                        },                      ),                    ))                .toList()),      ],    );  }  Future<dynamic> sendForm() async {    Dio dio = Dio();    String fileName = _image.path.split("/").last;    FormData formData = FormData.fromMap({      "image": await MultipartFile.fromBytes(              File(_image.path).readAsBytesSync(),              filename: fileName)          .filename,      "defects": [1, 2],      "transferCheckPointId": 15    });    print({      "image": await MultipartFile.fromBytes(          File(_image.path).readAsBytesSync(),          filename: fileName),      "defects": [1, 2],      "transferCheckPointId": 15    });    print("tokenn $token");    dio.options.headers["Authorization"] = "Bearer ${token}";    return await dio        .post(          await AppEndpoints.postCheckpointGroupLeader(),          data: formData,          options: Options(headers: {            "Authorization": "Bearer $token",            "Content-Type": "multipart/form-data"          }),        )        .then((value) => print(value.data.toString()));  }  uploadFile() async {    var url = Uri.parse(await AppEndpoints.postCheckpointGroupLeader());    Map<String, String> headers = {      "Authorization": "Bearer $token",      "Content-Type": "multipart/form-data"    };    var request = http.MultipartRequest("POST", url);    request.headers.addAll(headers);    print("headers ${request.headers.toString()}");    request.fields["defects"] = "1";    request.fields["transferCheckPointId"] = "15";    request.files.add(await http.MultipartFile.fromPath(      'image',      _image.path,      contentType: MediaType('File', 'jpg'),    ));    print(request);    request.send().then((value) {      if (value.statusCode == 200) {        showAppDialog(context, "Proses Sukses!", buttonText: "OK");      } else if (value.statusCode == 401) {        showAppDialog(context, "Anda belum login.", buttonText: "OK");      } else {        showAppDialog(context, "Kesalahan Server");      }      print("statusCode ${value.statusCode} \n headers: ${value.headers}"          " \n headers two: ${value.request.headers} ${value.request.method}"          "\n ${value.request}"          "\n ${value.stream.isEmpty}");    });  }  Widget buildButton() {    return Container(      height: 75,      width: double.infinity,      child: FlatButton(          color: AppColors.buttonSaveColor,          onPressed: () {            if (_image?.path != null) {              showQuestionDialog(                context,                "Simpan Data",                onYes: () {//                  groupLeaderBloc.add(PostCheckpointGroupLeader(//                    GroupLeaderCpBody(//                      defectIds: defectIds,//                      transferCheckPointId: transCP.id,//                      image://                          _image.path, //TODO should be tested, either path/uri//                    ),//                  ));//                  sendForm();                  uploadFile();                  Navigator.pop(context);                },                onNo: () => Navigator.pop(context),              );            } else {              showDialog(                  context: context,                  builder: (context) {                    return Dialog(                        shape: RoundedRectangleBorder(),                        child: Container(                          height: 300,                          width: 300,                          padding: EdgeInsets.all(18),                          color: Colors.white,                          child: Column(                            children: <Widget>[                              Container(                                width: 200,                                height: 200,                                child: TextWidget(                                  text: "Belum ada foto terpilih.",                                  fontSize: 20,                                  fontWeight: FontWeight.bold,                                ),                              ),                              Expanded(                                child: Row(                                  mainAxisAlignment: MainAxisAlignment.center,                                  children: <Widget>[                                    InkWell(                                        child: Container(                                          width: 200,                                          height: 50,                                          color: Colors.orange,                                          child:                                              Center(child: Text("Coba Lagi")),                                        ),                                        onTap: () => Navigator.pop(context)),                                  ],                                ),                              )                            ],                          ),                        ));                  });            }          },          child: Text(            "Save",            style: TextStyle(                fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white),          )),    );  }  Widget buildUploadFoto() {    return Container(      width: MediaQuery.of(context).size.width,      child: Column(        crossAxisAlignment: CrossAxisAlignment.start,        children: <Widget>[          TextWidget(text: "Upload Foto", color: Colors.red, fontSize: 20),          SizedBox(            height: 8,          ),          Row(            children: <Widget>[              SizedBox(width: 10),              InkWell(                onTap: () => getImage(),                child: DecoratedBox(                  decoration: BoxDecoration(                    shape: BoxShape.rectangle,                    border: Border.all(width: 1.0, color: Colors.black),                  ),                  child: Padding(                    padding: EdgeInsets.all(10.0),                    child: Container(                      width: 40.0,                      height: 40.0,                      child: Container(                        child: Center(                          child: _image == null                              ? Text("Foto")                              : Image.file(_image),                        ),                      ),                    ),                  ),                ),              ),            ],          ),        ],      ),    );  }  Widget buildDetailInfo(ImageCP imageCP) {    return transferCheckpoints.length > 0        ? Container(            height: 210,            width: MediaQuery.of(context).size.width,            child: ListView.separated(              scrollDirection: Axis.horizontal,              itemBuilder: (context, i) {                return detailInfoItem(trfCP: transferCheckpoints[i]);              },              separatorBuilder: (context, i) {                return Divider();              },              itemCount: transferCheckpoints.length,            ))        : detailInfoItem();  }  Widget detailInfoItem({TransferCheckPoint trfCP}) {    if (trfCP != null) {      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {        setState(() {          isRework = trfCP.sequence >= 1;          transCP = trfCP;        });      });    }    return Column(      crossAxisAlignment: CrossAxisAlignment.start,      mainAxisAlignment: MainAxisAlignment.spaceEvenly,      children: <Widget>[        Visibility(          visible: isRework,          child: TextWidget(            text: trfCP != null                ? trfCP?.sequence >= 1 ? "Rework ${trfCP?.sequence}" : "" ?? ""                : "",            color: Colors.red,            fontSize: 20,          ),          replacement: Container(            height: 20,          ),        ),        Card(          elevation: 2,          child: Container(            height: 170,            padding: EdgeInsets.all(16),            width: MediaQuery.of(context).size.width * 0.9,            margin: EdgeInsets.only(right: 20),            child: Column(              crossAxisAlignment: CrossAxisAlignment.start,              children: <Widget>[                TextWidget(                  text:                      "Welding Length : ${selectedCheckpoint?.weldingLength ?? ""} mm",                  fontSize: 23,                ),                TextWidget(                  text: "Defect Length : ${trfCP?.defectLength ?? ""} mm",                  fontSize: 23,                ),                TextWidget(                  text:                      "Depth of Defect : ${trfCP?.defectDepthFrom ?? ""} - ${trfCP?.defectDepthTo ?? ""} / ${selectedCheckpoint?.depth ?? ""} mm",                  fontSize: 23,                ),                Row(                  children: [                    TextWidget(                      text: "Status : ",                      fontSize: 23,                    ),                    TextWidget(                      text: "${trfCP?.result ?? ""} ",                      fontSize: 23,                      color: trfCP?.result?.toLowerCase() == "ok"                          ? Colors.green                          : Colors.red,                    ),                  ],                ),                TextWidget(                  text: "Remark : ${trfCP?.remark ?? "-"}",                  fontSize: 23,                ),              ],            ),          ),        ),      ],    );  }  Widget buildInspectorManPower() {    if (transCP != null) {      return Row(        children: [          transCP.inspectors.length > 0              ? Container(                  height: 100,                  width: 200,                  color: Colors.blueGrey[100],                  child: ListView.separated(                      itemBuilder: (context, i) {                        return listUser("Inspector", transCP.inspectors[i]);                      },                      separatorBuilder: (context, i) {                        return Divider();                      },                      itemCount: transCP.inspectors.length),                )              : Container(                  height: 100,                  width: 200,                  color: Colors.blueGrey[100],                  child: Center(                    child: TextWidget(                      text: "No Data Inspector",                    ),                  ),                ),          VerticalDivider(            thickness: 0.2,            color: Colors.white,            width: 1.5,          ),          transCP.manPowers.length > 0              ? Container(                  height: 100,                  width: 200,                  color: Colors.blueGrey[100],                  child: ListView.separated(                      itemBuilder: (context, i) {                        return listUser("Man Power", transCP.manPowers[i]);                      },                      separatorBuilder: (context, i) {                        return Divider();                      },                      itemCount: transCP.manPowers.length),                )              : Container(                  height: 100,                  width: 200,                  color: Colors.blueGrey[100],                  child: Center(                    child: TextWidget(                      text: "No Data ManPower",                    ),                  ),                )        ],      );    } else {      return Container(        height: 150,        width: 400,        color: Colors.blueGrey[100],        child: Center(          child: TextWidget(            text: "No Data Inspector/ManPower",            fontSize: 20,          ),        ),      );    }  }  Widget listUser(String name, Inspector user) {    return Padding(      padding: const EdgeInsets.all(8.0),      child: Column(        crossAxisAlignment: CrossAxisAlignment.start,        children: <Widget>[          Center(            child: TextWidget(              text: name,            ),          ),          Row(            children: <Widget>[              Container(                height: 50,                width: 50,                child: CachedNetworkImage(                  imageUrl: user.image,                  fit: BoxFit.fitWidth,                ),              ),              SizedBox(width: 10),              Column(                children: <Widget>[                  TextWidget(                    text: user.name,                  ),                  TextWidget(                    text: user.nrp,                  ),                ],              )            ],          )        ],      ),    );  }  Widget buildDropDown(ImageCP imagecp) {    return selectedCheckPointNumber != null        ? Row(            mainAxisSize: MainAxisSize.min,            mainAxisAlignment: MainAxisAlignment.start,            children: [              TextWidget(                text: "${selectedCheckPointNumber?.number}.  " ?? "",                fontSize: 32,                fontWeight: FontWeight.bold,              ),              DropdownButton(                hint: TextWidget(                  text: "Choose Value",                  fontSize: 32,                ),                value: _value,                items: selectedCheckPointNumber.checkpoints                        .map(                          (e) => DropdownMenuItem(                            child: TextWidget(                              text: "${e.name.toString()}" ?? "No Data",                              fontSize: 32,                              fontWeight: FontWeight.bold,                            ),                            value: e.name.toString(),                            onTap: () {                              setState(() {                                selectedCheckpoint = e;                                transferCheckpoints = e.transferCheckPoints;                                transCP = null;                                print(                                    "length TCPS : ${e.transferCheckPoints.length}");                              });                            },                          ),                        )                        .toList() ??                    TextWidget(                      text: "No Data",                    ),                onChanged: (value) {                  _value = value;                  print(value);                },              ),            ],          )        : TextWidget(            text: "Silakan Pilih Checkpoint.",            fontSize: 25,          );  }  Widget buildImage(ImageCP imageCP) {    double comparison = double.parse(imageCP.width) /        (MediaQuery.of(context).size.width - ((_padding * 2) + 10));    return Stack(children: [      Container(        width: double.parse(imageCP.width),        height: double.parse(imageCP.height) / comparison,        child: CachedNetworkImage(          imageUrl: imageCP.image,          fit: BoxFit.fitWidth,        ),      ),      Container(        width: double.parse(imageCP.width),        height: double.parse(imageCP.height) / comparison,        child: Stack(          children: imageCP.checkPointNumbers              .map((e) => Positioned(                    left: double.parse(e.x) / comparison,                    bottom: double.parse(e.y) / comparison,                    child: Container(                        height: 30,                        width: 30,                        child: InkWell(                          child: Container(                            height: 20,                            width: 20,                            child: Container(                              color: Colors.red[200],                              child: Center(                                child: TextWidget(                                  text: e?.number?.toString() ?? "",                                  fontSize: 15,                                ),                              ),                            ),                          ),                          onTap: () {                            setState(() {                              _value = null;                              selectedCheckpoint = null;                              transCP = null;                              selectedCheckPointNumber = e;                            });                          },                        )),                  ))              .toList(),        ),      )    ]);  }  Widget buildSerialNumber() {    return Center(      child: RichText(        text: TextSpan(          text: "SN  ",          style: TextStyle(              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),          children: [            TextSpan(              text: widget.serialNumber ?? "",              style: TextStyle(                  color: Colors.red, fontSize: 25, fontWeight: FontWeight.bold),            )          ],        ),      ),    );  }}