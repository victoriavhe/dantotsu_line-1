import 'package:cached_network_image/cached_network_image.dart';
import 'package:dantotsu_line/bloc/admin/admin_bloc.dart';
import 'package:dantotsu_line/bloc/admin/admin_event.dart';
import 'package:dantotsu_line/bloc/admin/admin_state.dart';
import 'package:dantotsu_line/helper/shared_preferences_helper.dart';
import 'package:dantotsu_line/model/config/config_body.dart';
import 'package:dantotsu_line/widgets/app_dialog.dart';
import 'package:dantotsu_line/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login_screen.dart';

class DashboardAdmin extends StatefulWidget {
  @override
  _DashboardAdminState createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  SharedPrefsHelper _prefsHelper = SharedPrefsHelper();

  TextEditingController hostController = TextEditingController();
  TextEditingController hostPortController = TextEditingController();
  TextEditingController socketPortController = TextEditingController();

  bool hasSaved = false;
  bool isVisible = false;

  AdminBloc adminBloc;

  @override
  void initState() {
    adminBloc = AdminBloc(AdminInitial());
    super.initState();
  }

  Widget buildContainer(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Visibility(
              visible: isVisible,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    DecoratedBox(
                      decoration: BoxDecoration(shape: BoxShape.rectangle),
                      child: Container(
                        width: 20,
                        height: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.green,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "  Connected",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            //
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "KI Admin",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Host",
                        style:
                            TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: hostController,
                          decoration: InputDecoration(
                            hintText: "Masukkan Host",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Host Port",
                        style:
                            TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: hostPortController,
                          decoration: InputDecoration(
                            hintText: "Masukkan Host Port",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Socket Port",
                        style:
                            TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: socketPortController,
                          decoration: InputDecoration(
                            hintText: "Masukkan Socket Port",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 70),
                    Container(
                      height: 70,
                      color: Colors.orange[900],
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          _prefsHelper.setHost(hostController.text.toString().trim());
                          _prefsHelper
                              .setHostPort(hostPortController.text.toString().trim());
                          _prefsHelper.setSocketPort(
                              socketPortController.text.toString().trim());
                          if (hasSaved) {
                            showQuestionDialog(
                              context,
                              "Update Host / Host Port / Socket Port",
                              onYes: () {
                                adminBloc.add(PostDataConfig(ConfigUpdate(
                                  host: hostController.text.toString().trim(),
                                  hostPort: hostPortController.text.toString().trim(),
                                  socketPort:
                                      socketPortController.text.toString().trim(),
                                )));
                                Navigator.pop(context);
                              },
                              onNo: () => Navigator.pop(context),
                            );
                          } else {
                            adminBloc.add(PostDataConfig(ConfigUpdate(
                              host: hostController.text.toString().trimRight(),
                              hostPort: hostPortController.text.toString().trim(),
                              socketPort: socketPortController.text.toString().trim(),
                            )));
                          }
                        },
                        child: Center(
                          child: Text(
                            hasSaved ? "Update" : "Save",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    BlocConsumer(
                      bloc: adminBloc,
                      listener: (context, state) {
                        if (state is AdminEmpty) {
                          showAppDialog(context, state.message);
                        } else if (state is AdminError) {
                          showAppDialog(context, state.message);
                        } else if (state is AdminLoaded) {
                          _prefsHelper.setHost(hostController.text.toString().trim());
                          _prefsHelper
                              .setHostPort(hostPortController.text.toString().trim());
                          _prefsHelper.setSocketPort(
                              socketPortController.text.toString().trim());
                          setState(() {
                            hasSaved = true;
                            isVisible = true;
                          });
                        }
                      },
                      builder: (context, state) {
                        if (state is AdminInitial) {
                          return Container();
                        } else if (state is AdminLoading) {
                          return Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }

                        return Container();
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    adminBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Container(
              height: _height / 20,
              child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      "https://icons-for-free.com/iconfiles/png/512/business+face+people+icon-1320086457520622872.png"),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Admin", style: TextStyle(fontSize: 17)),
                Text("Admin", style: TextStyle(fontSize: 17)),
              ],
            )
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
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
      body: Container(
        padding: EdgeInsets.all(24),
        child: buildContainer(context),
      ),
    );
  }
}
