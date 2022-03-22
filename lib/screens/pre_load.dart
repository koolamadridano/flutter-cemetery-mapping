import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreLoad extends StatefulWidget {
  const PreLoad({Key? key}) : super(key: key);

  @override
  State<PreLoad> createState() => _PreLoadState();
}

class _PreLoadState extends State<PreLoad> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.toNamed("/admin-registrant-profile");
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
            "images/undraw_people_search.png",
            height: 150.0,
          ),
        ),
      ),
    );
  }
}
