import 'package:app/const/colors.dart';
import 'package:app/controllers/burialController.dart';
import 'package:app/helpers/zone_badge.dart';
import 'package:app/ux/dialog_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ProfilePreview extends StatefulWidget {
  const ProfilePreview({Key? key}) : super(key: key);

  @override
  State<ProfilePreview> createState() => _ProfilePreviewState();
}

class _ProfilePreviewState extends State<ProfilePreview> {
  final _burialController = Get.put(BurialController());
  late String fullName,
      address,
      messages,
      death,
      birth,
      burial,
      deathAndBirth,
      registrantContactNo,
      zone;

  late String rFirstName,
      rLastName,
      rAddress,
      rMessages,
      rDeath,
      rBirth,
      rBurial,
      rRegistrantContactNo,
      rSignatureUrl,
      rRelationshipToDeceased,
      rDateRegistered;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    rFirstName =
        _burialController.selectedProfile["registrant"]["profile"]["firstName"];

    rLastName =
        _burialController.selectedProfile["registrant"]["profile"]["lastName"];

    rDateRegistered =
        Jiffy(_burialController.selectedProfile["registrant"]["dateRegistered"])
            .yMMMMd;

    rRelationshipToDeceased = _burialController.selectedProfile["registrant"]
        ["relationshipToDeceased"];

    rRegistrantContactNo =
        _burialController.selectedProfile["registrant"]["contactNumber"];

    rSignatureUrl =
        _burialController.selectedProfile["registrant"]["signatureUrl"];
    fullName = _burialController.selectedProfile["deceased"]["profile"]
        ["completeName"];
    address =
        _burialController.selectedProfile["deceased"]["profile"]["address"];

    messages = _burialController.selectedProfile["deceased"]["tombstone"]
        ["lovingMessage"];

    zone = _burialController.selectedProfile["burialLocation"];
    death = _burialController.selectedProfile["deceased"]["date"]["death"];
    burial = Jiffy(
      _burialController.selectedProfile["deceased"]["date"]["burial"],
    ).yMMMMd;
    birth = _burialController.selectedProfile["deceased"]["date"]["birth"];

    deathAndBirth = Jiffy(birth).yMMMMd + " - " + Jiffy(death).yMMMMd;
    registrantContactNo =
        _burialController.selectedProfile["registrant"]["contactNumber"];
  }

  _handleCallNumber(number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  _showSignature(imgUrl) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.50,
        width: Get.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: Image.network(
            imgUrl,
            width: Get.width,
            fit: BoxFit.cover,
          ),
        ),
      ),
      barrierColor: Colors.black26,
    );
  }

  _handleDelete() {
    dialogDelete(
      context: context,
      action: () => _burialController.delete(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Details",
          style: GoogleFonts.manrope(
            color: secondary,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        shape: Border(
          bottom: BorderSide(color: secondary.withOpacity(0.2), width: 0.5),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            splashRadius: 20,
            onPressed: () => _handleDelete(),
            tooltip: "Delete",
            icon: const Icon(
              AntDesign.delete,
              color: Colors.red,
            ),
          ),
          IconButton(
            splashRadius: 20,
            onPressed: () => _handleCallNumber(registrantContactNo),
            tooltip: "Call Registrant Number",
            icon: const Icon(
              MaterialIcons.call,
              color: secondary,
            ),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            getZoneBadge(zone),
            const SizedBox(height: 20.0),
            Text(
              fullName,
              style: GoogleFonts.roboto(
                color: secondary,
                fontWeight: FontWeight.w400,
                fontSize: 20.0,
              ),
            ),
            Text(
              address,
              style: GoogleFonts.roboto(
                color: secondary,
                fontWeight: FontWeight.w400,
                fontSize: 17.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              "\"$messages\"",
              style: GoogleFonts.roboto(
                color: secondary.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                fontSize: 15.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              deathAndBirth,
              style: GoogleFonts.roboto(
                color: secondary,
                fontWeight: FontWeight.w400,
                fontSize: 15.0,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              "Buried on $burial",
              style: GoogleFonts.roboto(
                color: secondary,
                fontWeight: FontWeight.w400,
                fontSize: 15.0,
              ),
            ),
            const Spacer(),
            Text(
              "Registered by",
              style: GoogleFonts.roboto(
                color: secondary.withOpacity(0.7),
                fontWeight: FontWeight.w300,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              rFirstName + " " + rLastName,
              style: GoogleFonts.roboto(
                color: secondary,
                fontWeight: FontWeight.w400,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 25.0),
            Text(
              "Contact Number",
              style: GoogleFonts.roboto(
                color: secondary.withOpacity(0.7),
                fontWeight: FontWeight.w300,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              rRegistrantContactNo,
              style: GoogleFonts.roboto(
                color: secondary,
                fontWeight: FontWeight.w400,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 25.0),
            Text(
              "Relationship to deceased",
              style: GoogleFonts.roboto(
                color: secondary.withOpacity(0.7),
                fontWeight: FontWeight.w300,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              rRelationshipToDeceased,
              style: GoogleFonts.roboto(
                color: secondary,
                fontWeight: FontWeight.w400,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 25.0),
            Text(
              "Registration Date",
              style: GoogleFonts.roboto(
                color: secondary.withOpacity(0.7),
                fontWeight: FontWeight.w300,
                fontSize: 12.0,
              ),
            ),
            Text(
              rDateRegistered,
              style: GoogleFonts.roboto(
                color: secondary,
                fontWeight: FontWeight.w400,
                fontSize: 20.0,
              ),
            ),
            const Spacer(),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _showSignature(rSignatureUrl),
              child: Container(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: [
                    Text(
                      "View Signature",
                      style: GoogleFonts.roboto(
                        color: secondary.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Icon(
                      FontAwesome5Solid.signature,
                      color: secondary.withOpacity(0.7),
                      size: 14.0,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
