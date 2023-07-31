import 'package:flutter/material.dart';
import '../siakad/settings/constant.dart';


class DevelopPage extends StatefulWidget {
  const DevelopPage({super.key});

  @override
  State<DevelopPage> createState() => _DevelopPageState();
}

class _DevelopPageState extends State<DevelopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "",
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
      body: const Center(
        child: Text("Masih Dalam Tahap Pengembanagn", style: TextStyle(
          fontSize: 16, 
          fontWeight: FontWeight.bold,
        ),),
      ),
    );
  }
}