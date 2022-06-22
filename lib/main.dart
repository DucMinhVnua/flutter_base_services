import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base_service/services/graphQL/app_base_GraphQL.dart';
import 'package:flutter_base_service/services/restAPI/app_base_client.dart';
import 'package:flutter_base_service/utils/app_utils.dart';
import 'package:flutter_base_service/utils/app_constants.dart';
import 'package:flutter_base_service/utils/graphQL_query_request.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        home: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Constants constants = Constants();
  String text = 'click';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () async {
                // ========== TEST REST API
                var deviceID = await AppUtils().getDeviceId();
                Map<String, String> headers = {
                  "SiteId": "184",
                  "DeviceId": deviceID,
                  'Content-Type': 'application/json',
                };
                Map<String, String> payloadObj = {"title": "Hello"};
                var response = jsonDecode(
                    await AppBaseClient().get(api: 'posts', headers: headers));

                // ========== TEST GRAPHQL API
                // var response = await AppBaseGraphQL.callApi(
                //   body: queryGetPersons,
                //   variables: {
                //     // "firstname": "update name 10",
                //   },
                //   headers: {
                //     "x-hasura-admin-secret":
                //         "cCy7wDV7WyioGilcndPAYPb4DdgMYQVKG4FH8rIfVN0bs6S4bk426QMIxHIu5aH4"
                //   },
                // );
                var d = 3;
              },
              child: Text(text))),
    );
  }
}
