package com.example.flutter_native

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import io.flutter.plugin.common.MethodChannel


class BatteryApiImp(private val mContext: Context){

        fun getBatteryInfo(result: MethodChannel.Result) {

            try {
            val batteryState = getBatteryState()
            val batteryLevel = getBatteryLevel()
            val batteryInfo = hashMapOf(
                    "batteryLevel" to batteryLevel,
                    "batteryState" to batteryState,
            )

            result.success(batteryInfo)
            } catch (e: Exception) {
                result.error("UNAVAILABLE", "Battery info not available.", null)
            }
        }

        private fun getBatteryLevel(): Int {
            val batteryLevel: Int = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP){
                val batteryManager  = mContext.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
            }else{
                val intent = ContextWrapper(mContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
                intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)*100 / intent.getIntExtra(
                    BatteryManager.EXTRA_SCALE, -1)
            }

            return batteryLevel
        }

        private fun getBatteryState(): String{
            val intent = ContextWrapper(mContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))

            return when (intent!!.getIntExtra(BatteryManager.EXTRA_STATUS, -1)) {
                BatteryManager.BATTERY_STATUS_FULL -> {
                    "full"
                }
                BatteryManager.BATTERY_STATUS_CHARGING -> {
                    "charging"
                }
                BatteryManager.BATTERY_STATUS_DISCHARGING, BatteryManager.BATTERY_STATUS_NOT_CHARGING -> {
                    "discharging"
                }
                else -> {
                    "unknown"
                }
            }
        }
    }
