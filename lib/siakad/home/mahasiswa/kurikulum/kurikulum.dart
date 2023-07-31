import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/kurikulum/semestercard.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;
import '../../../model/kurikulummodel.dart';
import '../../../settings/constant.dart';
import '../../config.dart';

class KurikulumMhs extends StatefulWidget {
  const KurikulumMhs({super.key});

  @override
  State<KurikulumMhs> createState() => _KurikulumMhsState();
}

class _KurikulumMhsState extends State<KurikulumMhs> {
  Future<KurikulumModel> getKurikulumData() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(kurikulum), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body);
      return KurikulumModel.fromJson(data);
    } else {
      return KurikulumModel.fromJson(data);
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
      body: FutureBuilder<KurikulumModel>(
          future: getKurikulumData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      // color: Colors.amber,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  "Nama Kurikulum",
                                  style: TextStyle(
                                      color: mainBlueColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ": ${snapshot.data!.data.list.namaKurikulum.toUpperCase()}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: mainBlueColor,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  "SKS Wajib",
                                  style: TextStyle(
                                      color: mainBlueColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  ": ${snapshot.data!.data.list.jumlahSksWajib}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: mainBlueColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  "SKS Pilihan",
                                  style: TextStyle(
                                      color: mainBlueColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  ": ${snapshot.data!.data.list.jumlahSksPilihan}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: mainBlueColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  "Total SKS",
                                  style: TextStyle(
                                      color: mainBlueColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  ": ${snapshot.data!.data.list.totalSks}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: mainBlueColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  "Total SKS Selesai",
                                  style: TextStyle(
                                      color: mainBlueColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  ": ${snapshot.data!.data.list.sksSelesai}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: mainBlueColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: mainBlackColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Daftar Kurikulum Berdasarkan Semester",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: mainOrange2Color),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.screenWidth,
                      child: Wrap(
                        runSpacing: 20.0,
                        spacing: 10.0,
                        alignment: WrapAlignment.start,
                        children: [
                          semesterCard(
                              label: "Semester 1",
                              onTap: () {
                                _detailKur("1");
                              }),
                          semesterCard(
                              label: "Semester 2",
                              onTap: () {
                                _detailKur("2");
                              }),
                          semesterCard(
                              label: "Semester 3",
                              onTap: () {
                                _detailKur("3");
                              }),
                          semesterCard(
                              label: "Semester 4",
                              onTap: () {
                                _detailKur("4");
                              }),
                          semesterCard(
                              label: "Semester 5",
                              onTap: () {
                                _detailKur("5");
                              }),
                          semesterCard(
                              label: "Semester 6",
                              onTap: () {
                                _detailKur("6");
                              }),
                          semesterCard(
                              label: "Semester 7",
                              onTap: () {
                                _detailKur("7");
                              }),
                          semesterCard(
                              label: "Semester 8",
                              onTap: () {
                                _detailKur("8");
                              }),
                        ],
                      ),
                    )
                  ],
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

  Future _detailKur(String semester) async {
    SpUtil.putString("semester", semester);
    Navigator.pushNamed(context, 'detailkur');
  }
}
