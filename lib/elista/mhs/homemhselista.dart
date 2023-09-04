import 'package:flutter/material.dart';

import '../../siakad/settings/constant.dart';

class HomeMhsElista extends StatefulWidget {
  const HomeMhsElista({super.key});

  @override
  State<HomeMhsElista> createState() => _HomeMhsElistaState();
}

class _HomeMhsElistaState extends State<HomeMhsElista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Home Mahasiswa Elista",
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
             Navigator.pushNamed(context, 'homepage');
          },
        ),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'mhsagendabimbingan');
            },
            child: const Text("Agenda Bimbingan"),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'datapenelitian');
            },
            child: const Text("Data Penelitian"),
          ),
           InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'prosesbimbingan');
            },
            child: const Text("Proses Bimbingan"),
          ),
           InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'sempro');
            },
            child: const Text("Mendaftar Seminar Proposal"),
          ),
        ],
      ),
    );
  }
}