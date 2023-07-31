import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;
import '../../../../model/krsinbound.dart';
import '../../../../settings/constant.dart';

class MkInboundPage extends StatefulWidget {
  const MkInboundPage({super.key});

  @override
  State<MkInboundPage> createState() => _MkInboundPageState();
}

class _MkInboundPageState extends State<MkInboundPage> {
    Future<KrsInboundModel> getKrsInbound() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(krs_inbound), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return KrsInboundModel.fromJson(data);
    } else {
      return KrsInboundModel.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "KRS Inbound Mahasiswa",
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
              child: FutureBuilder<KrsInboundModel>(
            future: getKrsInbound(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
            
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
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
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.data.list.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(16),
                                                topRight: Radius.circular(16),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xFF1E3B78)
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 4,
                                                  offset: const Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            padding: const EdgeInsets.all(20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.7,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        snapshot
                                                            .data!
                                                            .data
                                                            .list[index]
                                                            .matakuliah
                                                            .namaMatakuliah.toUpperCase(),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            color:
                                                                mainBlueColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "Prodi : ${snapshot.data!.data.list[index].prodi.namaProdi}",
                                                        style: TextStyle(
                                                            color:
                                                                mainBlueColor),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "SKS : ${snapshot.data!.data.list[index].matakuliah.sksTotal}",
                                                        style: TextStyle(
                                                            color:
                                                                mainBlueColor),
                                                      ),
                                                      // const SizedBox(
                                                      //   width: 10,
                                                      // ),
                                                      // Text(
                                                      //   "Semester : ${snapshot.data!.data.list[index].semester}",
                                                      //   style: TextStyle(
                                                      //       color:
                                                      //           mainBlueColor),
                                                      // ),
                                                      // const SizedBox(
                                                      //   height: 10,
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: mainOrange2Color,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      _idMatakuliah(snapshot
                                                          .data!
                                                          .data
                                                          .list[index]
                                                          .matakuliah.idMatakuliah
                                                          .toString());
                                                    },
                                                    child: SizedBox(
                                                      width: 40,
                                                      child: Text(
                                                        "Pilih",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: mainWhiteColor,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                );
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

  Future _idMatakuliah(String idMatakuliah) async {
    SpUtil.putString("id_matakuliah", idMatakuliah);
    Navigator.pushNamed(context, 'listklsinb');
  }
}