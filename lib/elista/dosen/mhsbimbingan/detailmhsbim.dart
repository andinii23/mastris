import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;
import '../../model/detailmhsbimbinganmodel.dart';
import '../../../siakad/settings/constant.dart';

class DetailMhsBimbingan extends StatefulWidget {
  const DetailMhsBimbingan({super.key});

  @override
  State<DetailMhsBimbingan> createState() => _DetailMhsBimbinganState();
}

class _DetailMhsBimbinganState extends State<DetailMhsBimbingan> {
  Future<DetailMhsBimbinganModel> getDetailMhsBim() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(
        Uri.parse(detailmhsbimelista + SpUtil.getString("id_mhs_pt")!),
        headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body);
      return DetailMhsBimbinganModel.fromJson(data);
    } else {
      return DetailMhsBimbinganModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TabController _tabController = TabController(length: 6, vsync: this);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Detail Bimbingan Mahasiswa",
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
      body: FutureBuilder(
          future: getDetailMhsBim(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10,),
                            child: SizedBox(
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.data.list.nama.toString(),
                                        style: TextStyle(
                                          color: mainOrangeColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.data.list.nim.toString(),
                                        style: TextStyle(
                                          color: mainBlueColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Angkatan ${snapshot.data!.data.list.angkatan.toString()}",
                                        style: TextStyle(
                                          color: mainBlueColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.data.list.namaProdi
                                            .toString(),
                                        style: TextStyle(
                                          color: mainBlueColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                        child: Divider(
                                          thickness: 2,
                                          color: mainBlackColor,
                                        ),
                                      ),
                                      Text(
                                        "Dosen Pembimbing",
                                        style: TextStyle(
                                          color: mainOrangeColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          physics: const ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.data.list
                                              .dosenPembimbing.length,
                                          itemBuilder: (context, dsn) {
                                            return Column(
                                              children: [
                                                if (snapshot
                                                        .data!
                                                        .data
                                                        .list
                                                        .dosenPembimbing[dsn]
                                                        .gelarDepan
                                                        .toString() !=
                                                    "null")
                                                  (Text(
                                                    "${snapshot.data!.data.list.dosenPembimbing[dsn].gelarDepan} ${snapshot.data!.data.list.dosenPembimbing[dsn].namaDosen} ${snapshot.data!.data.list.dosenPembimbing[dsn].gelarBelakang}",
                                                    style: TextStyle(
                                                      color: mainBlueColor,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  )),
                                                if (snapshot
                                                        .data!
                                                        .data
                                                        .list
                                                        .dosenPembimbing[dsn]
                                                        .gelarDepan
                                                        .toString() ==
                                                    "null")
                                                  (Text(
                                                    "${snapshot.data!.data.list.dosenPembimbing[dsn].namaDosen} ${snapshot.data!.data.list.dosenPembimbing[dsn].gelarBelakang}",
                                                    style: TextStyle(
                                                      color: mainBlueColor,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  )),
                                              ],
                                            );
                                          }),
                                      SizedBox(
                                        width: 40,
                                        child: Divider(
                                          thickness: 2,
                                          color: mainBlackColor,
                                        ),
                                      ),
                                      Text(
                                        "Metode Penelitian",
                                        style: TextStyle(
                                          color: mainBlueColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(snapshot.data!.data.list.penelitian
                                          .metodePenelitian
                                          .toString()),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Jenis Explanasi",
                                        style: TextStyle(
                                          color: mainBlueColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(snapshot.data!.data.list.penelitian
                                          .jenisExplanasi
                                          .toString()),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Jenis Data Penelitian",
                                        style: TextStyle(
                                          color: mainBlueColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(snapshot.data!.data.list.penelitian
                                          .jenisDataPenelitian
                                          .toString()),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Jenis Penggunaan",
                                        style: TextStyle(
                                          color: mainBlueColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(snapshot.data!.data.list.penelitian
                                          .jenisPenggunaan
                                          .toString()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Judul Skripsi",
                                  style: TextStyle(
                                    color: mainBlueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(snapshot
                                    .data!.data.list.penelitian.judulSkripsi
                                    .toString()),
                                const Divider(
                                  thickness: 2,
                                ),
                                Text(
                                  "Abstrak",
                                  style: TextStyle(
                                    color: mainBlueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  snapshot.data!.data.list.penelitian.abstrak
                                      .toString(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Expanded(
                      //   child: Container(
                      //     padding: const EdgeInsets.only(
                      //         left: 10, right: 10, bottom: 10),
                      //     height: MediaQuery.of(context).size.height / 1.6,
                      //     width: double.maxFinite,
                      //     child:
                      //         TabBarView(controller: _tabController, children: [
                      //       Text("Ringkasan Eksklusif"),
                      //       Text("Ringkasan Eksklusif"),
                      //       Text("Ringkasan Eksklusif"),
                      //       Text("Ringkasan Eksklusif"),
                      //       Text("Ringkasan Eksklusif"),
                      //       Text("Ringkasan Eksklusif"),
                      //     ]),
                      //   ),
                      // ),
                      // SizedBox(
                      //   child: TabBar(
                      //       controller: _tabController,
                      //       labelColor: mainBlackColor,
                      //       unselectedLabelColor: Colors.grey,
                      //       indicatorSize: TabBarIndicatorSize.label,
                      //       indicatorColor: mainBlueColor,
                      //       tabs: const [
                      //         Tab(
                      //           text: "Ringkasan Eksklusif",
                      //         ),
                      //         Tab(
                      //           text: "Alur Waktu Mahasiswa",
                      //         ),
                      //         Tab(
                      //           text: "Detail Usulan",
                      //         ),
                      //         Tab(
                      //           text: "Abstrak",
                      //         ),
                      //         Tab(
                      //           text: "Agenda/Log Bimbingan",
                      //         ),
                      //         Tab(
                      //           text: "File Skripsi",
                      //         ),
                      //       ]),
                      // ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
