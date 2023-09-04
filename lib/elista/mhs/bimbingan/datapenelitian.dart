// ignore_for_file: prefer_final_fields, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mastrisunja/elista/model/mhs/jenisdatapenelitianmodel.dart';
import 'package:mastrisunja/elista/model/mhs/jenisexplanasimodel.dart';
import 'package:mastrisunja/elista/model/mhs/jenispenggunaanmodel.dart';
import 'package:sp_util/sp_util.dart';
import '../../model/mhs/datapenelitianmodel.dart';
import '../../model/mhs/metodepenelitianmodel.dart';
import '../../../siakad/settings/constant.dart';

class DataPenelitian extends StatefulWidget {
  const DataPenelitian({super.key});

  @override
  State<DataPenelitian> createState() => _DataPenelitianState();
}

class _DataPenelitianState extends State<DataPenelitian> {
  final _formState = GlobalKey<FormState>();

  TextEditingController _judulController = TextEditingController();
  TextEditingController _jenisdataController = TextEditingController();
  TextEditingController _tingkatexplanasiController = TextEditingController();
  TextEditingController _jenispenggunaanController = TextEditingController();
  TextEditingController _metodepenelitianController = TextEditingController();
  TextEditingController _abstrakController = TextEditingController();

  dynamic idJenisDataPenelitian;
  dynamic idJenisExplanasi;
  dynamic idJenisPenggunaan;
  dynamic idMetodePenelitian;

  // String JenisDataPenelitian = "";

