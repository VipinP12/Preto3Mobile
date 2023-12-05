import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/network/app_exceptions.dart';
import 'package:preto3/network/socket_server.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/toast.dart';

import '../utils/app_routes.dart';
import 'api_end_points.dart';

class BaseClient with BaseController {
  static const int timeOutDuration = 60;
  final storageBox = GetStorage();

  //LOGIN REQUEST
  Future<dynamic> loginPost(
      String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    log("FULL URL:$uri");
    try {
      var response = await http
          .post(uri,
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: payload)
          .timeout(const Duration(seconds: timeOutDuration));
      print("RESPONSE CODE:${response.statusCode}");

      return processResponse(response);
    } on SocketException {
      throw const SocketException(
        'No Internet connection',
      );
    } on TimeoutException {
      log("Time out Error: " + uri.toString());
      throw ApiNotRespondingException(
        'Server not responding',
      );
    }
  }

  //GET REQUEST
  Future<dynamic> get(String baseUrl, String api, {flag = false}) async {
    var uri = Uri.parse(baseUrl + api);
    log("FULL URL:$uri");

    try {
      var response = await http.get(
        Uri.parse(baseUrl + api),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Basic ${base64.encode(utf8.encode('${storageBox.read(AppKeys.keyEmail)}:${storageBox.read(AppKeys.keyPassword)}'))}',
        },
      ).timeout(const Duration(seconds: timeOutDuration));
      return processResponse(response);
    } on SocketException {
      throw const SocketException(
        'No Internet connection',
      );
    } on TimeoutException {
      if (!flag) {
        log("Time out Error: $uri");
        removeIfApiException();
        throw ApiNotRespondingException(
          'Server not responding',
        );
      }
    }
  }

  //POST REQUEST
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj,
      {flag = false}) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    var authorize =
        'Basic ${base64.encode(utf8.encode('${storageBox.read(AppKeys.keyEmail)}:${storageBox.read(AppKeys.keyPassword)}'))}';
    log("FULL URL:$uri");
    log("FULL URL:${storageBox.read(AppKeys.keyEmail)}");
    log("FULL URL:${storageBox.read(AppKeys.keyPassword)}");
    try {
      var response = await http
          .post(uri,
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': authorize,
              },
              body: payload)
          .timeout(const Duration(seconds: timeOutDuration));
      print("RESPONSE CODE:${response.statusCode}");
      return processResponse(response);
    } on SocketException {
      throw const SocketException(
        'No Internet connection',
      );
    } on TimeoutException {
      if (!flag) {
        log("Time out Error: " + uri.toString());
        removeIfApiException();
        throw ApiNotRespondingException(
          'Server not responding',
        );
      }
    }
  }

  //PUT REQUEST
  Future<dynamic> put(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    var authorize =
        'Basic ${base64.encode(utf8.encode('${storageBox.read(AppKeys.keyEmail)}:${storageBox.read(AppKeys.keyPassword)}'))}';
    log("FULL URL:$uri");
    try {
      var response = await http
          .put(uri,
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': authorize,
              },
              body: payload)
          .timeout(const Duration(seconds: timeOutDuration));
      print("RESPONSE CODE:${response.statusCode}");
      return processResponse(response);
    } on SocketException {
      throw const SocketException(
        'No Internet connection',
      );
    } on TimeoutException {
      removeIfApiException();
      log("Time out Error: " + uri.toString());
      throw ApiNotRespondingException(
        'Server not responding',
      );
    }
  }

  //PATCH
  Future<dynamic> patch(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    var authorize =
        'Basic ${base64.encode(utf8.encode('${storageBox.read(AppKeys.keyEmail)}:${storageBox.read(AppKeys.keyPassword)}'))}';
    log("FULL URL:$uri");
    try {
      var response = await http
          .patch(uri,
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': authorize,
              },
              body: payload)
          .timeout(const Duration(seconds: timeOutDuration));
      return processResponse(response);
    } on SocketException {
      throw FetchDataException(
        'No Internet connection',
      );
    } on TimeoutException {
      log("Time out Error: " + uri.toString());
      removeIfApiException();
      throw ApiNotRespondingException(
        'Server not responding',
      );
    }
  }

  //PATCH WITH AUTHORIZATION
  Future<dynamic> patchWithOutAuth(
      String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);

    var payload = json.encode(payloadObj);
    print(uri);
    print(payload);
    try {
      var response = await http
          .patch(uri,
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: payload)
          .timeout(const Duration(seconds: timeOutDuration));
      return processResponse(response);
    } on SocketException {
      throw FetchDataException(
        'No Internet connection',
      );
    } on TimeoutException {
      log("Time out Error: " + uri.toString());
      removeIfApiException();
      throw ApiNotRespondingException(
        'Server not responding',
      );
    }
  }

  //DELETE
  Future<dynamic> delete(String baseUrl, String api, {flag = false}) async {
    var uri = Uri.parse(baseUrl + api);
    log("FULL URL:$uri");
    log("EMAIL:${storageBox.read(AppKeys.keyEmail)}");
    log("PASSWORD:${storageBox.read(AppKeys.keyPassword)}");

    try {
      var response = await http.delete(
        Uri.parse(baseUrl + api),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Basic ${base64.encode(utf8.encode('${storageBox.read(AppKeys.keyEmail)}:${storageBox.read(AppKeys.keyPassword)}'))}',
        },
      ).timeout(const Duration(seconds: timeOutDuration));
      return processResponse(response);
    } on SocketException {
      throw const SocketException(
        'No Internet connection',
      );
    } on TimeoutException {
      if (!flag) {
        log("Time out Error: " + uri.toString());
        removeIfApiException();
        throw ApiNotRespondingException(
          'Server not responding',
        );
      }
    }
  }

  // POST WITHOUT BASIC AUTH
  Future<dynamic> postWithoutAuth(
      String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      var response = await http
          .post(uri,
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: payload)
          .timeout(const Duration(seconds: timeOutDuration));
      print("RESPONSE CODE:${response.statusCode}");
      return processResponse(response);
    } on SocketException {
      throw const SocketException(
        'No Internet connection',
      );
    } on TimeoutException {
      log("Time out Error: " + uri.toString());
      throw ApiNotRespondingException(
        'Server not responding',
      );
    }
  }

  // POST MULTIPART
  Future<dynamic> postMultipart(
      String baseUrl, String api, String imagePath, String imageName) async {
    var uri = Uri.parse(baseUrl + api);
    var authorize =
        'Basic ${base64.encode(utf8.encode('${storageBox.read(AppKeys.keyEmail)}:${storageBox.read(AppKeys.keyPassword)}'))}';
    log("FULL URL:$uri");
    log("FULL URL:${storageBox.read(AppKeys.keyEmail)}");
    log("FULL URL:${storageBox.read(AppKeys.keyPassword)}");

    try {
      var response = http.MultipartRequest('POST', uri);
      Map<String, String> headers = {
        'Accept': 'application/json',
        "Content-type": "multipart/form-data",
        'Authorization': authorize,
      };
      response.files.add(
        await http.MultipartFile.fromPath(
          'file',
          imagePath,
          filename: imageName,
        ),
      );
      response.headers.addAll(headers);
      var res = await response.send();
      return res;
    } on SocketException {
      throw const SocketException(
        'No Internet connection',
      );
    } on TimeoutException {
      log("Time out Error: " + uri.toString());
      removeIfApiException();
      throw ApiNotRespondingException(
        'Server not responding',
      );
    }
  }

  dynamic processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 204:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.statusCode);
      case 401:
        {
          log("Error code ${response.statusCode} ${response.request}");
          removeIfApiException();
          throw UnAuthorizedException(
              utf8.decode(response.bodyBytes), response.statusCode);
        }
      case 403:
        throw ForbiddenException(
            utf8.decode(response.bodyBytes), response.statusCode);
      case 417:
        {
          log("Error code ${response.statusCode} ${response.request}");
          removeIfApiException();
          throw ExpectationFailed(
              utf8.decode(response.bodyBytes), response.statusCode);
        }
      case 422:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.statusCode);
      case 500:
        throw InternalServerException(
            utf8.decode(response.bodyBytes), response.statusCode);
      default:
        {
          log("Error code ${response.statusCode} ${response.request}");
          throw FetchDataException(
              'Error occured with code : ${response.statusCode}',
              response.statusCode);
        }
    }
  }

  void removeIfApiException() async {
    if (storageBox.read(AppKeys.keyUserName) != null) {
      var response = await BaseClient()
          .get(
              ApiEndPoints.devBaseUrl,
              '${ApiEndPoints.userDeleteDeviceInfo}'
              '?roleId=${storageBox.read(AppKeys.keyRoleId)}&schoolId=${storageBox.read(AppKeys.keySchoolId)}')
          .catchError(handleError);
      if (response != null) {
        print(response);
      }
      SocketServer.instance!.socket.close();
    }
    storageBox.erase();
    Get.offAllNamed(AppRoute.login);
  }

//DELETE
//OTHER
}
