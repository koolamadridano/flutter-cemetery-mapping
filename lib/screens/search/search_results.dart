import 'package:app/const/colors.dart';
import 'package:app/controllers/burialController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  final _burialController = Get.put(BurialController());

  late Future _listFuture;
  int? length;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listFuture = _burialController.search();
  }

  void refreshList() {
    // reload
    setState(() {
      _listFuture = _burialController.search();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _burialController.searchKeyword["deathDateStart"] +
              " - " +
              _burialController.searchKeyword["deathDateEnd"],
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
      body: FutureBuilder(
        future: _listFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const LinearProgressIndicator(
              minHeight: 1,
              color: secondary,
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator(
              minHeight: 1,
              color: secondary,
            );
          }
          if (snapshot.data == null) {
            return const LinearProgressIndicator(
              minHeight: 1,
              color: secondary,
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
                final _firstName =
                    snapshot.data[index]["deceased"]["profile"]["firstName"];

                final _lastName =
                    snapshot.data[index]["deceased"]["profile"]["lastName"];

                final _middleInitial = snapshot.data[index]["deceased"]
                    ["profile"]["middleInitial"];

                final _message = snapshot.data[index]["deceased"]["tombstone"]
                    ["lovingMessage"];
                final _address =
                    snapshot.data[index]["deceased"]["profile"]["address"];
                final _death =
                    snapshot.data[index]["deceased"]["date"]["death"];
                final _birth =
                    snapshot.data[index]["deceased"]["date"]["birth"];
                final _deathAndBirth =
                    Jiffy(_birth).yMMMMd + " - " + Jiffy(_death).yMMMMd;

                final _zone = snapshot.data[index]["burialLocation"];

                return ListTile(
                  onTap: () {
                    _burialController.selectedProfile["firstName"] = _firstName;
                    _burialController.selectedProfile["lastName"] = _lastName;
                    _burialController.selectedProfile["middleInitial"] =
                        _middleInitial;
                    _burialController.selectedProfile["message"] = _message;
                    _burialController.selectedProfile["address"] = _address;
                    _burialController.selectedProfile["death"] = _death;
                    _burialController.selectedProfile["birth"] = _birth;
                    _burialController.selectedProfile["deathAndBirth"] =
                        _deathAndBirth;
                    _burialController.selectedProfile["zone"] = _zone;
                    Get.toNamed("/search-results-item-preview");
                  },
                  contentPadding: const EdgeInsets.all(20.0),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          _firstName + " " + _middleInitial + " " + _lastName,
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
                        _message,
                        style: GoogleFonts.manrope(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.0,
                          fontStyle: FontStyle.italic,
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
    );
  }
}
