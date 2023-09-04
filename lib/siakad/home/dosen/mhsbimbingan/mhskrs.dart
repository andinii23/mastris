// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_final_fields, unused_local_variable, avoid_print, use_build_context_synchronously, body_might_complete_normally_nullable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mastrisunja/siakad/home/dosen/mhsbimbingan/mhsbimbingan.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;
import '../../../model/krsmhsdosen.dart';
import '../../../model/semester/ketsemmodel.dart';
import '../../../settings/constant.dart';

class MhsKrsDosen extends StatefulWidget {
  const MhsKrsDosen({super.key});

  @override
  State<MhsKrsDosen> createState() => _MhsKrsDosenState();
}

class _MhsKrsDosenState extends State<MhsKrsDosen> {
  TextEditingController _pesanController = TextEditingController();

  @override
  void dispose() {
    _pesanController.dispose();
    super.dispose();
  }

  Future<KetSemesterModel> getSem() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(semester), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body);
      return KetSemesterModel.fromJson(data);
    } else {
      return KetSemesterModel.fromJson(data);
    }
  }

  Future<KrsMhsDosenModel> getDetailKrsMhs() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(
        Uri.parse(krs_mhs_bimbingan + SpUtil.getString("id_mhs_pt")!),
        headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return KrsMhsDosenModel.fromJson(data);
    } else {
      return KrsMhsDosenModel.fromJson(data);
    }
  }

  Future<void> _refreshPage() async {
    // Call the function to fetch the latest data
    await getDetailKrsMhs();

    // Force the widget to rebuild with the latest data
    setState(() {});
  }

  final _formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "KRS Mahasiswa Bimbingan",
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
            // Navigator.pushNamed(context, 'mhsbimbingan');
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const MhsBimbingan();
            }));
            // Navigator.pop(context);
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshPage,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: FutureBuilder(
                  future: getSem(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        "KRS Mahasiswa Semester : ${snapshot.data!.data.list[0].semesterText}",
                        style: TextStyle(
                            color: mainOrange2Color,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      );
                    } else {
                      return const Text("");
                    }
                  }),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: FutureBuilder(
                  future: getDetailKrsMhs(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // String awalKprs = snapshot.data!.data.list.krs.awalKprs;
                      // String akhirKprs = snapshot.data!.data.list.krs.akhirKprs;
                      // DateTime tanggalAwalKprs = DateTime.parse(awalKprs);
                      // DateTime tanggalAkhirKprs = DateTime.parse(akhirKprs);

                      String? awalKrs = snapshot.data!.data?.list?.krs?.awalKrs;
                      String? akhirKrs =
                          snapshot.data!.data!.list!.krs!.akhirKrs;
                      DateTime tanggalAwalKrs = DateTime.parse(awalKrs!);
                      DateTime tanggalAkhirKrs = DateTime.parse(akhirKrs!);

                      DateFormat dateFormat = DateFormat('dd-MM-yyyy');

                      // String tanggalAwalFormattedKprs =
                      //     dateFormat.format(tanggalAwalKprs);
                      // String tanggalAkhirFormattedKprs =
                      //     dateFormat.format(tanggalAkhirKprs);

                      String tanggalAwalFormattedKrs =
                          dateFormat.format(tanggalAwalKrs);
                      String tanggalAkhirFormattedKrs =
                          dateFormat.format(tanggalAkhirKrs);

                      return SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width,
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
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: 140,
                                          child: Text(
                                            "Nama Mahasiswa",
                                            style: TextStyle(
                                                color: mainBlueColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      SizedBox(
                                        width: 15,
                                        child: Text(
                                          ":",
                                          style: TextStyle(
                                              color: mainBlueColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 170,
                                        child: Text(
                                          snapshot
                                              .data!.data!.list!.namaMahasiswa!,
                                          style: TextStyle(
                                              color: mainBlueColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 140,
                                        child: Text(
                                          "NIM Mahasiswa",
                                          style: TextStyle(
                                              color: mainBlueColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                        child: Text(
                                          ":",
                                          style: TextStyle(
                                              color: mainBlueColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 170,
                                        child: Text(
                                          snapshot
                                              .data!.data!.list!.noMahasiswa!,
                                          style: TextStyle(
                                              color: mainBlueColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 140,
                                        child: Text(
                                          "Program Studi",
                                          style: TextStyle(
                                              color: mainBlueColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                        child: Text(
                                          ":",
                                          style: TextStyle(
                                              color: mainBlueColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 170,
                                        child: Text(
                                          snapshot.data!.data!.list!.prodi!
                                              .namaProdi!
                                              .toString(),
                                          style: TextStyle(
                                            color: mainBlueColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 140,
                                        child: Text(
                                          "Angkatan",
                                          style: TextStyle(
                                              color: mainBlueColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                        child: Text(
                                          ":",
                                          style: TextStyle(
                                              color: mainBlueColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 170,
                                        child: Text(
                                          snapshot.data!.data!.list!.angkatan!,
                                          style: TextStyle(
                                            color: mainBlueColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 140,
                                        child: Text(
                                          "Status",
                                          style: TextStyle(
                                              color: mainBlueColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                        child: Text(
                                          ":",
                                          style: TextStyle(
                                              color: mainBlueColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 170,
                                        child: Text(
                                          snapshot
                                              .data!.data!.list!.statusText!,
                                          style: TextStyle(
                                            color: mainBlueColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: mainWhiteColor,
                                borderRadius: BorderRadius.circular(5),
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
                              child: Text(
                                "Jadwal Kontrak KRS : $tanggalAwalFormattedKrs - $tanggalAkhirFormattedKrs",
                                style: TextStyle(
                                    color: mainBlackColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (snapshot.data!.data!.list!.krs!.statusKrs
                                    .toString() ==
                                "1")
                              (Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: mainWhiteColor,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  snapshot
                                      .data!.data!.list!.krs!.statusKrsText!,
                                  style: TextStyle(
                                    color: mainBlackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                            if (snapshot.data!.data!.list!.krs!.statusKrs
                                    .toString() ==
                                "2")
                              (Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: mainWhiteColor,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      snapshot.data!.data!.list!.krs!
                                          .statusKrsText!,
                                      style: TextStyle(
                                        color: mainWhiteColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "(${snapshot.data!.data!.list!.krs!.tanggal})",
                                      style: TextStyle(
                                        color: mainWhiteColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                            if (snapshot.data!.data!.list!.krs!.statusKrs
                                    .toString() ==
                                "3")
                              (Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: mainWhiteColor,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  snapshot
                                      .data!.data!.list!.krs!.statusKrsText!,
                                  style: TextStyle(
                                    color: mainWhiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                            if (snapshot.data!.data!.list!.krs!.statusKrs
                                    .toString() !=
                                "3")
                              (Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
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
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: mainWhiteColor,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                color: mainOrange2Color,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                ),
                                              ),
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                "List Matakuliah",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: mainWhiteColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            ListView.builder(
                                                physics: const ScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: snapshot.data!.data!
                                                    .list!.krs!.listKrs!.length,
                                                itemBuilder: (context, mk) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 8),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: const Color(
                                                                        0xFF1E3B78)
                                                                    .withOpacity(
                                                                        0.1),
                                                                spreadRadius: 5,
                                                                blurRadius: 4,
                                                                offset: const Offset(
                                                                    0,
                                                                    3), // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${snapshot.data!.data!.list!.krs!.listKrs![mk].matakuliah!.kodeMatakuliah} : ${snapshot.data!.data!.list!.krs!.listKrs![mk].matakuliah!.namaMatakuliah}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color:
                                                                        mainBlackColor,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              if (snapshot
                                                                      .data!
                                                                      .data!
                                                                      .list!
                                                                      .krs!
                                                                      .listKrs![
                                                                          mk]
                                                                      .kelas!
                                                                      .kodeKelas
                                                                      .toString() !=
                                                                  "null")
                                                                (Text(
                                                                  "Ruang ${snapshot.data!.data!.list!.krs!.listKrs![mk].kelas!.kodeKelas.toString()}",
                                                                  style: TextStyle(
                                                                      color:
                                                                          mainBlackColor),
                                                                )),
                                                              if (snapshot
                                                                      .data!
                                                                      .data!
                                                                      .list!
                                                                      .krs!
                                                                      .listKrs![
                                                                          mk]
                                                                      .kelas!
                                                                      .kodeKelas
                                                                      .toString() ==
                                                                  "null")
                                                                (Text(
                                                                  "Ruang -",
                                                                  style: TextStyle(
                                                                      color:
                                                                          mainBlackColor),
                                                                )),
                                                              if (snapshot
                                                                      .data!
                                                                      .data!
                                                                      .list!
                                                                      .krs!
                                                                      .listKrs![
                                                                          mk]
                                                                      .kelas!
                                                                      .semester
                                                                      .toString() !=
                                                                  "null")
                                                                (Text(
                                                                  "Semester ${snapshot.data!.data!.list!.krs!.listKrs![mk].kelas!.semester.toString()}",
                                                                  style: TextStyle(
                                                                      color:
                                                                          mainBlackColor),
                                                                )),
                                                              if (snapshot
                                                                      .data!
                                                                      .data!
                                                                      .list!
                                                                      .krs!
                                                                      .listKrs![
                                                                          mk]
                                                                      .kelas!
                                                                      .semester
                                                                      .toString() ==
                                                                  "null")
                                                                (Text(
                                                                  "Semester -",
                                                                  style: TextStyle(
                                                                      color:
                                                                          mainBlackColor),
                                                                )),
                                                              Text(
                                                                "${snapshot.data!.data!.list!.krs!.listKrs![mk].matakuliah!.sksTotal} SKS",
                                                                style: TextStyle(
                                                                    color:
                                                                        mainBlackColor),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                })
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                            // tanggal refisi
                            if (snapshot.data!.data!.list!.krs!.statusKrs
                                        .toString() ==
                                    "1" &&
                                DateTime.now().isAfter(tanggalAkhirKrs))
                              (Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: SizedBox(
                                                  child: TextFormField(
                                                    controller:
                                                        _pesanController,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText: "Pesan",
                                                            hintText: "Pesan",
                                                            border:
                                                                OutlineInputBorder()),
                                                  ),
                                                ),
                                                actions: [
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "Batal",
                                                      style: TextStyle(
                                                          color: mainBlueColor),
                                                    ),
                                                  ),
                                                  MaterialButton(
                                                    onPressed: () {
                                                      _tolakMk();
                                                    },
                                                    child: Text(
                                                      "OK",
                                                      style: TextStyle(
                                                          color: mainBlueColor),
                                                    ),
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      child: Container(
                                          width: 80,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            "Refisi",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: mainBlackColor),
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: SizedBox(
                                                  child: Text(
                                                    "Apakah anda yakin menyetujui KRS ini?",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: mainBlackColor,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                actions: [
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "Tidak",
                                                      style: TextStyle(
                                                          color: mainBlueColor),
                                                    ),
                                                  ),
                                                  MaterialButton(
                                                    onPressed: () {
                                                      _terimaMk();
                                                    },
                                                    child: Text(
                                                      "Ya",
                                                      style: TextStyle(
                                                          color: mainBlueColor),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      child: Container(
                                          width: 80,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: mainBlueColor,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            "Terima",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: mainWhiteColor),
                                          )),
                                    ),
                                  ],
                                ),
                              )),
                            if (snapshot.data!.data!.list!.krs!.akhirKprs != "")
                              if (DateTime.now().isAfter(
                                  snapshot.data!.data!.list!.krs!.akhirKprs))
                                if (snapshot.data!.data!.list!.krs!.statusKrs
                                        .toString() ==
                                    "2")
                                  (Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: SizedBox(
                                                      child: Form(
                                                        key: _formState,
                                                        child: TextFormField(
                                                          controller:
                                                              _pesanController,
                                                          validator: (value) {
                                                            if (value == '') {
                                                              return "pesan harus diisi!!";
                                                            }
                                                          },
                                                          decoration:
                                                              const InputDecoration(
                                                                  labelText:
                                                                      "Pesan",
                                                                  hintText:
                                                                      "Pesan",
                                                                  border:
                                                                      OutlineInputBorder()),
                                                        ),
                                                      ),
                                                    ),
                                                    actions: [
                                                      MaterialButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          "Batal",
                                                          style: TextStyle(
                                                              color:
                                                                  mainBlueColor),
                                                        ),
                                                      ),
                                                      MaterialButton(
                                                        onPressed: () {
                                                          if (_formState
                                                              .currentState!
                                                              .validate()) {
                                                            _tolakMk();
                                                          } else {
                                                            print(
                                                                "validasi gagal");
                                                          }
                                                        },
                                                        child: Text(
                                                          "OK",
                                                          style: TextStyle(
                                                              color:
                                                                  mainBlueColor),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: Container(
                                              width: 80,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.yellow,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                "Refisi",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: mainBlackColor),
                                              )),
                                        ),
                                      ],
                                    ),
                                  )),
                            if (snapshot.data!.data!.list!.krs!.statusKrs
                                    .toString() ==
                                "3")
                              (const Text(""))
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future _terimaMk() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response =
        await http.post(Uri.parse(terima_krs), headers: header, body: {
      "id_mhs_pt": SpUtil.getString("id_mhs_pt"),
      "status": "2",
    });
    if (response.statusCode == 200) {
      print(response.body);
      // Navigator.pushNamed(context, 'mhskrsdosen');
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //   return const MhsKrsDosen();
      // }));
      Navigator.pop(context);
      setState(() {});
    } else {
      print("gagal menambahkan kelas");
      var body = jsonDecode(response.body);
      print(body["error_message"]);
    }
  }

  Future _tolakMk() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response =
        await http.post(Uri.parse(terima_krs), headers: header, body: {
      "id_mhs_pt": SpUtil.getString("id_mhs_pt"),
      "status": "3",
      "pesan": _pesanController.text,
    });
    if (response.statusCode == 200) {
      print(response.body);
      // Navigator.pushNamed(context, 'mhskrsdosen');
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //   return const MhsKrsDosen();
      // }));
      Navigator.pop(context);
      setState(() {});
    } else {
      print("gagal menambahkan kelas");
      var body = jsonDecode(response.body);
      print(body["error_message"]);
    }
  }
}
