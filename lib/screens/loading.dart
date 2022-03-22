import 'package:app/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            height: 35.0,
            child: LoadingIndicator(
              indicatorType: Indicator.circleStrokeSpin,
              colors: [secondary],
              strokeWidth: 1,
              backgroundColor: Colors.transparent,
              pathBackgroundColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
