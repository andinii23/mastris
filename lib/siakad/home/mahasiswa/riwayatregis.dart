import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;
import '../../model/riwayatregistrasimodel.dart';
import '../../settings/constant.dart';

class RiwayatregistrasiPage extends StatefulWidget {
  const RiwayatregistrasiPage({super.key});

  @override
  State<RiwayatregistrasiPage> createState() => _RiwayatregistrasiPageState();
}

class _RiwayatregistrasiPageState extends State<RiwayatregistrasiPage> {
  Future<RegisterModel> getRegisData() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(register), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return RegisterModel.fromJson(data);
    } else {
      return RegisterModel.fromJson(data);
      
    }
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Riwayat Registrasi Mahasiswa",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 20, color: mainBlackColor, fontWeight: FontWeight.w700),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<RegisterModel>(
            future: getRegisData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.data.list.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              height: 80,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF1E3B78)
                                        .withOpacity(0.1),
                                    spreadRadius: 5,
                                    blurRadius: 4,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children:  <Widget>[
                                      Text(
                                        "Semester",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xffE9561B)),
                                      ),
                                      Text(
                                        "Status Registrasi",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xffE9561B)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data!.data.list[index]
                                            .semesterText,
                                        style: const TextStyle(
                                            color: Color(0xFF1E3B78)),
                                      ),
                                      Text(
                                          snapshot.data!.data.list[index]
                                              .statusMahasiswaText
                                              .toString(),
                                          style: const TextStyle(
                                              color: Color(0xFF1E3B78))),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            LayoutBuilder(builder: (context, contraints) {
                              return Flex(
                                direction: Axis.horizontal,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  (contraints.constrainWidth() / 10).floor(),
                                  (index) => const SizedBox(
                                    height: 1,
                                    width: 5,
                                    child: DecoratedBox(
                                        decoration:
                                            BoxDecoration(color: Colors.white)),
                                  ),
                                ),
                              );
                            }),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(10),
                              height: 70,
                              decoration: const BoxDecoration(
                                color: Color(0xFF1E3B78),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    "Tanggal Registrasi",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    snapshot.data!.data.list[index].tglDaftar
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ))
        ],
      ),
    );
  }
}