import 'package:app/const/colors.dart';
import 'package:app/controllers/burialController.dart';
import 'package:app/helpers/zone_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchResultItemPreview extends StatefulWidget {
  const SearchResultItemPreview({Key? key}) : super(key: key);

  @override
  State<SearchResultItemPreview> createState() =>
      _SearchResultItemPreviewState();
}

class _SearchResultItemPreviewState extends State<SearchResultItemPreview> {
  final _burialController = Get.put(BurialController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  "images/map.png",
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 40,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Ionicons.arrow_back_circle,
                      color: Colors.white,
                      size: 45.0,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getZoneBadge(_burialController.selectedProfile["zone"]),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          _burialController.selectedProfile["firstName"] +
                              " " +
                              _burialController
                                  .selectedProfile["middleInitial"] +
                              " " +
                              _burialController.selectedProfile["lastName"],
                          style: GoogleFonts.roboto(
                            color: secondary,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      const Icon(
                        MaterialCommunityIcons.candle,
                        color: secondary,
                        size: 18,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _burialController.selectedProfile["deathAndBirth"],
                        style: GoogleFonts.roboto(
                          color: secondary,
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        _burialController.selectedProfile["message"],
                        style: GoogleFonts.manrope(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
