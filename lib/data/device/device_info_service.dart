import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Future<String> getDeviceId() async {
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.id; // SSAID or Android ID
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
      return iosInfo.identifierForVendor ?? ''; // IDFV
    } else {
      return 'unknown';
    }
  }

  String getDeviceType() {
    if (Platform.isAndroid) {
      return 'ANDROID';
    } else if (Platform.isIOS) {
      return 'IOS';
    } else if (Platform.isFuchsia) {
      return 'FUCHSIA';
    } else if (Platform.isLinux) {
      return 'LINUX';
    } else if (Platform.isMacOS) {
      return 'MACOS';
    } else if (Platform.isWindows) {
      return 'WINDOWS';
    } else {
      return 'UNKNOWN';
    }
  }
}
