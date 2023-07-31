// ignore_for_file: use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  final Widget smallMobile;

  const Responsive(
      {required this.desktop,
      required this.mobile,
      required this.smallMobile,
      required this.tablet});

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1200 &&
      MediaQuery.of(context).size.width >= 768;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    if (_size.width >= 1200) {
      return desktop;
    } else if (_size.width >= 768) {
      return tablet;
    } else if (_size.width >= 376 && _size.width <= 768) {
      return mobile;
    } else {
      return smallMobile;
    }
  }
}
