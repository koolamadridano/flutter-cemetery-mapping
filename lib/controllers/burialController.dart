import 'package:app/const/uri.dart';
import 'package:app/helpers/pretty_print.dart';
import 'package:dio/dio.dart' as http;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';

class BurialController extends GetxController {
  Map searchKeyword = {};
  Map selectedProfile = {};

  Map registrantData = {};
  Map deceasedData = {};

  Future search() async {
    try {
      Get.toNamed("/search-results");
      var response = await Dio().get(baseUrl + "burial", queryParameters: {
        "searchBy": searchKeyword["type"],
        "deathDateStart": searchKeyword["deathDateStart"],
        "deathDateEnd": searchKeyword["deathDateEnd"],
        "firstName": searchKeyword["firstName"],
        "lastName": searchKeyword["lastName"],
      });
      return response.data;
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future getAll({fullName = ""}) async {
    try {
      var response = await Dio().get(
        baseUrl + "burial/all",
        queryParameters: {
          "fullName": fullName,
        },
      );
      return response.data;
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future delete() async {
    try {
      Get.toNamed("/loading");
      await http.Dio().delete(baseUrl + "burial/${selectedProfile["_id"]}");
      Get.toNamed("/admin");
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future create() async {
    try {
      Get.toNamed("/loading");
      var formData = http.FormData.fromMap({
        'img': await http.MultipartFile.fromFile(
          registrantData["signatureUrl"],
          filename: registrantData["signatureFileName"],
          contentType: MediaType("image", "jpeg"), //important
        ),
      });

      var uploadSignature = await http.Dio().post(
        baseUrl + '/img',
        data: formData,
        onSendProgress: (int sent, int total) {
          if (total == sent) {}
          // print("$sent / $total");
        },
      );
      // UPDATE REGISTRANT signatureUrl
      registrantData["signatureUrl"] = uploadSignature.data["url"];
      var createResponse = await Dio().post(
        baseUrl + "burial",
        data: {
          "registrant": registrantData,
          "deceased": deceasedData,
          "burialLocation": deceasedData["burialLocation"],
          "hasMoved": false,
        },
      );
      Get.toNamed("/admin");
      prettyPrint("createResponse_data", createResponse.data);
    } on DioError catch (e) {
      print(e.response);
    }
  }
}
