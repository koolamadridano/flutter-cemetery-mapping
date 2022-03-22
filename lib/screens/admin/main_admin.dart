import 'package:app/const/colors.dart';
import 'package:app/controllers/burialController.dart';
import 'package:app/helpers/destroy_textfield_focus.dart';
import 'package:app/widget/inputTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loading_indicator/loading_indicator.dart';

class MainAdmin extends StatefulWidget {
  const MainAdmin({Key? key}) : super(key: key);

  @override
  State<MainAdmin> createState() => _MainAdminState();
}

class _MainAdminState extends State<MainAdmin> {
  final _burialController = Get.put(BurialController());
  final _searchKey = TextEditingController();

  late Future _listFuture;
  int? length;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listFuture = _burialController.getAll();
  }

  refreshList() {
    // reload
    setState(() {
      _listFuture = _burialController.getAll();
    });
  }

  search(keyword) {
    setState(() {
      _listFuture = _burialController.getAll(
        fullName: keyword,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => destroyTextFieldFocus(context),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Divine Shepherd Admin",
              style: GoogleFonts.manrope(
                color: secondary,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
            leading: const SizedBox(),
            leadingWidth: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(80.0),
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 10.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: inputTextFieldSearch(
                        controller: _searchKey,
                        labelText: "Search name here...",
                        hintStyleStyle: GoogleFonts.manrope(fontSize: 12.0),
                        textFieldStyle: GoogleFonts.manrope(fontSize: 12.0),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            refreshList();
                            _searchKey.text = "";
                          },
                          icon: const Icon(
                            AntDesign.close,
                            color: secondary,
                          ),
                        ),
                        // suffixIcon: IconButton(
                        //   splashRadius: 20,
                        //   onPressed: () {
                        //     _searchKey.text = "";
                        //   },
                        //   icon: const Icon(
                        //     AntDesign.close,
                        //     color: secondary,
                        //   ),
                        // ),
                        onComplete: () {
                          search(_searchKey.text);
                          destroyTextFieldFocus(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // shape: Border(
            //   bottom: BorderSide(color: secondary.withOpacity(0.2), width: 0.5),
            // ),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () => Get.toNamed("/admin-registrant-profile"),
                splashRadius: 20,
                icon: const Icon(
                  AntDesign.pluscircle,
                  color: secondary,
                ),
              ),
            ],
          ),
          body: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: FutureBuilder(
              future: _listFuture,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Center(
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
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
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
                  );
                }
                if (snapshot.data == null) {
                  return const Center(
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
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data.length == 0) {
                    return Center(
                      child: Text(
                        "No record found",
                        style: GoogleFonts.roboto(
                          color: secondary,
                          fontWeight: FontWeight.w300,
                          fontSize: 12.0,
                        ),
                      ),
                    );
                  }
                }
                return RefreshIndicator(
                  onRefresh: () async => refreshList(),
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _firstName = snapshot.data[index]["deceased"]
                          ["profile"]["firstName"];

                      final _lastName = snapshot.data[index]["deceased"]
                          ["profile"]["lastName"];

                      final _middleInitial = snapshot.data[index]["deceased"]
                          ["profile"]["middleInitial"];

                      final _message = snapshot.data[index]["deceased"]
                          ["tombstone"]["lovingMessage"];
                      final _address = snapshot.data[index]["deceased"]
                          ["profile"]["address"];
                      final _death =
                          snapshot.data[index]["deceased"]["date"]["death"];
                      final _burial = Jiffy(snapshot.data[index]["deceased"]
                              ["date"]["burial"])
                          .yMMMMd;
                      final _birth =
                          snapshot.data[index]["deceased"]["date"]["birth"];

                      final _deathAndBirth =
                          Jiffy(_birth).yMMMMd + " - " + Jiffy(_death).yMMMMd;

                      final _zone = snapshot.data[index]["burialLocation"];

                      return ListTile(
                        onTap: () {
                          _burialController.selectedProfile =
                              snapshot.data[index];
                          Get.toNamed("/admin-profile-preview");
                        },
                        contentPadding: const EdgeInsets.all(20.0),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Text(
                                _firstName +
                                    " " +
                                    _middleInitial +
                                    " " +
                                    _lastName,
                                style: GoogleFonts.roboto(
                                  color: secondary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.0,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            const Icon(
                              MaterialCommunityIcons.candle,
                              color: secondary,
                              size: 15,
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _deathAndBirth,
                              style: GoogleFonts.roboto(
                                color: secondary,
                                fontWeight: FontWeight.w400,
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              "Buried on $_burial",
                              style: GoogleFonts.roboto(
                                color: secondary,
                                fontWeight: FontWeight.w300,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
