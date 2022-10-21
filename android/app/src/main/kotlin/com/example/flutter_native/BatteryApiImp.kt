package com.example.flutter_native

import com.example.flutter_native.pigeons.BatteryPigeon
import com.example.flutter_native.pigeons.BatteryPigeon.BatteryApi
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES


class BatteryApiImp(private val mContext: Context) : BatteryApi{

    override fun getBatteryInfo(result: BatteryPigeon.Result<BatteryPigeon.BatteryInfo>?) {

        val batteryInfo = BatteryPigeon.BatteryInfo.Builder()
            .setState(getBatteryState())
            .setLevel(getBatteryLevel())

        result?.success(batteryInfo.build())
    }

    private fun getBatteryLevel(): Long {
        val batteryLevel: Int = if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP){
            val batteryManager  = mContext.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        }else{
            val intent = ContextWrapper(mContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)*100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel.toLong()
    }

    private fun getBatteryState(): BatteryPigeon.BatteryState{
        val intent = ContextWrapper(mContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))

        when (intent!!.getIntExtra(BatteryManager.EXTRA_STATUS, -1)) {
            BatteryManager.BATTERY_STATUS_FULL -> {
                return BatteryPigeon.BatteryState.FULL
            }
            BatteryManager.BATTERY_STATUS_CHARGING -> (
                    return BatteryPigeon.BatteryState.CHARGING
                    )
            BatteryManager.BATTERY_STATUS_DISCHARGING, BatteryManager.BATTERY_STATUS_NOT_CHARGING -> {
                return BatteryPigeon.BatteryState.DISCHARGING
            }
            else -> {
                return BatteryPigeon.BatteryState.UNKNOWN
            }
        }
    }
}