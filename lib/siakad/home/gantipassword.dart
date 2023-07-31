// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_final_fields, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';
import '../settings/constant.dart';

class GantiPassword extends StatefulWidget {
  const GantiPassword({super.key});

  @override
  State<GantiPassword> createState() => _GantiPasswordState();
}

class _GantiPasswordState extends State<GantiPassword> {
  TextEditingController _passwordlamaController = TextEditingController();
  TextEditingController _passwordbaruController = TextEditingController();
  TextEditingController _confpasswordController = TextEditingController();
  final _formState = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordlamaController.dispose();
    _passwordbaruController.dispose();
    _confpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Ganti Password",
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
      body: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(20),
            child: Form(
                key: _formState,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _passwordlamaController,
                        validator: (value) {
                          if (value == '') {
                            return "password lama harus diisi!!";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: "Password Lama",
                            hintText: "Password Lama",
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                onPressed: null,
                                icon: Icon(Icons.remove_red_eye_sharp))),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _passwordbaruController,
                        validator: (value) {
                          if (value == '') {
                            return "password baru harus diisi!!";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: "Password Baru",
                            hintText: "Password Baru",
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                onPressed: null,
                                icon: Icon(Icons.remove_red_eye_sharp))),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _confpasswordController,
                        validator: (value) {
                          if (value == '') {
                            return "konfiramsi password harus diisi!!";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: "Konfirmasi Password",
                            hintText: "Konfirmasi Password",
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                onPressed: null,
                                icon: Icon(Icons.remove_red_eye_sharp))),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formState.currentState!.validate()) {
                              _gantiPass();
                            } else {
                              print("validasi gagal");
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(mainBlueColor),
                          ),
                          child: const Text(
                            "Ganti Password",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      )),
    );
  }

  Future _gantiPass() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.post(Uri.parse(gantipass), headers: header, body: {
      "password_lama": _passwordlamaController.text,
      "password_baru": _passwordbaruController.text,
      "password_confirmation": _confpasswordController.text,
    });
    if (response.statusCode == 200) {
      print(response.body);
      Navigator.pushNamed(context, 'homepage');
    } else {
      print("gagal menambahkan kelas");
      var body = jsonDecode(response.body);
      print(body["error_message"]);
    }
  }
}
