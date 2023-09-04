// ignore_for_file: avoid_print

import 'dart:convert';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;
import '../../model/useridmodel.dart';
import '../../settings/constant.dart';
import '../cardapp.dart';
import '../config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<UserIdModel> getUserId() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(userId), headers: header);
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print(response.body);
      final userIdModel = userIdModelFromJson(response.body);
      SpUtil.putString("id_mhss_pt", userIdModel.data.list.idMhsPt.toString());

      return UserIdModel.fromJson(data);
    } else {
      return UserIdModel.fromJson(data);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) async {
    final fcmtoken = await FirebaseMessaging.instance.getToken();
    SpUtil.putString("fcm_token", fcmtoken!);
    print('Token Data: $fcmtoken');

    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 70, left: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "MASTRIS ",
                            style: TextStyle(
                                fontSize: 28,
                                color: Color(0xFF1E3B78),
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: const Text(
                              "Manajemen Sistem Informasi Terintegrasi Universitas Jambi",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF1E3B78),
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      // const Text(
                      //   "Logout",
                      //   style: TextStyle(
                      //       fontSize: 14,
                      //       color: Colors.black,
                      //       fontWeight: FontWeight.w700),
                      // ),
                      IconButton(
                        onPressed: () {
                          SpUtil.clear();
                          Navigator.pushNamed(context, 'login');
                        },
                        icon: const Icon(Icons.logout),
                        color: const Color(0xFF1E3B78),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    children: [
                      Text(
                        "Halaman Utama",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF1E3B78),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding: const EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xffE9561B),
                          const Color(0xffFF7D05).withOpacity(0.9),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(80),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(5, 10),
                          blurRadius: 20,
                          color: const Color(0xffFF964A).withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 20, top: 25, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Selamat Datang,",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            SpUtil.getString("name")!,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            SpUtil.getString("username")!,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.account_circle,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    SpUtil.getString("usertype")!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, 'gantipass');
                                    },
                                    child: Text(
                                      "Ganti Password?",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: mainWhiteColor,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              )
                              // Expanded(child: Container()),
                              // SizedBox(
                              //   child: Row(
                              //     children: const [
                              //       Text(
                              //         "Ganti Password",
                              //         style: TextStyle(color: Colors.white),
                              //       ),
                              //       Icon(
                              //         Icons.lock,
                              //         color: Colors.white,
                              //       )
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Text(
                        "Aplikasi Akademik",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1E3B78)),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    width: 500,
                    height: SizeConfig.screenHeight,
                    color: mainWhiteColor,
                    child: SingleChildScrollView(
                      // padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        children: [
                          // Text(
                          //   SpUtil.getString("fcm_token"),
                          //   style: TextStyle(color: mainBlackColor),
                          // ),
                          SizedBox(
                            width: SizeConfig.screenWidth,
                            child: Wrap(
                              runSpacing: 20.0,
                              spacing: 10.0,
                              alignment: WrapAlignment.start,
                              children: [
                                cardApp(
                                  icon: 'assets/img/siakad.png',
                                  label: 'Siakad',
                                  onTap: () {
                                    if (SpUtil.getString("usertype") ==
                                        "mahasiswa") {
                                      Navigator.pushNamed(context, 'navbar');
                                      setState(() {
                                        getUserId();
                                        _kirimFcm();
                                      });
                                    } else {
                                      Navigator.pushNamed(context, 'homedosen');
                                      setState(() {
                                        _kirimFcm();
                                      });
                                    }
                                  },
                                ),
                                cardApp(
                                  icon: 'assets/img/elistalogo.png',
                                  label: 'Elista',
                                  onTap: () {
                                    if (SpUtil.getString("usertype") ==
                                        "mahasiswa") {
                                      Navigator.pushNamed(context, 'homemhselista');
                                      setState(() {
                                        getUserId();
                                        _kirimFcm();
                                      });
                                    } else {
                                      // Navigator.pushNamed(context, 'homedosenelista');
                                      Navigator.pushNamed(context, 'homedosenelista');
                                      setState(() {
                                        _kirimFcm();
                                      });
                                    }
                                  },
                                ),
                                // cardApp(
                                //   icon: 'assets/img/elistalogo.png',
                                //   label: 'Surat',
                                //   onTap: () {
                                //     if (SpUtil.getString("usertype") ==
                                //         "mahasiswa") {
                                //       Navigator.pushNamed(context, 'homemhselista');
                                //       setState(() {
                                //         getUserId();
                                //         _kirimFcm();
                                //       });
                                //     } else {
                                //       // Navigator.pushNamed(context, 'homedosenelista');
                                //       Navigator.pushNamed(context, 'homedosenelista');
                                //       setState(() {
                                //         _kirimFcm();
                                //       });
                                //     }
                                //   },
                                // ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }

  Future _kirimFcm() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.post(Uri.parse(fcmtoken),
        headers: header, body: {"fcm_token": SpUtil.getString("fcm_token")});
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("gagal mengirim token");
      var body = jsonDecode(response.body);
      print(body["error_message"]);
    }
  }
}
