import 'package:app/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const zone1 = ["zone-1-a", "zone-1-b", "zone-1-c", "zone-1-d"];
const zone2 = ["zone-2-a", "zone-2-b", "zone-2-c", "zone-2-d"];
const zone3 = ["zone-3-a", "zone-3-b", "zone-3-c"];
const zone4 = ["zone-4-a", "zone-4-b"];
const zone5 = ["zone-5-a", "zone-5-b"];
const zone6 = ["zone-6-a", "zone-6-b", "zone-6-c"];
const zone7 = ["zone-7-a", "zone-7-b", "zone-7-c", "zone-7-d"];

Container getZoneBadge(tag) {
  if (zone1.contains(tag)) {
    return Container(
      width: Get.width * 0.25,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Color(0xFFFF7124),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Text(
        tag.toString().toUpperCase().replaceAll(r'-', " "),
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 13.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
  if (zone2.contains(tag)) {
    return Container(
      width: Get.width * 0.25,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Color(0xFF9DA4DF),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Text(
        tag.toString().toUpperCase().replaceAll(r'-', " "),
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 13.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
  if (zone3.contains(tag)) {
    return Container(
      width: Get.width * 0.25,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Color(0xFFF92F63),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Text(
        tag.toString().toUpperCase().replaceAll(r'-', " "),
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 13.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
  if (zone4.contains(tag)) {
    return Container(
      width: Get.width * 0.25,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Color(0xFF6AE34D),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Text(
        tag.toString().toUpperCase().replaceAll(r'-', " "),
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 13.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
  if (zone5.contains(tag)) {
    return Container(
      width: Get.width * 0.25,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Color(0xFFF577F4),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Text(
        tag.toString().toUpperCase().replaceAll(r'-', " "),
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 13.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
  if (zone6.contains(tag)) {
    return Container(
      width: Get.width * 0.25,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.yellow[400],
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Text(
        tag.toString().toUpperCase().replaceAll(r'-', " "),
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 13.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
  if (zone7.contains(tag)) {
    return Container(
      width: Get.width * 0.25,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: secondary, width: 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Text(
        tag.toString().toUpperCase().replaceAll(r'-', " "),
        style: GoogleFonts.roboto(
          color: secondary,
          fontWeight: FontWeight.w800,
          fontSize: 13.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
  return Container();
}
