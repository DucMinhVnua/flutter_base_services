/* 
  define base client GrapghQL (query & mutation)
  context: Phục vụ cho show popup
  endpoint: Đường dẫn api
  accessToken: token nếu có
  body: dữ liệu query or mutation
  variables: dữ liệu cung cấp cho body (nếu có)
  headers: headers (nếu có)
*/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base_service/services/restAPI/app_exceptions.dart';
import 'package:flutter_base_service/utils/app_utils.dart';
import 'package:flutter_base_service/utils/app_constants.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AppBaseGraphQL {
  static Future<dynamic> callApi(
      {required String body,
      Map<String, dynamic>? variables,
      Map<String, String>? headers}) async {
    try {
      bool isConnectionAvailable = await checkInternetConnection();
      if (isConnectionAvailable == true) {
        final _httpLink = HttpLink(Constants.BASE_ENDPOINT,
            defaultHeaders: {"content-type": "application/json", ...headers!});

        final _authLink = AuthLink(
          getToken: () async => 'Bearer accessToken',
        );

        Link link = _authLink.concat(_httpLink);

        GraphQLClient client = GraphQLClient(
          cache: GraphQLCache(),
          link: link,
        );

        QueryOptions options = QueryOptions(
          document: gql(body),
          variables: variables!,
        );

        QueryResult queryResult = await client.query(options);
        AppUtils.showPopup("Thông báo", "show thành công");
        return queryResult;
      } else {
        AppUtils.showPopup("Thông báo", "Không có kết nối Internet.");
        return "";
      }
    } on Exception catch (e) {
      AppUtils.showPopup("Exception", e.toString());
    }
  }

  static Future<bool> checkInternetConnection() async {
    bool isConnect = false;
    try {
      // Tim kiem google.com
      final result = await InternetAddress.lookup('google.com');

      // check internet
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnect = true;
      }
    } on SocketException catch (_) {
      isConnect = false;
    }
    return isConnect;
  }
}
