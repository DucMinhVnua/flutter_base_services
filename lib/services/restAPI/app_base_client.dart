/* 
  define base client
  NOTE:
    - Add authorization headers: HttpHeaders.authorizationHeader: 'Basic your_api_token_here'
*/

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base_service/services/restAPI/app_exceptions.dart';
import 'package:flutter_base_service/utils/app_utils.dart';
import 'package:flutter_base_service/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class AppBaseClient {
  //GET
  Future<dynamic> get({
    required BuildContext context,
    required String api,
    Map<String, String>? headers,
  }) async {
    var uri = Uri.parse(Constants.BASE_URL + api);
    try {
      var response = await http
          .get(uri, headers: headers)
          .timeout(Duration(seconds: Constants.TIME_OUT_DURATION));
      return _processResponse(response, context);
    } on SocketException {
      // AppUtils.showPopup(
      //     context: context,
      //     title: "Thông báo",
      //     content: "Không có kết nối internet.");
      throw FetchDataException('Không có kết nối internet.', uri.toString());
    } on TimeoutException {
      // AppUtils.showPopup(context,"Thông báo", "API not responded in time.");
      throw ApiNotRespondingException(
          'API not responded in time.', uri.toString());
    }
  }

  //POST
  Future<dynamic> post({
    required BuildContext context,
    required String api,
    required dynamic payloadObj,
    Map<String, String>? headers,
  }) async {
    var uri = Uri.parse(Constants.BASE_URL + api);
    var payload = json.encode(payloadObj);

    try {
      var response = await http
          .post(uri, headers: headers, body: payload)
          .timeout(Duration(seconds: Constants.TIME_OUT_DURATION));
      return _processResponse(response, context);
    } on SocketException {
      // AppUtils.showPopup(
      //     context: context,
      //     title: "Thông báo",
      //     content: "Không có kết nối internet.");
      throw FetchDataException('Không có kết nối internet.', uri.toString());
    } on TimeoutException {
      // AppUtils.showPopup(
      //     context: context,
      //     title: "Thông báo",
      //     content: "API not responded in time.");
      throw ApiNotRespondingException(
          'API not responded in time.', uri.toString());
    }
  }

  //DELETE
  Future<dynamic> delete({
    required BuildContext context,
    required String api,
    Map<String, String>? headers,
  }) async {
    var uri = Uri.parse(Constants.BASE_URL + api);
    try {
      var response = await http
          .delete(uri, headers: headers)
          .timeout(Duration(seconds: Constants.TIME_OUT_DURATION));
      return _processResponse(response, context);
    } on SocketException {
      // AppUtils.showPopup(
      //     context: context,
      //     title: "Thông báo",
      //     content: "Không có kết nối internet.");
      throw FetchDataException('Không có kết nối internet.', uri.toString());
    } on TimeoutException {
      // AppUtils.showPopup(
      //     context: context,
      //     title: "Thông báo",
      //     content: "API not responded in time.");
      throw ApiNotRespondingException(
          'API not responded in time.', uri.toString());
    }
  }

  //UPDATE
  Future<dynamic> put({
    required BuildContext context,
    required String api,
    Map<String, String>? headers,
    required dynamic payloadObj,
  }) async {
    var uri = Uri.parse(Constants.BASE_URL + api);
    var payload = json.encode(payloadObj);
    try {
      var response = await http
          .put(uri, headers: headers, body: payload)
          .timeout(Duration(seconds: Constants.TIME_OUT_DURATION));
      return _processResponse(response, context);
    } on SocketException {
      // AppUtils.showPopup(
      //     context: context,
      //     title: "Thông báo",
      //     content: "Không có kết nối internet.");
      throw FetchDataException('Không có kết nối internet.', uri.toString());
    } on TimeoutException {
      // AppUtils.showPopup(
      //     context: context,
      //     title: "Thông báo",
      //     content: "API not responded in time.");
      throw ApiNotRespondingException(
          'API not responded in time.', uri.toString());
    }
  }

  //OTHER

  dynamic _processResponse(http.Response response, BuildContext context) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 400:
        // AppUtils.showPopup(
        //     context: context,
        //     title: "Thông báo",
        //     content:
        //         "${utf8.decode(response.bodyBytes)} ${response.request!.url.toString()}");
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        // AppUtils.showPopup(
        //     context: context,
        //     title: "Thông báo",
        //     content:
        //         "${utf8.decode(response.bodyBytes)} ${response.request!.url.toString()}");
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        // AppUtils.showPopup(
        //     context: context,
        //     title: "Thông báo",
        //     content:
        //         "${utf8.decode(response.bodyBytes)} ${response.request!.url.toString()}");
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        // AppUtils.showPopup(
        //     context: context,
        //     title: "Thông báo",
        //     content:
        //         "${utf8.decode(response.bodyBytes)} ${response.request!.url.toString()}");
        throw FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
