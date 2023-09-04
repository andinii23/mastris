// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;
import '../../model/biomhsmodel.dart';
import '../../settings/constant.dart';

class BiodataMhs extends StatefulWidget {
  const BiodataMhs({super.key});

  @override
  State<BiodataMhs> createState() => _BiodataMhsState();
}

class _BiodataMhsState extends State<BiodataMhs> with TickerProviderStateMixin {
  Future<BioMhsModel> getBioMhsData() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(biodata), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // final bioMhsModel = bioMhsModelFromJson(response.body);
      // SpUtil.putString("id_mhs_ptt", bioMhsModel.data.list.idMhsPt.toString());
      // print(response.body);
      return BioMhsModel.fromJson(data);
    } else {
      return BioMhsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Biodata Mahasiswa",
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
            Navigator.pushNamed(context, 'navbar');
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            child: TabBar(
                controller: _tabController,
                labelColor: mainBlackColor,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: mainBlueColor,
                tabs: const [
                  Tab(
                    text: "Data Personal",
                  ),
                  Tab(
                    text: "Data Orang Tua / Wali",
                  )
                ]),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              height: MediaQuery.of(context).size.height / 1.6,
              width: double.maxFinite,
              child: TabBarView(
                controller: _tabController,
                children: [
                  FutureBuilder<BioMhsModel>(
                    future: getBioMhsData(),
                    builder: (context, snapshot) {
                      String tglLahir = snapshot.data!.data.list.tanggalLahir;
                      DateTime tglLahirD = DateTime.parse(tglLahir);

                      DateFormat dateFormat = DateFormat('dd-MM-yyyy');
                      String tgllahirFormatted = dateFormat.format(tglLahirD);
                    
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Data Pokok Mahasiswa",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: mainBlueColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      "Nama",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: mainOrange2Color,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    padding: const EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
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
                                    child: Text(
                                      snapshot.data!.data.list.namaMahasiswa
                                          .toString(),
                                      style: TextStyle(
                                        color: mainBlackColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      "Tempat Lahir",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: mainOrange2Color,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    padding: const EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
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
                                    child: Text(
                                      snapshot.data!.data.list.tempatLahir
                                          .toString(),
                                      style: TextStyle(
                                        color: mainBlackColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      "Tanggal Lahir",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: mainOrange2Color,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    padding: const EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
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
                                    child: Text(
                                      tgllahirFormatted.toString(),
                                      style: TextStyle(
                                        color: mainBlackColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      "Alamat",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: mainOrange2Color,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    padding: const EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
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
                                    child: Text(
                                      snapshot.data!.data.list.alamat
                                          .toString(),
                                      style: TextStyle(
                                        color: mainBlackColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      "Email",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: mainOrange2Color,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    padding: const EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
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
                                    child: Text(
                                      snapshot.data!.data.list.email.toString(),
                                      style: TextStyle(
                                        color: mainBlackColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Text(
                                          "RT",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: mainOrange2Color,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot.data!.data.list.rt
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          )),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Text(
                                          "Dusun",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: mainOrange2Color,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot.data!.data.list.dusun
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Text(
                                          "Kelurahan",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: mainOrange2Color,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot.data!.data.list.kelurahan
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          )),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Text(
                                          "Kode Pos",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: mainOrange2Color,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot.data!.data.list.kodePos
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Text(
                                          "Telepon",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: mainOrange2Color,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot.data!.data.list.telepon1
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          )),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Text(
                                          "Jumlah Saudara",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: mainOrange2Color,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot
                                                .data!.data.list.jumlahSaudara
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Text(
                                          "Hobi",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: mainOrange2Color,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot.data!.data.list.hobi
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          )),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Text(
                                          "Golongan Darah",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: mainOrange2Color,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot
                                                .data!.data.list.golonganDarah
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  // Data Orang Tua
                  FutureBuilder<BioMhsModel>(
                    future: getBioMhsData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String tglLahirAyah =
                            snapshot.data!.data.list.tanggalLahirAyah;
                        DateTime tglLahirDAyah = DateTime.parse(tglLahirAyah);
                        String tglLahirIbu =
                            snapshot.data!.data.list.tanggalLahirIbu;
                        DateTime tglLahirDIbu = DateTime.parse(tglLahirIbu);

                        DateFormat dateFormat = DateFormat('dd-MM-yyyy');

                        String tgllahirAyahFormatted =
                            dateFormat.format(tglLahirDAyah);
                        String tgllahirIbuFormatted =
                            dateFormat.format(tglLahirDIbu);
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 241, 240, 240),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Biodata Ayah",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: mainBlueColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Nama Ayah",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot.data!.data.list.namaAyah
                                                .toString(),
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Tanggal Lahir Ayah",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            tgllahirAyahFormatted.toString(),
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "No Telepon Ayah",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot.data!.data.list.teleponAyah
                                                .toString(),
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Pekerjaan Ayah",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot.data!.data.list
                                                .pekerjaanAyah.namaPekerjaan
                                                .toString(),
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Jenjang Pendidikan Ayah",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot
                                                .data!
                                                .data
                                                .list
                                                .jenjangPendidikanAyah
                                                .namaJenjangPendidikan
                                                .toString(),
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Penghasilan Ayah",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot.data!.data.list
                                                .penghasilanAyah.namaPenghasilan
                                                .toString(),
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              //Data Ibu
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 241, 240, 240),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Biodata Ibu",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: mainBlueColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Nama Ibu",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot.data!.data.list.namaIbu
                                                .toString(),
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Tanggal Lahir Ibu",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            tgllahirIbuFormatted.toString(),
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "No Telepon Ibu",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        if (snapshot.data!.data.list.teleponIbu
                                                .toString() !=
                                            "null")
                                          (Container(
                                            margin: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            padding: const EdgeInsets.all(10),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                            child: Text(
                                              snapshot
                                                  .data!.data.list.teleponIbu
                                                  .toString(),
                                              style: TextStyle(
                                                color: mainBlackColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          )),
                                        if (snapshot.data!.data.list.teleponIbu
                                                .toString() ==
                                            "null")
                                          (Container(
                                            margin: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            padding: const EdgeInsets.all(10),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                color: mainBlackColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          )),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Pekerjaan Ibu",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot.data!.data.list
                                                .pekerjaanIbu.namaPekerjaan
                                                .toString(),
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Jenjang Pendidikan Ibu",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot
                                                .data!
                                                .data
                                                .list
                                                .jenjangPendidikanIbu
                                                .namaJenjangPendidikan
                                                .toString(),
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Penghasilan Ibu",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot.data!.data.list
                                                .penghasilanIbu.namaPenghasilan
                                                .toString(),
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              //Data Wali
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 241, 240, 240),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Biodata Wali",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: mainBlueColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Nama Wali",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        if (snapshot.data!.data.list.namaWali
                                                .toString() !=
                                            "null")
                                          (Container(
                                            margin: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            padding: const EdgeInsets.all(10),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                            child: Text(
                                              snapshot.data!.data.list.namaWali
                                                  .toString(),
                                              style: TextStyle(
                                                color: mainBlackColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          )),
                                        if (snapshot.data!.data.list.namaWali
                                                .toString() ==
                                            "null")
                                          (Container(
                                            margin: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            padding: const EdgeInsets.all(10),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                color: mainBlackColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          )),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Tanggal Lahir Wali",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot.data!.data.list
                                                .tanggalLahirWali
                                                .toString(),
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Pekerjaan Wali",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        if (snapshot.data!.data.list
                                                .pekerjaanWali.namaPekerjaan
                                                .toString() !=
                                            "null")
                                          (Container(
                                            margin: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            padding: const EdgeInsets.all(10),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                            child: Text(
                                              snapshot.data!.data.list
                                                  .pekerjaanWali.namaPekerjaan
                                                  .toString(),
                                              style: TextStyle(
                                                color: mainBlackColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          )),
                                        if (snapshot.data!.data.list
                                                .pekerjaanWali.namaPekerjaan
                                                .toString() ==
                                            "null")
                                          (Container(
                                            margin: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            padding: const EdgeInsets.all(10),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                color: mainBlackColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          )),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Jenjang Pendidikan Wali",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot
                                                .data!
                                                .data
                                                .list
                                                .jenjangPendidikanWali
                                                .namaJenjangPendidikan
                                                .toString(),
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Penghasilan Wali",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          padding: const EdgeInsets.all(10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          child: Text(
                                            snapshot.data!.data.list
                                                .penghasilanWali.namaPenghasilan
                                                .toString(),
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
