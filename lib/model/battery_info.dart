enum BatteryState {
  unknown,
  charging,
  full,
  discharging;

  static BatteryState fromString(String state) {
    switch (state) {
      case 'unknown':
        return BatteryState.unknown;
      case 'charging':
        return BatteryState.charging;
      case 'full':
        return BatteryState.full;
      case 'discharging':
        return BatteryState.discharging;
      default:
        return BatteryState.unknown;
    }
  }
}

class BatteryInfo {
  BatteryInfo({required this.batteryLevel, required this.batteryState});

  final int batteryLevel;
  final BatteryState batteryState;

  factory BatteryInfo.fromJson(Map<String, dynamic> json) {
    return BatteryInfo(
      batteryLevel: json['batteryLevel'],
      batteryState: BatteryState.fromString(json['batteryState']),
    );
  }
}
