import 'package:app/const/colors.dart';
import 'package:app/controllers/burialController.dart';
import 'package:app/helpers/destroy_textfield_focus.dart';
import 'package:app/widget/buttons.dart';
import 'package:app/widget/inputTextField.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

class SearchMain extends StatefulWidget {
  const SearchMain({Key? key}) : super(key: key);

  @override
  State<SearchMain> createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {
  final _burialController = Get.put(BurialController());

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final startYear = TextEditingController();
  final endYear = TextEditingController();

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
        if (type == "start") {
          startYear.text = Jiffy(date).yMMMMd;
          return;
        }
        if (type == "end") {
          endYear.text = Jiffy(date).yMMMMd;
          return;
        }
      },
      iconColor: Colors.white,
      onChange: (date) {
        if (type == "start") {
          startYear.text = Jiffy(date).yMMMMd;
          return;
        }
        if (type == "end") {
          endYear.text = Jiffy(date).yMMMMd;
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

  Future<void> handleSearch() async {
    final _firstName = firstName.text.trim();
    final _lastName = lastName.text.trim();
    final _startYear = startYear.text;
    final _endYear = endYear.text;

    if (_startYear.isEmpty) {
      showDateBottomPicker(
        title: "Start year",
        type: "start",
      );
      return;
    }
    if (_endYear.isEmpty) {
      showDateBottomPicker(
        title: "End year",
        type: "end",
      );
      return;
    }

    _burialController.searchKeyword = {
      "searchBy": "",
      "deathDateStart": _startYear,
      "deathDateEnd": _endYear,
      "firstName": _firstName,
      "lastName": _lastName,
    };
    await _burialController.search();
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
          body: Container(
            margin: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: Column(
              children: [
                const Spacer(flex: 2),
                // Image.asset(
                //   "images/undraw_people_search.png",
                //   height: 150.0,
                // ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 9,
                      child: Text(
                        "Find Your Loved Ones using this App",
                        style: GoogleFonts.lobsterTwo(
                          color: secondary,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Icon(
                      MaterialCommunityIcons.candle,
                      color: secondary,
                      size: 54,
                    ),
                  ],
                ),
                const Spacer(),
                inputTextField(
                  controller: firstName,
                  labelText: "Firstname",
                  hintStyleStyle: GoogleFonts.manrope(fontSize: 12.0),
                  textFieldStyle: GoogleFonts.manrope(fontSize: 12.0),
                ),
                const SizedBox(height: 10.0),
                inputTextField(
                  controller: lastName,
                  labelText: "Lastname",
                  hintStyleStyle: GoogleFonts.manrope(fontSize: 12.0),
                  textFieldStyle: GoogleFonts.manrope(fontSize: 12.0),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: inputTextField(
                        controller: startYear,
                        isReadOnly: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        onTap: () {
                          showDateBottomPicker(
                            title: "Start Year",
                            type: "start",
                          );
                        },
                        labelText: "Start Year",
                        hintStyleStyle: GoogleFonts.manrope(fontSize: 12.0),
                        textFieldStyle: GoogleFonts.manrope(fontSize: 12.0),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: inputTextField(
                        controller: endYear,
                        isReadOnly: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        onTap: () {
                          showDateBottomPicker(
                            title: "End Year",
                            type: "end",
                          );
                        },
                        labelText: "End Year",
                        hintStyleStyle: GoogleFonts.manrope(fontSize: 12.0),
                        textFieldStyle: GoogleFonts.manrope(fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 7),
                SizedBox(
                  height: 60.0,
                  width: Get.width,
                  child: elevatedButton(
                    action: () => handleSearch(),
                    backgroundColor: secondary,
                    label: "SEARCH",
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
