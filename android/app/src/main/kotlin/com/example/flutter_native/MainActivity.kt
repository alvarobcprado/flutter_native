package com.example.flutter_native

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private  val batteryChannel = "com.example.flutter_native/battery"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, batteryChannel).setMethodCallHandler { call, result ->
            if (call.method == "getBatteryInfo") {
                val batteryApi = BatteryApiImp(this)
                batteryApi.getBatteryInfo(result)
            } else {
                result.notImplemented()
            }
        }
    }
}
