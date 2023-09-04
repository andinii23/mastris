import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mastrisunja/elista/model/mhs/jadwalujianmodel.dart';
import 'package:sp_util/sp_util.dart';
import '../../../siakad/settings/constant.dart';

class JadwalUjian extends StatefulWidget {
  const JadwalUjian({super.key});

  @override
  State<JadwalUjian> createState() => _JadwalUjianState();
}

class _JadwalUjianState extends State<JadwalUjian> {
  Future<JadwalUjianModel> getJadwalUjian() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(jadwalujian), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body);
      return JadwalUjianModel.fromJson(data);
    } else {
      return JadwalUjianModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Jadwal Ujian",
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
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: FutureBuilder(
            future: getJadwalUjian(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!.data.list;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
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
                                      data.mahasiswa.nama.toString(),
                                      style: TextStyle(
                                        color: mainOrangeColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      data.mahasiswa.noMhs.toString(),
                                      style: TextStyle(
                                        color: mainBlueColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Angkatan ${data.mahasiswa.angkatan}",
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
                                      "Metode Penelitian",
                                      style: TextStyle(
                                        color: mainBlueColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(data.penelitian.metodePenelitian
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
                                    Text(data.penelitian.jenisExplanasi
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
                                    Text(data.penelitian.jenisDataPenelitian
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
                                    Text(data.penelitian.jenisPenggunaan
                                        .toString()),
                                  ],
                                ),
                              ],
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
                                Text(data.penelitian.judulSkripsi.toString()),
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
                                  data.penelitian.abstrak.toString(),
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
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
                                      "Step Saat Ini",
                                      style: TextStyle(
                                        color: mainBlueColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      data.stepSaatIni.nama.toString(),
                                      style: TextStyle(
                                        color: mainOrangeColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nama Ujian",
                                  style: TextStyle(
                                    color: mainBlueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(data.jadwal.namaUjian.toString()),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Tanggal Pendaftaran",
                                  style: TextStyle(
                                    color: mainBlueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(data.jadwal.tanggalPendaftaran.toString()),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Tanggal Validasi",
                                  style: TextStyle(
                                    color: mainBlueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(data.jadwal.tanggalValidasi.toString()),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Waktu Mulai",
                                  style: TextStyle(
                                    color: mainBlueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(data.jadwal.waktuMulai.toString()),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Waktu Selesai",
                                  style: TextStyle(
                                    color: mainBlueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (data.jadwal.waktuSelesai.toString() !=
                                    "null")
                                  (Text(data.jadwal.waktuSelesai.toString())),
                                if (data.jadwal.waktuSelesai.toString() ==
                                    "null")
                                  (const Text("-")),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
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
                                      "Dosen Pembimbing",
                                      style: TextStyle(
                                        color: mainBlueColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: data.dosenPembimbing.length,
                                        itemBuilder: (context, dpem) {
                                          var dpemm =
                                              data.dosenPembimbing[dpem];
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                dpemm.namaDosen,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: mainOrange2Color,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dosen Penguji",
                                  style: TextStyle(
                                    color: mainBlueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: data.dosenPenguji.length,
                                    itemBuilder: (context, dpen) {
                                      var dpeng = data.dosenPenguji[dpen];
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(dpeng.namaDosen),
                                        ],
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Text(
                        "Berita Acara",
                        style: TextStyle(
                          color: mainBlueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: data.listBeritaAcara.length,
                          itemBuilder: (context, listbac) {
                            var listbacara = data.listBeritaAcara[listbac];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                children: [
                                  const Divider(
                                    thickness: 2,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: SizedBox(
                                          width: 150,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                listbacara.namaDosen,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: mainOrange2Color,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Tanggal TTD",
                                                style: TextStyle(
                                                  color: mainBlueColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(listbacara.tanggalTtd),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Status",
                                                style: TextStyle(
                                                  color: mainBlueColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(listbacara.statusText),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Komentar",
                                              style: TextStyle(
                                                color: mainBlueColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(listbacara.komentar),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                      const Divider(
                        thickness: 2,
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
      ),
    );
  }
}
