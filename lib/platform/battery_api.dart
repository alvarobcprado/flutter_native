import 'package:flutter/services.dart';
import 'package:flutter_native/model/battery_info.dart';
import 'package:flutter_native/platform/channel_utils.dart';

class BatteryApi {
  static const MethodChannel _channel = MethodChannel(
    '$defaultChannelName/battery',
  );

  Future<BatteryInfo> getBatteryLevel() async {
    try {
      final result = await _channel.invokeMapMethod<String, dynamic>(
        'getBatteryInfo',
      );
      return BatteryInfo.fromJson(result!);
    } catch (e) {
      return BatteryInfo(batteryLevel: -1, batteryState: BatteryState.unknown);
    }
  }
}
