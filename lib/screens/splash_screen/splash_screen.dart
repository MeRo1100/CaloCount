import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ketodiet/ads_constant/adsconstant.dart';
import 'package:ketodiet/utils/colors_utils.dart';
import 'package:ketodiet/widgets/mycontainer.dart';
import 'package:ketodiet/widgets/myregulartext.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen.SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AdsConstant interstitialAd = AdsConstant();

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, showAd);
  }

  void showAd() {
    interstitialAd.loadAppOpenAd(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: MyContainer(
        height: double.infinity,
        width: double.infinity,
        image: const DecorationImage(
            image: AssetImage('assets/images/splashback.png'),
            fit: BoxFit.cover),
        child: Center(
          child: MyRegularText(
            isHeading: false,
            label: 'Calo\nCount',
            style: GoogleFonts.barlow(
              textStyle: const TextStyle(
                color: greenColor1,
                fontSize: 60,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
