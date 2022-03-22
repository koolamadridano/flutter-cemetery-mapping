import 'dart:io';

import 'package:app/const/colors.dart';
import 'package:app/controllers/burialController.dart';
import 'package:app/helpers/destroy_textfield_focus.dart';
import 'package:app/helpers/pretty_print.dart';
import 'package:app/widget/buttons.dart';
import 'package:app/widget/inputTextField.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditRegisterProfile extends StatefulWidget {
  const EditRegisterProfile({Key? key}) : super(key: key);

  @override
  State<EditRegisterProfile> createState() => _EditRegisterProfileState();
}

class _EditRegisterProfileState extends State<EditRegisterProfile> {
  final _burialController = Get.put(BurialController());

  final ImagePicker _picker = ImagePicker();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final middleInitial = TextEditingController();
  final address = TextEditingController();
  final relationship = TextEditingController();
  final contact = TextEditingController();

  String _signaturePath = "";
  String _signatureName = "";

  Future<void> _selectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _signaturePath = image!.path;
      _signatureName = image.name;
    });
  }

  void _removeSelectedImage() {
    setState(() {
      _signaturePath = "";
      _signatureName = "";
    });
  }

  void _onNextPage() {
    final _firstName = firstName.text.trim();
    final _lastName = lastName.text.trim();
    final _middleInitial = middleInitial.text.trim();
    final _address = address.text.trim();
    final _contact = contact.text.trim();
    final _relationship = relationship.text.trim();

    Map data = {
      "profile": {
        "firstName": _firstName,
        "lastName": _lastName,
        "middleInitial": _middleInitial,
        "address": _address
      },
      "signatureUrl": _signaturePath,
      "signatureFileName": _signatureName,
      "contactNumber": _contact,
      "relationshipToDeceased": _relationship,
    };
    _burialController.registrantData = data;

    prettyPrint("registrant_data", _burialController.registrantData);

    Get.toNamed("/admin-edit-deceased-profile");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => destroyTextFieldFocus(context),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Get.back(),
              splashRadius: 20,
              icon: const Icon(
                AntDesign.arrowleft,
                color: secondary,
              ),
            ),
            title: Text(
              "EDIT REGISTRANT PROFILE",
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
          ),
          body: Container(
            margin: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: inputTextField(
                        controller: firstName,
                        labelText: "Firstname",
                        hintStyleStyle: GoogleFonts.manrope(fontSize: 12.0),
                        textFieldStyle: GoogleFonts.manrope(fontSize: 12.0),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: inputTextField(
                        controller: lastName,
                        labelText: "Lastname",
                        hintStyleStyle: GoogleFonts.manrope(fontSize: 12.0),
                        textFieldStyle: GoogleFonts.manrope(fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                inputTextField(
                  controller: middleInitial,
                  labelText: "Middle Initial",
                  hintStyleStyle: GoogleFonts.manrope(fontSize: 12.0),
                  textFieldStyle: GoogleFonts.manrope(fontSize: 12.0),
                ),
                const SizedBox(height: 10.0),
                inputNumberTextField(
                  controller: contact,
                  labelText: "Contact Number",
                  hintStyleStyle: GoogleFonts.manrope(fontSize: 12.0),
                  textFieldStyle: GoogleFonts.manrope(fontSize: 12.0),
                ),
                const SizedBox(height: 10.0),
                inputTextField(
                  controller: address,
                  labelText: "Home Address",
                  hintStyleStyle: GoogleFonts.manrope(fontSize: 12.0),
                  textFieldStyle: GoogleFonts.manrope(fontSize: 12.0),
                ),
                const SizedBox(height: 10.0),
                inputTextField(
                  controller: relationship,
                  labelText: "Relationship to deceased",
                  hintStyleStyle: GoogleFonts.manrope(fontSize: 12.0),
                  textFieldStyle: GoogleFonts.manrope(fontSize: 12.0),
                ),
                const SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () => _selectImage(),
                  child: _signaturePath == ""
                      ? DottedBorder(
                          color: Colors.grey,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(0),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              height: 150,
                              width: Get.width,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  "UPLOAD SIGNATURE",
                                  style: GoogleFonts.roboto(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : DottedBorder(
                          color: Colors.grey,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(0),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            child: Container(
                              height: 150,
                              width: Get.width,
                              color: Colors.white,
                              child: Stack(
                                children: [
                                  Image.file(
                                    File(_signaturePath),
                                    width: Get.width,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: IconButton(
                                      splashRadius: 20.0,
                                      onPressed: () => _removeSelectedImage(),
                                      icon: const Icon(
                                        AntDesign.closecircle,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
                const Spacer(flex: 4),
                SizedBox(
                  height: 60.0,
                  width: Get.width,
                  child: elevatedButton(
                    action: () => _onNextPage(),
                    backgroundColor: secondary,
                    label: "NEXT",
                    textStyle: GoogleFonts.manrope(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
