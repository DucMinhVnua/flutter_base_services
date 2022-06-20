import 'package:flutter/material.dart';
import 'package:flutter_base_service/services/rest/app_base_client.dart';
import 'package:flutter_base_service/utils/app_utils.dart';
import 'package:flutter_base_service/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () async {
                var deviceID = await AppUtils().getDeviceId();
                Map<String, String> headers = {
                  "SiteId": "184",
                  "DeviceId": deviceID,
                  'Content-Type': 'application/json',
                };
                Map<String, String> payloadObj = {"title": "Hello"};
                var response = await AppBaseClient()
                    .get(Constants.BASE_URL, 'posts/1', {});

                var a = 3;
              },
              child: Text('Call api'))),
    );
  }
}
