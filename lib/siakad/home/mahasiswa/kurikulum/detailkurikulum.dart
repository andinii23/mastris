import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';

import '../../../model/detailkurikulummodel.dart';
import '../../../settings/constant.dart';

class DetailKurikulumMhs extends StatefulWidget {
  const DetailKurikulumMhs({super.key});

  @override
  State<DetailKurikulumMhs> createState() => _DetailKurikulumMhsState();
}

class _DetailKurikulumMhsState extends State<DetailKurikulumMhs> {
  Future<DetailKurikulum> getDetailKurikulum() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(
        Uri.parse(dkurikulum + SpUtil.getString("semester")!),
        headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return DetailKurikulum.fromJson(data);
    } else {
      return DetailKurikulum.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Kurikulum Mahasiswa",
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
            child: FutureBuilder(
              future: getDetailKurikulum(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            if(snapshot.data!.data.list.listMataKuliah.isNotEmpty)
                            (Text(
                              "Daftar Kurikulum Semester ${snapshot.data!.data.list.listMataKuliah.first.semester!}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: mainBlueColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                          ],
                        ),
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot
                                  .data!.data.list.listMataKuliah.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
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
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.9,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .data
                                                        .list
                                                        .listMataKuliah[index]
                                                        .kodeMatakuliah
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: mainOrange2Color,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .data
                                                        .list
                                                        .listMataKuliah[index]
                                                        .namaMatakuliah
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        color: mainBlueColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .data
                                                        .list
                                                        .listMataKuliah[index]
                                                        .sksTotal
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: mainBlueColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 60,
                                                  child: Text(
                                                    "Ket. SKS",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            mainOrange2Color),
                                                  ),
                                                ),
                                                if (snapshot
                                                        .data!
                                                        .data
                                                        .list
                                                        .listMataKuliah[index]
                                                        .wajib
                                                        .toString() ==
                                                    "0")
                                                  (Text(
                                                    "Pilihan",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: mainBlueColor),
                                                  )),
                                                if (snapshot
                                                        .data!
                                                        .data
                                                        .list
                                                        .listMataKuliah[index]
                                                        .wajib
                                                        .toString() ==
                                                    "1")
                                                  (Text(
                                                    "Wajib",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: mainBlueColor),
                                                  )),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      width: 60,
                                                      child: Text(
                                                        "Nilai\nTertinggi",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                mainOrange2Color),
                                                      ),
                                                    ),
                                                    if (snapshot
                                                            .data!
                                                            .data
                                                            .list
                                                            .listMataKuliah[
                                                                index]
                                                            .nilaiTertinggi
                                                            .toString() ==
                                                        "null")
                                                      (Text(
                                                        "-",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                mainBlueColor),
                                                      )),
                                                    if (snapshot
                                                            .data!
                                                            .data
                                                            .list
                                                            .listMataKuliah[
                                                                index]
                                                            .nilaiTertinggi
                                                            .toString() !=
                                                        "null")
                                                      (Text(
                                                        snapshot
                                                            .data!
                                                            .data
                                                            .list
                                                            .listMataKuliah[
                                                                index]
                                                            .nilaiTertinggi
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                mainBlueColor),
                                                      )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }))
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
