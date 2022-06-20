import 'package:device_info/device_info.dart';
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
}
