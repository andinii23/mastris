import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;
import '../../model/homedosenmodel.dart';
import '../../settings/constant.dart';
import '../config.dart';

class HomeDosen extends StatefulWidget {
  const HomeDosen({super.key});

  @override
  State<HomeDosen> createState() => _HomeDosenState();
}

class _HomeDosenState extends State<HomeDosen> {
  Future<HomeDosenModel> getHomeDosenData() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(home), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return HomeDosenModel.fromJson(data);
    } else {
      return HomeDosenModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Dosen"),),
      body: FutureBuilder<HomeDosenModel>(
          future: getHomeDosenData(),
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
                                      style: const TextStyle(fontSize: 16),
                                      children: [
                                        if (snapshot.data!.data.list.gelarDepan
                                                .toString() !=
                                            "null")
                                          (TextSpan(
                                            text:
                                                "${snapshot.data!.data.list.gelarDepan} ${snapshot.data!.data.list.namaDosen} ${snapshot.data!.data.list.gelarBelakang}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        if (snapshot.data!.data.list.gelarDepan
                                                .toString() ==
                                            "null")
                                          (TextSpan(
                                            text:
                                                "${snapshot.data!.data.list.namaDosen} ${snapshot.data!.data.list.gelarBelakang}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          )),
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
                                        CrossAxisAlignment.center,
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
                                                if (snapshot.data!.data.list
                                                        .gelarDepan
                                                        .toString() ==
                                                    "null")
                                                  (Text(
                                                    "${snapshot.data!.data.list.namaDosen} ${snapshot.data!.data.list.gelarBelakang}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: mainWhiteColor),
                                                  )),
                                                if (snapshot.data!.data.list
                                                        .gelarDepan
                                                        .toString() !=
                                                    "null")
                                                  (Text(
                                                    "${snapshot.data!.data.list.gelarDepan} ${snapshot.data!.data.list.namaDosen} ${snapshot.data!.data.list.gelarBelakang}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: mainWhiteColor),
                                                  )),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "NIP : ${snapshot.data!.data.list.nip.toString()}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "Nama Pengguna : ${SpUtil.getString("username")!}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                 Text(
                                                  "Otoritas : ${SpUtil.getString("usertype")!}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text("Fakultas : ${snapshot.data!.data.list
                                                      .fakultas.namaFakultas}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: mainWhiteColor),
                                                ),
                                                Text("Prodi : ${snapshot.data!.data.list.prodi
                                                      .namaProdi}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: mainWhiteColor),
                                                ),
                                                Text(
                                                  "Lokasi Presensi : ${snapshot.data!.data.list.lokasiPresensi}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: mainWhiteColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (snapshot.data!.data.list.foto
                                              .toString()
                                              .isNotEmpty)
                                            (SizedBox(
                                                width: 100,
                                                height: 100,
                                                child: Image.network(snapshot
                                                    .data!.data.list.foto))),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      // const SizedBox(
                                      //   height: 20,
                                      // ),
                                      // const Divider(
                                      //   color: Colors.white,
                                      // ),
                                      // Text(
                                      //   "Dosen Pembimbing Akademik",
                                      //   style: TextStyle(
                                      //       fontSize: 16,
                                      //       fontWeight: FontWeight.bold,
                                      //       color: mainWhiteColor),
                                      // ),
                                      // const SizedBox(
                                      //   height: 5,
                                      // ),
                                      // Text(
                                      //   "${snapshot.data!.data.list.dosenPa.namaPegawai} ${snapshot.data!.data.list.dosenPa.gelarBelakang} ",
                                      //   style: TextStyle(
                                      //       fontSize: 16,
                                      //       color: mainWhiteColor),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 85,
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
                                      "Akademik Dosen",
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
                                              width: 80,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, 'mhsbimbingan');
                                                },
                                                child: const menuAkademik(
                                                  image:
                                                      "assets/img/education.png",
                                                  title: "Mahasiswa\nBimbingan",
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 80,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, 'monitorkuliah');
                                                },
                                                child: const menuAkademik(
                                                  image:
                                                      "assets/img/pie-chart.png",
                                                  title:
                                                      "Monitoring\nPerkuliahan",
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 80,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, 'mkajar');
                                                },
                                                child: const menuAkademik(
                                                  image:
                                                      "assets/img/lecture.png",
                                                  title: "Matakuliah\nPengampu",
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 80,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, 'chatdosen');
                                                },
                                                child: const menuAkademik(
                                                  image: "assets/img/chat.png",
                                                  title: "Chat",
                                                ),
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
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

// ignore: camel_case_types
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
