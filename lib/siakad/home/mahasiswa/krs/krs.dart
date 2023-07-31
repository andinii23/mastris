
// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;
import '../../../model/krsmodel.dart';
import '../../../settings/constant.dart';

class KrsMhs extends StatefulWidget {
  const KrsMhs({super.key});

  @override
  State<KrsMhs> createState() => _KrsMhsState();
}

class _KrsMhsState extends State<KrsMhs> {
    Future<KrsModel> getKrsData() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(krs), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return KrsModel.fromJson(data);
    } else {
      return KrsModel.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "KRS Mahasiswa",
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
      body: FutureBuilder<KrsModel>(
        future: getKrsData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String awalKrs = snapshot.data!.data.list.awalKrs;
            String akhirKrs = snapshot.data!.data.list.akhirKrs;
            DateTime tanggalAwal = DateTime.parse(awalKrs);
            DateTime tanggalAkhir = DateTime.parse(akhirKrs);

            DateFormat dateFormat = DateFormat('dd-MM-yyyy');

            String tanggalAwalFormatted = dateFormat.format(tanggalAwal);
            String tanggalAkhirFormatted = dateFormat.format(tanggalAkhir);
            return SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
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
                          color: const Color(0xFF1E3B78).withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Text(
                      "Jadwal Kontrak KRS : $tanggalAwalFormatted - $tanggalAkhirFormatted",
                      style: TextStyle(
                          color: mainBlackColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (DateTime.now().isAfter(tanggalAkhir))
                    (Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.red,
                          width: 0.5,
                        ),
                      ),
                      child: const Text(
                        "Jadwal KRS Tutup",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    )),
                  const SizedBox(
                    height: 10,
                  ),
                  if (snapshot.data!.data.list.status.toString() == "3")
                    (Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        snapshot.data!.data.list.statusText.toString(),
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    )),
                  if (snapshot.data!.data.list.status.toString() == "1" ||
                      snapshot.data!.data.list.status.toString() == "2")
                    (Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: const Color.fromARGB(255, 70, 159, 233),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        snapshot.data!.data.list.statusText.toString(),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 129, 235),
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                  const SizedBox(
                    height: 10,
                  ),
                  if (snapshot.data!.data.list.status.toString() != "1" &&
                      snapshot.data!.data.list.status.toString() != "2" &&
                      DateTime.now().isBefore(tanggalAkhir))
                    if (snapshot.data!.data.list.jumlahSksKontrak != 24 &&
                        snapshot.data!.data.list.jumlahSksKontrak <= 24)
                      (Column(
                        children: [
                          (Row(
                            children: [
                              (GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'krsklsreguler');
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  width: 130,
                                  decoration: BoxDecoration(
                                    color: mainOrange2Color,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: mainWhiteColor,
                                      ),
                                      const Text(
                                        "KRS Reguler",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                              (GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'mkinbound');
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  width: 130,
                                  decoration: BoxDecoration(
                                    color: mainOrange2Color,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: mainWhiteColor,
                                      ),
                                      const Text(
                                        "KRS Inbound",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                            ],
                          )),
                          const SizedBox(
                            height: 10,
                          ),
                          (Row(
                            children: [
                              (GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'krsout');
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  width: 130,
                                  decoration: BoxDecoration(
                                    color: mainOrange2Color,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: mainWhiteColor,
                                      ),
                                      const Text(
                                        "KRS Outbound",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                            ],
                          )),
                        ],
                      )),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 15),
                          decoration: BoxDecoration(
                            color: mainBlueColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.2,
                                child: Text(
                                  "Total SKS Diambil / Jml Maks SKS : ${snapshot.data!.data.list.jumlahSksKontrak} / ${snapshot.data!.data.list.maxSks} SKS",
                                  // textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: mainWhiteColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: Text(
                                  "IP Semester Sebelumnya  : ${snapshot.data!.data.list.ipSebelumnya} SKS",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: mainWhiteColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF1E3B78).withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 4,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  snapshot.data!.data.list.listKrs.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.8,
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
                                                      .listKrs[index]
                                                      .matakuliah
                                                      .kodeMatakuliah.toString(),
                                                  style: TextStyle(
                                                    color: mainOrange2Color,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot
                                                      .data!
                                                      .data
                                                      .list
                                                      .listKrs[index]
                                                      .matakuliah
                                                      .namaMatakuliah
                                                      .toUpperCase(),
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: mainBlueColor),
                                                ),
                                                Text(
                                                  "SKS : ${snapshot.data!.data.list.listKrs[index].matakuliah.sksTotal}",
                                                  style: TextStyle(
                                                      color: mainBlueColor),
                                                ),
                                                Text(
                                                  "Kelas : ${snapshot.data!.data.list.listKrs[index].kelas?.kodeKelas.toString()}",
                                                  style: TextStyle(
                                                      color: mainBlueColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    mainBlueColor,
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                "Detail Jadwal Kuliah",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color:
                                                                        mainWhiteColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                if(snapshot.data!.data.list.listKrs[index].kelas?.hari.toString() != "null" && snapshot.data!.data.list.listKrs[index].kelas?.jamMulai.toString() != "null" && snapshot.data!.data.list.listKrs[index].kelas?.jamSelesai.toString() != "null" && snapshot.data!.data.list.listKrs[index].kelas?.ruangKuliah.namaRuang.toString() != "null")
                                                                (Text(
                                                                  "${snapshot.data!.data.list.listKrs[index].kelas?.hari}, ${snapshot.data!.data.list.listKrs[index].kelas?.jamMulai} - ${snapshot.data!.data.list.listKrs[index].kelas?.jamSelesai} \n ${snapshot.data!.data.list.listKrs[index].kelas?.ruangKuliah.namaRuang}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color:
                                                                          mainBlueColor),
                                                                )),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Text(
                                                                      "Dosen",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          color:
                                                                              mainOrange2Color,
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    SizedBox(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height /
                                                                          15,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      child: ListView.builder(
                                                                          scrollDirection: Axis.vertical,
                                                                          shrinkWrap: true,
                                                                          itemCount: snapshot.data!.data.list.listKrs[index].dosen.length,
                                                                          itemBuilder: (context, dsn) {
                                                                            if (snapshot.data!.data.list.listKrs[index].dosen[dsn].gelarDepan !=
                                                                                null) {
                                                                              return Center(
                                                                                child: Text(
                                                                                  "${snapshot.data!.data.list.listKrs[index].dosen[dsn].gelarDepan} ${snapshot.data!.data.list.listKrs[index].dosen[dsn].namaDosen} ${snapshot.data!.data.list.listKrs[index].dosen[dsn].gelarBelakang}",
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(
                                                                                    color: mainOrange2Color,
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            } else {
                                                                              return Center(
                                                                                child: Text(
                                                                                  "${snapshot.data!.data.list.listKrs[index].dosen[dsn].namaDosen} ${snapshot.data!.data.list.listKrs[index].dosen[dsn].gelarBelakang}",
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(
                                                                                    color: mainOrange2Color,
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }
                                                                          }),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            actions: [
                                                              MaterialButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                  "OK",
                                                                  style: TextStyle(
                                                                      color:
                                                                          mainBlueColor),
                                                                ),
                                                              )
                                                            ],
                                                          );
                                                        });
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .circleInfo,
                                                        color: mainBlueColor,
                                                      ),
                                                      Text(
                                                        "Detail",
                                                        style: TextStyle(
                                                            color:
                                                                mainBlueColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (snapshot.data!.data.list.status
                                                    .toString() !=
                                                "1" &&
                                            snapshot.data!.data.list.status
                                                    .toString() !=
                                                "2")
                                          (GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: SizedBox(
                                                        child: Text(
                                                          "Apakah anda yakin akan menghapus matakuliah ini?",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  mainBlackColor,
                                                              fontSize: 18),
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
                                                            _hapusKelas(snapshot
                                                                .data!
                                                                .data
                                                                .list
                                                                .listKrs[index]
                                                                .idKrs
                                                                .toString());
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
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  color: mainBlueColor,
                                                ),
                                                Text(
                                                  "Hapus",
                                                  style: TextStyle(
                                                      color: mainBlueColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          )),
                                      ],
                                    ),
                                    Divider(
                                      color: mainBlackColor,
                                    ),
                                  ],
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      snapshot.data!.data.list.listPesanKrs
                                          .first.pesan,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: mainBlackColor,
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            "Riwayat Ajuan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      //tombol kirim

                      if (snapshot.data!.data.list.status.toString() != "1" &&
                          snapshot.data!.data.list.status.toString() != "2" &&
                          DateTime.now().isBefore(tanggalAkhir) &&
                          snapshot.data!.data.list.listKrs.isNotEmpty)
                        (GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: SizedBox(
                                      child: Text(
                                        "Apakah anda yakin akan mengajukan KRS?",
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
                                          "Batal",
                                          style:
                                              TextStyle(color: mainBlueColor),
                                        ),
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          _ajukanKrs();
                                        },
                                        child: Text(
                                          "OK",
                                          style:
                                              TextStyle(color: mainBlueColor),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            width: 100,
                            decoration: BoxDecoration(
                              color: mainBlueColor,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: mainBlueColor,
                                width: 1,
                              ),
                            ),
                            child: const Text(
                              "Ajukan KRS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )
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
    );
  }

  Future _hapusKelas(String idKrs) async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(hapus_kelas + idKrs), headers: header);
    if (response.statusCode == 200) {
      // print(response.body);
      Navigator.pushNamed(context, 'krsmhs');
    } else {
      print("gagal menambahkan kelas");
      var body = jsonDecode(response.body);
      print(body["error_message"]);
    }
  }

  Future _ajukanKrs() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.post(
      Uri.parse(ajukan_krs),
      headers: header,
    );
    if (response.statusCode == 200) {
      // print(response.body);
      Navigator.pushNamed(context, 'krsmhs');
    } else {
      print("gagal menambahkan kelas");
      var body = jsonDecode(response.body);
      print(body["error_message"]);
    }
  }
}