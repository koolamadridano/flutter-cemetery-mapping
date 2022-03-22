import 'package:app/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Divine Shepherd Burial Registry and Information System',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: "/admin",
      defaultTransition: Transition.fade,
      getPages: routes(),
    );
  }
}
