package com.example.flutter_native

import com.example.flutter_native.pigeons.BatteryPigeon
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        BatteryPigeon.BatteryApi.setup(flutterEngine.dartExecutor.binaryMessenger, BatteryApiImp(this))
    }
}
