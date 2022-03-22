import 'package:app/const/colors.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

showDateBottompicker(context) {
  var date;
  BottomPicker.dateTime(
    height: Get.height * 0.40,
    title: "Event Date and Time",
    titleStyle: GoogleFonts.roboto(
      color: secondary,
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
    ),
    buttonAlignement: MainAxisAlignment.end,
    buttonSingleColor: secondary,
    dismissable: false,
    onSubmit: (date) {
      date = Jiffy(date).yMMMMEEEEdjm;
    },
    onClose: () {
      print("Picker closed");
    },
    iconColor: Colors.white,
    minDateTime: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + 1,
    ),
    maxDateTime: DateTime(DateTime.now().year + 1),
    use24hFormat: false,
    pickerTextStyle: GoogleFonts.roboto(
      color: secondary,
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
    ),
    gradientColors: const [],
  ).show(context);
  return date;
}