  Future<DataPenelitianModel> getDataPenelitian() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(datapenelitian), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return DataPenelitianModel.fromJson(data);
    } else {
      return DataPenelitianModel.fromJson(data);
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _jenisdataController.dispose();
    _tingkatexplanasiController.dispose();
    _jenispenggunaanController.dispose();
    _metodepenelitianController.dispose();
    _abstrakController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    DataPenelitianModel data = await getDataPenelitian();
    setState(() {
      _judulController.text = data.data.list.judulSkripsi;
      _jenisdataController.text = data.data.list
          .jenisDataPenelitian; // Update with the actual field from your data
      _tingkatexplanasiController.text =
          data.data.list.jenisExplanasi; // Update with the actual field
      _jenispenggunaanController.text =
          data.data.list.jenisPenggunaan; // Update with the actual field
      _metodepenelitianController.text =
          data.data.list.metodePenelitian; // Update with the actual field
      _abstrakController.text =
          data.data.list.abstrak; // Update with the actual field

      // Set selected values for dropdowns based on fetched data
      idJenisDataPenelitian = data.data.list.idJenisDataPenelitian;
      idJenisExplanasi = data.data.list.idJenisExplanasi;
      idJenisPenggunaan = data.data.list.idJenisPenggunaan;
      idMetodePenelitian = data.data.list.idMetodePenelitian;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Data Penelitian",
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
            Navigator.pushNamed(context, 'homemhselista');
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          "Judul",
                          style: TextStyle(
                            color: mainOrange2Color,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _judulController,
                          validator: (value) {
                            if (value == '') {
                              return "judul harus diisi!!";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Judul",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jenis Data",
                          style: TextStyle(
                            color: mainOrange2Color,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownSearch<JenisDataPenelitianModel>(
                          mode: Mode.MENU,
                          // showSearchBox: true,
                          popupItemBuilder: (context, item, isSelected) =>
                              ListTile(
                            title: Text(item.namaDataPenelitian!),
                          ),
                          selectedItem: JenisDataPenelitianModel(
                            idDataPeneltian: idJenisDataPenelitian,
                            namaDataPenelitian: _jenisdataController.text,
                          ),
                          onChanged: (value) =>
                              idJenisDataPenelitian = value?.idDataPeneltian,
                          dropdownBuilder: (context, selectedItem) => Text(
                              selectedItem?.namaDataPenelitian ??
                                  "Pilih Jenis Data"),
                          onFind: (text) async {
                            var header = {
                              "Authorization":
                                  "Bearer ${SpUtil.getString("token")}"
                            };
                            var response = await http.get(
                                Uri.parse(jenisdatapenelitian),
                                headers: header);
                            if (response.statusCode != 200) {
                              return [];
                            }
                            List allData = (json.decode(response.body)
                                as Map<String, dynamic>)["data"]["list"];

                            List<JenisDataPenelitianModel>
                                allJenisDataPenelitian = [];

                            for (var element in allData) {
                              allJenisDataPenelitian.add(
                                  JenisDataPenelitianModel(
                                      idDataPeneltian:
                                          element["id_data_peneltian"],
                                      namaDataPenelitian:
                                          element["nama_data_penelitian"]));
                            }
                            return allJenisDataPenelitian;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tingkat Explanasi",
                          style: TextStyle(
                            color: mainOrange2Color,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownSearch<JenisExplanasiModel>(
                          mode: Mode.MENU,
                          // showSearchBox: true,
                          popupItemBuilder: (context, item, isSelected) =>
                              ListTile(
                            title: Text(item.namaJenisExplanasi!),
                          ),
                          selectedItem: JenisExplanasiModel(
                            idJenisExplanasi: idJenisExplanasi,
                            namaJenisExplanasi:
                                _tingkatexplanasiController.text,
                          ),
                          onChanged: (value) =>
                              idJenisExplanasi = value?.idJenisExplanasi,
                          dropdownBuilder: (context, selectedItem) => Text(
                              selectedItem?.namaJenisExplanasi ??
                                  "Pilih Tingkat Explanasi"),
                          onFind: (text) async {
                            var header = {
                              "Authorization":
                                  "Bearer ${SpUtil.getString("token")}"
                            };
                            var response = await http.get(
                                Uri.parse(jenisexplanasi),
                                headers: header);
                            if (response.statusCode != 200) {
                              return [];
                            }
                            List allData = (json.decode(response.body)
                                as Map<String, dynamic>)["data"]["list"];

                            List<JenisExplanasiModel> allJenisExplanasi = [];

                            for (var element in allData) {
                              allJenisExplanasi.add(JenisExplanasiModel(
                                  idJenisExplanasi:
                                      element["id_jenis_explanasi"],
                                  namaJenisExplanasi:
                                      element["nama_jenis_explanasi"]));
                            }
                            return allJenisExplanasi;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jenis Penggunaan",
                          style: TextStyle(
                            color: mainOrange2Color,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownSearch<JenisPenggunaanModel>(
                          mode: Mode.MENU,
                          // showSearchBox: true,
                          popupItemBuilder: (context, item, isSelected) =>
                              ListTile(
                            title: Text(item.namaJenisPenggunaan!),
                          ),
                          selectedItem: JenisPenggunaanModel(
                            idJenisPenggunaan: idJenisPenggunaan,
                            namaJenisPenggunaan:
                                _jenispenggunaanController.text,
                          ),
                          onChanged: (value) =>
                              idJenisPenggunaan = value?.idJenisPenggunaan,
                          dropdownBuilder: (context, selectedItem) => Text(
                              selectedItem?.namaJenisPenggunaan ??
                                  "Pilih Jenis Penggunaan"),
                          onFind: (text) async {
                            var header = {
                              "Authorization":
                                  "Bearer ${SpUtil.getString("token")}"
                            };
                            var response = await http.get(
                                Uri.parse(jenispenggunaan),
                                headers: header);
                            if (response.statusCode != 200) {
                              return [];
                            }
                            List allData = (json.decode(response.body)
                                as Map<String, dynamic>)["data"]["list"];

                            List<JenisPenggunaanModel> allJenisPenggunaan = [];

                            for (var element in allData) {
                              allJenisPenggunaan.add(JenisPenggunaanModel(
                                  idJenisPenggunaan:
                                      element["id_jenis_penggunaan"],
                                  namaJenisPenggunaan:
                                      element["nama_jenis_penggunaan"]));
                            }
                            return allJenisPenggunaan;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Metode Penelitian",
                          style: TextStyle(
                            color: mainOrange2Color,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownSearch<MetodePenelitianModel>(
                          mode: Mode.MENU,
                          // showSearchBox: true,
                          popupItemBuilder: (context, item, isSelected) =>
                              ListTile(
                            title: Text(item.namaMetodePenelitian!),
                          ),
                          selectedItem: MetodePenelitianModel(
                            idMetodePenelitian: idMetodePenelitian,
                            namaMetodePenelitian:
                                _metodepenelitianController.text,
                          ),
                          onChanged: (value) =>
                              idMetodePenelitian = value?.idMetodePenelitian,
                          dropdownBuilder: (context, selectedItem) => Text(
                              selectedItem?.namaMetodePenelitian ??
                                  "Pilih Metode Penelitian"),
                          onFind: (text) async {
                            var header = {
                              "Authorization":
                                  "Bearer ${SpUtil.getString("token")}"
                            };
                            var response = await http.get(
                                Uri.parse(metodepenelitian),
                                headers: header);
                            if (response.statusCode != 200) {
                              return [];
                            }
                            List allData = (json.decode(response.body)
                                as Map<String, dynamic>)["data"]["list"];

                            List<MetodePenelitianModel> allMetopen = [];

                            for (var element in allData) {
                              allMetopen.add(MetodePenelitianModel(
                                  idMetodePenelitian:
                                      element["id_metode_penelitian"],
                                  namaMetodePenelitian:
                                      element["nama_metode_penelitian"]));
                            }
                            return allMetopen;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Abstrak/Deskripsi",
                          style: TextStyle(
                            color: mainOrange2Color,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          child: SizedBox(
                            height: 200, // Adjust the height as needed
                            child: TextFormField(
                              controller: _abstrakController,
                              validator: (value) {
                                if (value == "") {
                                  return "Abstrak harus diisi!";
                                }
                                return null;
                              },
                              maxLines:
                                  null, // Allow an unlimited number of lines
                              style: const TextStyle(
                                // Set the text style here
                                fontSize: 14, // Adjust the font size as needed
                              ),
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                hintText: "Abstrak",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                          "Simpan Data",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Future<void> updateData() async {
    var header = {
      "Authorization": "Bearer ${SpUtil.getString("token")}",
      "Content-Type": "application/json"
    };

    Map<String, dynamic> data = {
      "judul": _judulController.text,
      "id_metode_penelitian": idMetodePenelitian,
      'id_jenis_explanasi': idJenisExplanasi,
      'id_jenis_data_penelitian': idJenisDataPenelitian,
      'id_jenis_penggunaan': idJenisPenggunaan,
      'abstrak': _abstrakController.text,
    };

    var body = jsonEncode(data);

    try {
      var response = await http.patch(
        Uri.parse(datapenelitian),
        headers: header,
        body: body,
      );

      if (response.statusCode == 200) {
        // Data berhasil terkirim
        Navigator.pushNamed(context, 'datapenelitian');
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
