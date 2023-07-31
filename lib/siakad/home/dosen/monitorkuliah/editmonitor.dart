// ignore_for_file: prefer_final_fields, import_of_legacy_library_into_null_safe, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sp_util/sp_util.dart';

import '../../../model/detailmonitor.dart';
import '../../../settings/constant.dart';


class EditMonitoringKuliah extends StatefulWidget {
  const EditMonitoringKuliah({super.key});

  @override
  State<EditMonitoringKuliah> createState() => _EditMonitoringKuliahState();
}

class _EditMonitoringKuliahState extends State<EditMonitoringKuliah> {
  final _formState = GlobalKey<FormState>();
  final selectedIndex = [];
  final selectedIndex2 = [];
  List<int> selectedDosenIDs = [];
  List<int> selectedMahasiswaIDs = [];

  DateTime? _selectedDate;

  bool selectAllMahasiswa = false;
  String dsn = "";
  String idDosenn = "";

  TextEditingController _tanggalController = TextEditingController();
  TextEditingController _mulaiController = TextEditingController();
  TextEditingController _selesaiController = TextEditingController();
  TextEditingController _materiController = TextEditingController();
  // TextEditingController _ketController = TextEditingController();

  Future<DetailMonitoringKuliahModel> getDetailMonitor() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(
        Uri.parse(monitorperkelasdetail +
            SpUtil.getString("id_monitoring_perkuliahann")!),
        headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return DetailMonitoringKuliahModel.fromJson(data);
    } else {
      return DetailMonitoringKuliahModel.fromJson(data);
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch and populate the data when the widget is first created
    getDetailMonitor().then((detailData) {
      for (var mhs in detailData.data.list.mahasiswa) {
        if (mhs.kehadiran == 1) {
          selectedIndex2.add(mhs.idMhsPt);
        }
      }

      for (var dsn in detailData.data.list.dosen) {
        if (dsn.kehadiran == 1) {
          selectedIndex.add(dsn.idDosen); // Add Dosen's ID to selectedIndex
        }
      }
      String tgl = detailData.data.list.tanggal;
      DateTime tanggal = DateTime.parse(tgl);
      DateFormat dateFormat = DateFormat('dd-MM-yyyy');

      String tanggalFormatted = dateFormat.format(tanggal);

      _tanggalController.text = tanggalFormatted;
      _mulaiController.text = detailData.data.list.jamMulai;
      _selesaiController.text = detailData.data.list.jamSelesai;
      _materiController.text = detailData.data.list.materi;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tanggalController.dispose();
    _mulaiController.dispose();
    _selesaiController.dispose();
    _materiController.dispose();
    // _ketController.dispose();
    super.dispose();
  }

  void selectIndexWithID(int id) {
    if (selectedIndex.contains(id)) {
      selectedIndex.remove(id); // Unselect
    } else {
      selectedIndex.add(id); // Select
    }
  }

  void selectIndexWithID2(int id) {
    if (selectedIndex2.contains(id)) {
      selectedIndex2.remove(id); // Unselect
    } else {
      selectedIndex2.add(id); // Select
    }
  }

  Future<TimeOfDay?> showTimePickerDialog(BuildContext context,
      {required TextEditingController controller}) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        controller.text = pickedTime.format(context);
      });
    }
    return pickedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Monitoring Kuliah",
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
            future: getDetailMonitor(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                      key: _formState,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tanggal",
                                  style: TextStyle(
                                    color: mainBlackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _tanggalController,
                                  validator: (value) {
                                    if (value == '') {
                                      return "tanggal harus diisi!!";
                                    }
                                    return null;
                                  },
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          _selectedDate ?? DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );

                                    if (pickedDate != null) {
                                      setState(() {
                                        _selectedDate = pickedDate;
                                        _tanggalController.text =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                      });
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Tanggal",
                                    border: OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      onPressed: null,
                                      icon: Icon(Icons.calendar_month),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Jam Perkuliahan",
                                  style: TextStyle(
                                    color: mainBlackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: TextFormField(
                                        controller: _mulaiController,
                                        validator: (value) {
                                          if (value == '') {
                                            return "jam mulai harus diisi!!";
                                          }
                                          return null;
                                        },
                                        onTap: () async {
                                          await showTimePickerDialog(context,
                                              controller: _mulaiController);
                                        },
                                        decoration: const InputDecoration(
                                          hintText: "Mulai",
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: TextFormField(
                                        controller: _selesaiController,
                                        validator: (value) {
                                          if (value == '') {
                                            return "jam selesai harus diisi!!";
                                          }
                                          return null;
                                        },
                                        onTap: () async {
                                          await showTimePickerDialog(context,
                                              controller: _selesaiController);
                                        },
                                        decoration: const InputDecoration(
                                          hintText: "Selesai",
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (SpUtil.getString("status_siremun") != "1")
                              (Text(
                                "Pilih Dosen Hadir",
                                style: TextStyle(
                                  color: mainBlackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              )),
                            if (SpUtil.getString("status_siremun") != "1")
                              (ListView.builder(
                                  physics: const ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount:
                                      snapshot.data!.data.list.dosen.length,
                                  itemBuilder: (context, dsn) {
                                    final idDosen =
                                        snapshot.data!.data.list.dosen[dsn];

                                    return CheckboxListTile(
                                        title: Text(
                                            "${idDosen.namaDosen.toString()} ${idDosen.gelarBelakang.toString()}"),
                                        value: selectedIndex
                                            .contains(idDosen.idDosen),
                                        onChanged: (val) {
                                          setState(() {
                                            selectIndexWithID(idDosen.idDosen);
                                            print(selectedIndex);
                                          });
                                        });
                                  })),
                            const SizedBox(
                              height: 10,
                            ),
                            if (SpUtil.getString("status_siremun") != "1")
                              (Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Materi",
                                    style: TextStyle(
                                      color: mainBlackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _materiController,
                                    validator: (value) {
                                      if (value == '') {
                                        return "materi harus diisi!!";
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: "Materi",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              )),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Daftar Mahasiswa",
                              style: TextStyle(
                                color: mainBlackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            CheckboxListTile(
                              title: const Text("Select All"),
                              value: selectAllMahasiswa,
                              onChanged: (value) {
                                setState(() {
                                  selectAllMahasiswa = value!;
                                  if (selectAllMahasiswa) {
                                    selectedIndex2.clear();
                                    // Tambahkan semua ID mahasiswa ke dalam selectedIndex2
                                    final mhsList =
                                        snapshot.data!.data.list.mahasiswa;
                                    for (var i = 0; i < mhsList.length; i++) {
                                      selectedIndex2.add(mhsList[i].idMhsPt);
                                    }
                                  } else {
                                    selectedIndex2.clear();
                                  }
                                  print(selectedIndex2);
                                });
                              },
                            ),
                            ListView.builder(
                                physics: const ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount:
                                    snapshot.data!.data.list.mahasiswa.length,
                                itemBuilder: (context, mhs) {
                                  final idMhs =
                                      snapshot.data!.data.list.mahasiswa[mhs];

                                  return Column(
                                    children: [
                                      CheckboxListTile(
                                          title: Text(snapshot.data!.data.list
                                              .mahasiswa[mhs].namaMahasiswa
                                              .toString()),
                                          value: selectAllMahasiswa
                                              ? selectAllMahasiswa
                                              : selectedIndex2
                                                  .contains(idMhs.idMhsPt),
                                          onChanged: (valmhs) {
                                            setState(() {
                                              selectIndexWithID2(idMhs.idMhsPt);
                                              print(selectedIndex2);
                                            });
                                          }),
                                    ],
                                  );
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formState.currentState!.validate()) {
                                    updateData();
                                  } else {
                                    print("validasi gagal");
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(mainBlueColor),
                                ),
                                child: const Text(
                                  "Update",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
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

  Future<void> updateData() async {
    var header = {
      "Authorization": "Bearer ${SpUtil.getString("token")}",
      "Content-Type": "application/json"
    };

    List<int> dosenIDs = []; // List to store selected Dosen IDs
    List<int> mahasiswaIDs = []; // List to store selected Mahasiswa IDs

    for (var dosenID in selectedIndex) {
      // Add each selected Dosen ID to the list
      dosenIDs.add(dosenID);
    }

    for (var mhsID in selectedIndex2) {
      // Add each selected Mahasiswa ID to the list
      mahasiswaIDs.add(mhsID);
    }
    Map<String, dynamic> data = {
      "id_monitoring_perkuliahan":
          SpUtil.getString("id_monitoring_perkuliahann"),
      "id_kelas": SpUtil.getString("id_kelass"),
      'tanggal':
          _tanggalController.text, // Update this line to use the new date value
      'jam_mulai': _mulaiController.text,
      'jam_selesai': _selesaiController.text,
      'dosen': dosenIDs,
      'materi': _materiController.text,
      'mahasiswa': mahasiswaIDs,
    };

    var body = jsonEncode(data);

    try {
      var response = await http.patch(
        Uri.parse("https://ws.unja.ac.id/api/siakad/monitoring-perkuliahan"),
        headers: header,
        body: body,
      );

      if (response.statusCode == 200) {
        // Data berhasil terkirim
        Navigator.pushNamed(context, 'monitorperkelas');
        print('Data berhasil terkirim');
        print(response.body);
      } else {
        // Terjadi kesalahan saat mengirim data
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
