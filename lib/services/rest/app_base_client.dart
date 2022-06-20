/* 
  define base client
  NOTE:
    - Add authorization headers: HttpHeaders.authorizationHeader: 'Basic your_api_token_here'
*/

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_base_service/services/rest/app_exceptions.dart';
import 'package:flutter_base_service/utils/constants.dart';
import 'package:http/http.dart' as http;

class AppBaseClient {
  Constants constants = new Constants();

  //GET
  Future<dynamic> get(
      String baseUrl, String api, Map<String, String>? headers) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await http
          .get(uri, headers: headers)
          .timeout(Duration(seconds: Constants.TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj,
      Map<String, String> headers) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);

    try {
      var response = await http
          .post(uri, headers: headers, body: payload)
          .timeout(Duration(seconds: Constants.TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //DELETE
  Future<dynamic> delete(
      String baseUrl, String api, Map<String, String> headers) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await http
          .delete(uri, headers: headers)
          .timeout(Duration(seconds: Constants.TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //UPDATE
  Future<dynamic> put(String baseUrl, String api, Map<String, String> headers,
      dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      var response = await http
          .put(uri, headers: headers, body: payload)
          .timeout(Duration(seconds: Constants.TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //OTHER

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
