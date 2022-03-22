import 'package:app/const/colors.dart';
import 'package:app/controllers/burialController.dart';
import 'package:app/helpers/destroy_textfield_focus.dart';
import 'package:app/helpers/pretty_print.dart';
import 'package:app/widget/buttons.dart';
import 'package:app/widget/inputTextField.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

class DeceasedProfile extends StatefulWidget {
  const DeceasedProfile({Key? key}) : super(key: key);

  @override
  State<DeceasedProfile> createState() => _DeceasedProfileState();
}

class _DeceasedProfileState extends State<DeceasedProfile> {
  var locations = [
    "zone-1-a",
    "zone-1-b",
    "zone-1-c",
    "zone-1-d",
    "zone-2-a",
    "zone-2-b",
    "zone-2-c",
    "zone-2-d",
    "zone-3-a",
    "zone-3-b",
    "zone-3-c",
    "zone-4-a",
    "zone-4-b",
    "zone-5-a",
    "zone-5-b",
    "zone-6-a",
    "zone-6-b",
    "zone-6-c",
    "zone-7-a",
    "zone-7-b",
    "zone-7-c",
    "zone-7-d",
  ];
  final _burialController = Get.put(BurialController());

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final middleInitial = TextEditingController();
  final address = TextEditingController();
  final message = TextEditingController();
  final contact = TextEditingController();

  final birth = TextEditingController();
  final death = TextEditingController();
  final burial = TextEditingController();

  final zone = TextEditingController();

  showDateBottomPicker({title, type}) {
    BottomPicker.date(
      height: Get.height * 0.50,
      title: title,
      titleStyle: GoogleFonts.roboto(
        color: secondary,
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
      ),
      buttonAlignement: MainAxisAlignment.end,
      buttonSingleColor: secondary,
      dismissable: false,
      onSubmit: (date) {
        if (type == "birth") {
          birth.text = Jiffy(date).yMMMMd;
          return;
        }
        if (type == "death") {
          death.text = Jiffy(date).yMMMMd;
          return;
        }
        if (type == "burial") {
          burial.text = Jiffy(date).yMMMMd;
          return;
        }
      },
      iconColor: Colors.white,
      onChange: (date) {
        if (type == "birth") {
          birth.text = Jiffy(date).yMMMMd;
          return;
        }
        if (type == "death") {
          death.text = Jiffy(date).yMMMMd;
          return;
        }
        if (type == "burial") {
          burial.text = Jiffy(date).yMMMMd;
          return;
        }
      },
      pickerTextStyle: GoogleFonts.manrope(
        color: secondary,
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
      ),
    ).show(context);
  }

