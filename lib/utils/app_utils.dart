import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_platform/universal_platform.dart';

class AppUtils {
  Future<String> getDeviceId() async {
    String identifier = '';

    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (UniversalPlatform.isAndroid) {
      final AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      identifier = androidDeviceInfo.androidId; // unique ID on Android
    } else if (UniversalPlatform.isIOS) {
      final IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      identifier = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    }

    return identifier;
  }

  // ============================================

  static Future<void> showPopup(
      {required BuildContext context,
      required String title,
      required String content,
      VoidCallback? onAccept}) async {
    // flutter defined function
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

          TextButton(child: const Text('Accept'), onPressed: onAccept),
        ],
      ),
    );
  }

  static Future<void> showPopupCustom(
      {required BuildContext context,
      required String title,
      required String content,
      required Widget child}) async {
    // flutter defined function
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(content: child),
    );
  }
}
