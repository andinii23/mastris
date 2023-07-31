import 'package:flutter/material.dart';

import '../settings/constant.dart';
import '../settings/stringdat.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'gerbangpage');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20, top: 20),
              child: Text(
                "Skip",
                style: TextStyle(
                  color: mainBlueColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: <Widget>[
              makePage(
                image: 'assets/img/info.png',
                title: StringsDat.stepOneTitle,
                content: StringsDat.stepOneContent,
              ),
              makePage(
                reverse: true,
                image: 'assets/img/benefit.png',
                title: StringsDat.stepTwoTitle,
                content: StringsDat.stepTwoContent,
              ),
              makePage(
                image: 'assets/img/infologin.png',
                title: StringsDat.stepThreeTitle,
                content: StringsDat.stepThreeContent,
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
          )
        ],
      ),
    );
  }

  Widget makePage({image, title, content, reverse = false}) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 50, right: 50, bottom: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              !reverse
                  ? Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(width: 150, height: 150,
                            child: Image.asset(image)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    )
                  : const SizedBox(),
              Text(
                title,
                style: TextStyle(
                  color: mainBlueColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: mainBlackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              reverse
                  ? Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox( width: 100, height: 100,
                            child: Image.asset(image)),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 30 : 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: mainBlueColor, borderRadius: BorderRadius.circular(5)),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
