// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import '../../../settings/constant.dart';

class semesterCard extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  const semesterCard({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  State<semesterCard> createState() => _semesterCardState();
}
class _semesterCardState extends State<semesterCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          constraints: const BoxConstraints(
              minWidth: 90.0, maxWidth: 300.0, minHeight: 40.0),
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: mainWhiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1E3B78).withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 4,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: mainBlueColor,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
