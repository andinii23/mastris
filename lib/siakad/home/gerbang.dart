import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';

import '../settings/constant.dart';

class GerbangPage extends StatefulWidget {
  const GerbangPage({super.key});

  @override
  State<GerbangPage> createState() => _GerbangPageState();
}

class _GerbangPageState extends State<GerbangPage> {
  List _data = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainWhiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'login');
               
              },
              child: Text(
                "Login",
                style: TextStyle(fontSize: 14, color: mainBlackColor),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'login');
               
              },
              child: Icon(
                Icons.login,
                color: mainBlackColor,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Stack(
          children: [
            Center(
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 2.6,
                width: double.maxFinite,
                decoration: BoxDecoration(color: mainWhiteColor),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      width: 150,
                      child: const Image(
                          image: AssetImage("assets/img/logomastris.png"),
                          fit: BoxFit.cover),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        "Selamat Datang Di Aplikasi Manajemen Sistem Informasi Terintegrasi (MASTRIS) Universitas Jambi",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: mainBlackColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.28,
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
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
                    child: TextField(
                      cursorHeight: 20,
                      autofocus: false,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Cari..",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: mainBlueColor, width: 2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Berita Terkini UNJA",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'beritaunja');
                          },
                          child: const Text(
                            "Selengkapnya >>",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 14, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _data.length,
                      itemBuilder: (context, index) {
                        final title =
                            _data[index]["title"]["rendered"].toString();
                        // Check if the search query is empty or the title contains the search query
                        if (searchQuery.isEmpty ||
                            title
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase())) {
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: InkWell(
                              onTap: () {
                                _detailBerita(_data[index]["id"].toString());
                              },
                              child: Container(
                                width: 150,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(_data[index]
                                                  ["yoast_head_json"]
                                              ["og_image"][0]["url"]
                                          .toString()),
                                      fit: BoxFit.cover),
                                  color: Colors.black,
                                  // borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      child: Text(
                                        _data[index]["title"]["rendered"]
                                            .toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox
                            .shrink(); // Return an empty widget if not matching the search query
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //bagian selanjutnya
              ],
            )
          ],
        ),
      ),
    );
  }

  Future _getData() async {
    try {
      final response = await http.get(Uri.parse("https://unja.ac.id/wp-json/wp/v2/posts"));
      if (response.statusCode == 200) {
        // print(response.body);
        final data = json.decode(response.body);
        setState(() {
          _data = data;
        });
        // print("Data : $_data");
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future _detailBerita(String idBerita) async {
    SpUtil.putString("id_berita", idBerita);
    Navigator.pushNamed(context, 'detailberita');
  }
}



