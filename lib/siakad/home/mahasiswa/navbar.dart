import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../settings/constant.dart';
import 'biodata.dart';
import 'cetakpage.dart';
import 'homemhs.dart';


class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;
  static final List<Widget> _navScreen = <Widget>[
    const HomeMhs(),
    const CetakPage(),
    const BiodataMhs(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: mainWhiteColor,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1E3B78).withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 4,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: GNav(
              gap: 8,
              backgroundColor: Colors.white,
              color: const Color(0xFF1E3B78),
              activeColor: const Color(0xFF1E3B78),
              tabBackgroundColor: Colors.grey.shade200,
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.print,
                  text: "Cetak",
                ),
                GButton(
                  icon: Icons.account_circle,
                  text: "Biodata",
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
          ]
        ),
      ),
      body: Center(child: _navScreen.elementAt(_selectedIndex)),
    );
  }
}