  showZones() {
    BottomPicker(
      height: Get.height * 0.50,
      title: "Available Zones",
      titleStyle: GoogleFonts.roboto(
        color: secondary,
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
      ),
      buttonAlignement: MainAxisAlignment.end,
      buttonSingleColor: secondary,
      dismissable: false,
      onSubmit: (value) {
        zone.text = locations[value].toUpperCase().replaceAll("-", " ");
      },
      iconColor: Colors.white,
      onChange: (value) {
        zone.text = locations[value].toUpperCase().replaceAll("-", " ");
      },
      pickerTextStyle: GoogleFonts.manrope(
        color: secondary,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
      items: [
        Text("zone-1-a".toUpperCase().replaceAll("-", " ")),
        Text("zone-1-b".toUpperCase().replaceAll("-", " ")),
        Text("zone-1-c".toUpperCase().replaceAll("-", " ")),
        Text("zone-1-d".toUpperCase().replaceAll("-", " ")),
        Text("zone-2-a".toUpperCase().replaceAll("-", " ")),
        Text("zone-2-b".toUpperCase().replaceAll("-", " ")),
        Text("zone-2-c".toUpperCase().replaceAll("-", " ")),
        Text("zone-2-d".toUpperCase().replaceAll("-", " ")),
        Text("zone-3-a".toUpperCase().replaceAll("-", " ")),
        Text("zone-3-b".toUpperCase().replaceAll("-", " ")),
        Text("zone-3-c".toUpperCase().replaceAll("-", " ")),
        Text("zone-4-a".toUpperCase().replaceAll("-", " ")),
        Text("zone-4-b".toUpperCase().replaceAll("-", " ")),
        Text("zone-5-a".toUpperCase().replaceAll("-", " ")),
        Text("zone-5-b".toUpperCase().replaceAll("-", " ")),
        Text("zone-6-a".toUpperCase().replaceAll("-", " ")),
        Text("zone-6-b".toUpperCase().replaceAll("-", " ")),
        Text("zone-6-c".toUpperCase().replaceAll("-", " ")),
        Text("zone-7-a".toUpperCase().replaceAll("-", " ")),
        Text("zone-7-b".toUpperCase().replaceAll("-", " ")),
        Text("zone-7-c".toUpperCase().replaceAll("-", " ")),
        Text("zone-7-d".toUpperCase().replaceAll("-", " ")),
      ],
    ).show(context);
  }

  Future<void> _onSubmit() async {
    final _firstName = firstName.text.trim();
    final _lastName = lastName.text.trim();
    final _middleInitial = middleInitial.text.trim();
    final _address = address.text.trim();
    final _message = message.text.trim();

    final _birth = birth.text.trim();
    final _death = death.text.trim();
    final _burial = burial.text.trim();
    final _zone = zone.text.trim().toLowerCase().replaceAll(" ", "-");

    final _isReady = _firstName.isNotEmpty &&
        _lastName.isNotEmpty &&
        _middleInitial.isNotEmpty &&
        _address.isNotEmpty &&
        _birth.isNotEmpty &&
        _death.isNotEmpty &&
        _burial.isNotEmpty &&
        _zone.isNotEmpty;

    if (!_isReady) return;

    Map data = {
      "profile": {
        "firstName": _firstName,
        "lastName": _lastName,
        "middleInitial": _middleInitial,
        "address": _address
      },
      "tombstone": {"lovingMessage": _message, "color": "black-white-gold"},
      "date": {
        "birth": _birth,
        "death": _death,
        "burial": _burial,
      },
      "burialLocation": _zone,
    };
    _burialController.deceasedData = data;

    // prettyPrint("registrant_data", _burialController.registrantData);
    // prettyPrint("deceased_data", _burialController.deceasedData);

    await _burialController.create();
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
              "DECEASED PROFILE",
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
                inputTextField(
                  controller: address,
                  labelText: "Home Address",
                  hintStyleStyle: GoogleFonts.manrope(fontSize: 12.0),
                  textFieldStyle: GoogleFonts.manrope(fontSize: 12.0),
                ),
                const SizedBox(height: 10.0),
                inputTextArea(
                  controller: message,
                  labelText: "Loving Message",
                  hintStyleStyle: GoogleFonts.manrope(fontSize: 12.0),
                  textFieldStyle: GoogleFonts.manrope(fontSize: 12.0),
                ),
                const SizedBox(height: 40.0),
                inputTextField(
                  controller: birth,
                  isReadOnly: true,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  onTap: () {
                    showDateBottomPicker(
                      title: "Birthday",
                      type: "birth",
                    );
                  },
                  labelText: "Birthday",
                  hintStyleStyle: GoogleFonts.manrope(fontSize: 12.0),
                  textFieldStyle: GoogleFonts.manrope(fontSize: 12.0),
                ),
                const SizedBox(height: 10.0),
                inputTextField(
                  controller: death,
                  isReadOnly: true,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  onTap: () {
                    showDateBottomPicker(
                      title: "Died on",
                      type: "death",
                    );
                  },
                  labelText: "Died on",
                  hintStyleStyle: GoogleFonts.manrope(fontSize: 12.0),
                  textFieldStyle: GoogleFonts.manrope(fontSize: 12.0),
                ),
                const SizedBox(height: 10.0),
                inputTextField(
                  controller: burial,
                  isReadOnly: true,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  onTap: () {
                    showDateBottomPicker(
                      title: "Burial date",
                      type: "burial",
                    );
                  },
                  labelText: "Burial date",
                  hintStyleStyle: GoogleFonts.manrope(fontSize: 12.0),
                  textFieldStyle: GoogleFonts.manrope(fontSize: 12.0),
                ),
                const SizedBox(height: 10.0),
                inputTextField(
                  controller: zone,
                  isReadOnly: true,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  onTap: () {
                    showZones();
                  },
                  labelText: "Location/Zone",
                  hintStyleStyle: GoogleFonts.manrope(fontSize: 12.0),
                  textFieldStyle: GoogleFonts.manrope(fontSize: 12.0),
                ),
                const Spacer(flex: 3),
                SizedBox(
                  height: 60.0,
                  width: Get.width,
                  child: elevatedButton(
                    action: () async => await _onSubmit(),
                    backgroundColor: secondary,
                    label: "SAVE",
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
