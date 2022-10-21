import 'package:pigeon/pigeon.dart';

enum BatteryState { unknown, charging, full, discharging }

class BatteryInfo {
  final int level;
  final BatteryState state;
  BatteryInfo(this.level, this.state);
}

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/dart_pigeons/battery_pigeon.dart',
    javaOut:
        'android/app/src/main/kotlin/com/example/flutter_native/pigeons/BatteryPigeon.java',
    javaOptions: JavaOptions(package: 'com.example.flutter_native.pigeons'),
  ),
)
@HostApi()
abstract class BatteryApi {
  @async
  BatteryInfo getBatteryInfo();
}
