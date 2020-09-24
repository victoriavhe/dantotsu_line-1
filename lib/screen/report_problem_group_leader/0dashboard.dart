
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dantotsu_line/bloc/utd_problem/utd_bloc.dart';
import 'package:dantotsu_line/bloc/utd_problem/utd_event.dart';
import 'package:dantotsu_line/bloc/utd_problem/utd_state.dart';
import 'package:dantotsu_line/common/colors.dart';
import 'package:dantotsu_line/helper/shared_preferences_helper.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/screen/flow_utd_group_leader/1log_pengecekan.dart';
import 'package:dantotsu_line/screen/flow_utd_inspector/0unit_produksi.dart';
import 'package:dantotsu_line/screen/login_screen.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/1opsi_masalah.dart';
import 'package:dantotsu_line/widgets/app_dialog.dart';
import 'package:dantotsu_line/widgets/circular_progress_widget.dart';
import 'package:dantotsu_line/widgets/profile_image.dart';
import 'package:dantotsu_line/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';

class DashboardReportProblem extends StatefulWidget {
  final LoginResponse loginResponse;

  const DashboardReportProblem(this.loginResponse);

  @override
  _DashboardReportProblemState createState() => _DashboardReportProblemState();
}

class _DashboardReportProblemState extends State<DashboardReportProblem> {
  WebSocketChannel channel;
  LoginResponse userData;
  UTDBloc utdBloc;
  bool isInspector, isLeader, isAdmin = false;
  Map<String, dynamic> webSocketData;
  SharedPrefsHelper sharedPrefsHelper = SharedPrefsHelper();

  @override
  void initState() {
    userData = widget?.loginResponse;

    utdBloc = UTDBloc(UTDUninitialized());
    utdBloc.add(FetchUTDProblem());
    setPrivilegeValue();

//    listenWebSocket();
//    configSocketAdhara();
    _connectSocketIO();
    super.initState();
  }

  void listenWebSocket() {
    channel = IOWebSocketChannel.connect(
        "ws://192.168.1.18:6001/v1/push-notification");
    print("channel ${channel.stream}");
    channel.stream.listen((data) {
      webSocketData = data;
      print("dataSocket $data");
    });

//    print(webSocketData["message"]);
  }


  void setPrivilegeValue() {
    if (userData.data.privilege.toLowerCase() == "leader") {
      setState(() {
        isLeader = true;
      });
    }

    if (userData.data.privilege.toLowerCase() == "inspector") {
      setState(() {
        isInspector = true;
      });
    }

    if (userData.data.privilege.toLowerCase() == "admin") {
      setState(() {
        isAdmin = true;
      });
    }
  }


//  Future<void> configSocketAdhara() async {
//    print("running");
//    SocketIOManager manager = SocketIOManager();
//    SocketIO socket = await manager.createInstance(SocketOptions('http://192.168.1.18:6001/v1/push-notification'));
//    socket.onConnect((data) {
//      print("connected..");
//      print(data);
//    });
//    print("done");
//  }


  Future<void> _initPusher() async {
    Pusher.init('appkey', PusherOptions(cluster: 'bb'));
  }


  SocketIO socketIO;

  _connectSocketIO() {
    socketIO = SocketIOManager().createSocketIO("http://192.168.1.13:6001", "");
    socketIO.init();
    socketIO.subscribe("socket_info", _onSocketInfo);
    socketIO.connect();

  }

  _onSocketInfo(dynamic data) {
    print("Socket Info " + data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Row(
          children: <Widget>[
            ProfileImage(
              imageUrl: userData?.data?.image ?? "",
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextWidget(
                  text: userData?.data?.name.toString() ?? "",
                  fontSize: 15,
                ),
                TextWidget(
                  text: userData?.data?.privilege ?? "",
                  fontSize: 15,
                ),
              ],
            )
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              utdBloc.add(Logout());
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
      body: BlocConsumer<UTDBloc, UTDState>(
        bloc: utdBloc,
        listener: (context, state) {
          if (state is UTDError) {
            showAppDialog(context, state.message);
          } else if (state is UTDEmpty) {
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
            showAppDialog(context, state.message, onTap: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
              );
            });
          }
        },
        builder: (context, state) {
          if (state is UTDLoaded) {
            if (state.unreasonTrfProblem.data.totalProblem > 0) {
              return showBody(isMoreThanOne: true);
            } else {
              return showBody(isMoreThanOne: false);
            }
          } else if (state is UTDLoading) {
            return CircularProgressWidget();
          }

          return Container();
        },
      ),
    );
  }

  Widget showBody({bool isMoreThanOne}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
          text: 'WELCOME TO IT LINE',
          fontSize: 40,
          fontWeight: FontWeight.w800,
        ),
        SizedBox(height: 20),
        LimitedBox(
          maxHeight: 700,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: showCard(
                      onPressed: () {
//                        showAppDialog(context, "Under Maintainance");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OpsiMasalahReportProblem(
                                    loginResponse: widget.loginResponse,
                                    isMoreThanOne: isMoreThanOne,
                                  )),
                        );
                      },
                      imageUrl:
                          "https://miro.medium.com/proxy/1*88Si3_5QAE_T-LZOTzQgeg.png",
                      buttonText: "Problem"),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: showCard(
                      onPressed: () {
                        isLeader
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogHasilPengecekan(
                                        loginResponse: userData)))
                            : isInspector
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UnitProduksiInspector(
                                              loginResponse: userData,
                                            )))
                                : Navigator.pop(context);
                      },
                      imageUrl:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSVe2j7Ou4mD6eKMWXHcNxEF6At0D1b0ZWXiw&usqp=CAU",
                      buttonText: "UTD"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget showCard({Function onPressed, String buttonText, String imageUrl}) {
    return FlatButton(
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.red[800],
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(5)),
      onPressed: onPressed ?? () {},
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: imageUrl ?? "",
              ),
            ),
            Text(
              buttonText ?? "",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
