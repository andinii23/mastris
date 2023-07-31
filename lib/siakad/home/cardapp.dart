// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class cardApp extends StatefulWidget {
  final String icon;
  final String label;
  final VoidCallback? onTap;
  const cardApp(
      {Key? key, required this.icon, required this.label, required this.onTap})
      : super(key: key);

  @override
  State<cardApp> createState() => _cardAppState();
}
class _cardAppState extends State<cardApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          constraints: const BoxConstraints(
              minWidth: 90.0, maxWidth: 300.0, minHeight: 70.0),
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.icon,
                width: 25.0,
                height: 30.0,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
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
