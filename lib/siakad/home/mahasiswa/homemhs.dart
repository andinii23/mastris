// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';
import '../../model/homemhsmodel.dart';
import '../../settings/constant.dart';
import '../config.dart';

class HomeMhs extends StatefulWidget {
  const HomeMhs({super.key});

  @override
  State<HomeMhs> createState() => _HomeMhsState();
}

class _HomeMhsState extends State<HomeMhs> {
  Future<HomeModel> getHomeData() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(home), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return HomeModel.fromJson(data);
    } else {
      return HomeModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<HomeModel>(
          future: getHomeData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: ClipPathClass(),
                      child: Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xffE9561B),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "homepage");
                              },
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 69, left: 29),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: mainWhiteColor,
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 70,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Selamat Datang, ",
                                      style: const TextStyle(fontSize: 18),
                                      children: [
                                        TextSpan(
                                          text: snapshot
                                              .data!.data.list.namaMahasiswa
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 110),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              ClipPath(
                                clipper: ClipInfoClass(),
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  // height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xff005689)
                                            .withOpacity(0.9),
                                        const Color(0xFF1E3B78),
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data!.data.list
                                                      .noMahasiswa,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: mainWhiteColor),
                                                ),
                                                Text(
                                                  snapshot.data!.data.list.prodi
                                                      .fakultas.namaFakultas,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: mainWhiteColor),
                                                ),
                                                Text(
                                                  "Prodi : ${snapshot.data!.data.list.prodi.namaProdi}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: mainWhiteColor),
                                                ),
                                                if (snapshot
                                                        .data!
                                                        .data
                                                        .list
                                                        .prodi
                                                        .jurusan
                                                        .namaJurusan
                                                        .toString() !=
                                                    "null")
                                                  (Text(
                                                    "Jurusan : ${snapshot.data!.data.list.prodi.jurusan.namaJurusan}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: mainWhiteColor),
                                                  )),
                                                if (snapshot
                                                        .data!
                                                        .data
                                                        .list
                                                        .prodi
                                                        .jurusan
                                                        .namaJurusan
                                                        .toString() ==
                                                    "null")
                                                  (Text(
                                                    "Jurusan : -",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: mainWhiteColor),
                                                  )),
                                                Text(
                                                  "Angkatan : ${snapshot.data!.data.list.angkatan}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: mainWhiteColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: Image.network(snapshot
                                                  .data!.data.list.foto)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Divider(
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Dosen Pembimbing Akademik",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: mainWhiteColor),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      if (snapshot.data!.data.list.dosenPa
                                              .gelarDepan
                                              .toString() !=
                                          "null")
                                        (Text(
                                          "${snapshot.data!.data.list.dosenPa.gelarDepan} ${snapshot.data!.data.list.dosenPa.namaPegawai} ${snapshot.data!.data.list.dosenPa.gelarBelakang} ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: mainWhiteColor),
                                        )),
                                      if (snapshot.data!.data.list.dosenPa
                                              .gelarDepan
                                              .toString() ==
                                          "null")
                                        (Text(
                                          "${snapshot.data!.data.list.dosenPa.namaPegawai} ${snapshot.data!.data.list.dosenPa.gelarBelakang} ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: mainWhiteColor),
                                        )),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: SizedBox(
                                  width: SizeConfig.screenWidth,
                                  child: Wrap(
                                    runSpacing: 20.0,
                                    spacing: 10.0,
                                    alignment: WrapAlignment.start,
                                    children: [
                                      if (snapshot.data!.data.list.ipk
                                              .toString() ==
                                          "")
                                        (const StatusCard(
                                          title: "IPK",
                                          data: "-",
                                        )),
                                      if (snapshot.data!.data.list.ipk
                                              .toString() !=
                                          "")
                                        (StatusCard(
                                          title: "IPK",
                                          data: snapshot.data!.data.list.ipk
                                              .toString(),
                                        )),
                                      if (snapshot.data!.data.list.ipSebelumnya
                                              .toString() ==
                                          "")
                                        (const StatusCard(
                                          title: "IP Semester\nSebelumnya",
                                          data: "-",
                                        )),
                                      if (snapshot.data!.data.list.ipSebelumnya
                                              .toString() !=
                                          "")
                                        (StatusCard(
                                          title: "IP Semester\nSebelumnya",
                                          data: snapshot
                                              .data!.data.list.ipSebelumnya
                                              .toString(),
                                        )),
                                      if (snapshot
                                              .data!.data.list.statusMahasiswa
                                              .toString() ==
                                          "L")
                                        (const StatusCard(
                                          title: "Semester Saat Ini",
                                          data: "Lulus",
                                        )),
                                      if (snapshot
                                              .data!.data.list.statusMahasiswa
                                              .toString() !=
                                          "L")
                                        (StatusCard(
                                          title: "Semester Saat Ini",
                                          data: snapshot
                                              .data!.data.list.semester
                                              .toString(),
                                        )),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                          Container(
                            height: 7,
                            color: Colors.grey[300],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                Text(
                                  "Akademik",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: mainOrange2Color),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: SizeConfig.screenWidth,
                                  child: Wrap(
                                    runSpacing: 20.0,
                                    spacing: 10.0,
                                    alignment: WrapAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, 'riwayatregis');
                                          },
                                          child: const menuAkademik(
                                            image:
                                                "assets/img/transaction-history.png",
                                            title: "Riwayat\nRegistrasi",
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 70,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, 'khsmhs');
                                          },
                                          child: const menuAkademik(
                                            image: "assets/img/academy.png",
                                            title: "KHS",
                                          ),
                                        ),
                                      ),
                                      if (snapshot
                                              .data!.data.list.statusMahasiswa
                                              .toString() !=
                                          "L")
                                        (SizedBox(
                                          width: 70,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, 'krsmhs');
                                            },
                                            child: const menuAkademik(
                                              image: "assets/img/contract.png",
                                              title: "KRS",
                                            ),
                                          ),
                                        )),

                                      SizedBox(
                                        width: 70,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, 'kurikulummhs');
                                          },
                                          child: const menuAkademik(
                                            image: "assets/img/resume.png",
                                            title: "Kurikulum",
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 70,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, 'presensimhs');
                                          },
                                          child: const menuAkademik(
                                            image: "assets/img/kehadiran.png",
                                            title: "Presensi",
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   width: 60,
                                      // ),
                                      SizedBox(
                                        width: 70,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, 'tagihanmhs');
                                          },
                                          child: const menuAkademik(
                                            image: "assets/img/money.png",
                                            title: "Tagihan",
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   width: 60,
                                      // ),
                                      SizedBox(
                                        width: 70,
                                        child: InkWell(
                                          onTap: () {
                                            _chatDosen(
                                                snapshot.data!.data.list.dosenPa
                                                    .idPegawai
                                                    .toString(),
                                                snapshot.data!.data.list.dosenPa
                                                    .namaPegawai
                                                    .toString(),
                                                    snapshot.data!.data.list.dosenPa
                                                    .gelarBelakang
                                                    .toString(),
                                                    snapshot.data!.data.list.dosenPa
                                                    .gelarDepan
                                                    .toString(),
                                                    );
                                          },
                                          child: const menuAkademik(
                                            image: "assets/img/chat.png",
                                            title: "Chat",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
          }),
    );
  }

  Future _chatDosen(String idDosen, String namaPegawai, String gelarBelakang, String gelarDepan) async {
    SpUtil.putString("id_dosen", idDosen);
    SpUtil.putString("nama_pegawai", namaPegawai);
    SpUtil.putString("gelar_belakang", gelarBelakang);
    SpUtil.putString("gelar_depan", gelarDepan);
    Navigator.pushNamed(context, 'chatmhs');
  }
}

class menuAkademik extends StatelessWidget {
  const menuAkademik({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          width: 30,
          height: 30,
          // color: Colors.blue,
          child: Image.asset(image),
        ),
        Text(title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Color(0xFF1E3B78))),
      ],
    );
  }
}

class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
    required this.title,
    required this.data,
  });

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(
            minWidth: 90.0, maxWidth: 110.0, minHeight: 70.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF1E3B78),
              ),
            ),
            RichText(
                text: TextSpan(
              text: data,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xffE9561B),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class ClipInfoClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width - 80, size.height);
    path.lineTo(size.width, size.height - 80);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
