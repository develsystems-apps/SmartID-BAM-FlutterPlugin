package com.example.flutter_utils_smartid_bam


import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.Context.LOCATION_SERVICE
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.develsystems.smartid.SmartId
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** FlutterUtilsSmartidBamPlugin */
class FlutterUtilsSmartidBamPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, LocationListener {
  private var appContext: Context? = null
  private var activity: Activity? = null
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    this.appContext = flutterPluginBinding.applicationContext;
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_utils_smartid_bam")
    channel.setMethodCallHandler(this)
  }
  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }


  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

    when (call.method) {
      "getInstance" -> {
        getInstanceSmartId(call, result)
      }
      else -> result.notImplemented()
    }
  }

  fun getInstanceSmartId(call: MethodCall, result: Result) {
    startLocation();
    SmartId.getInstance()
      .GetRawData(appContext!!)
      .onSuccess { time, response ->
        val responseMap = mapOf("time" to time, "response" to response)
        result.success(responseMap)
      }
      .onFailure { time, message, errorCode ->
        val errorMap = mapOf("time" to time, "message" to message, "errorCode" to errorCode)
        result.error(errorCode.toString(), message, errorMap)
      }
      .start()
  }

  private fun startLocation() {
    val locationPermissions = arrayOf(
      Manifest.permission.ACCESS_FINE_LOCATION,
      Manifest.permission.ACCESS_COARSE_LOCATION
    )

    val fineLocationPermission = ContextCompat.checkSelfPermission(appContext!!, Manifest.permission.ACCESS_FINE_LOCATION)
    val coarseLocationPermission = ContextCompat.checkSelfPermission(appContext!!, Manifest.permission.ACCESS_COARSE_LOCATION)

    if (fineLocationPermission != PackageManager.PERMISSION_GRANTED
      && coarseLocationPermission != PackageManager.PERMISSION_GRANTED) {
      ActivityCompat.requestPermissions(
        activity!!,
        locationPermissions,
        10
      )
    } else {
      val locationManager =
        appContext!!.getSystemService(LOCATION_SERVICE) as LocationManager
      locationManager.requestLocationUpdates(
        LocationManager.GPS_PROVIDER,
        5000,
        10f,
        this
      )
    }
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    this.activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    this.activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    this.activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    this.activity = null
  }

  override fun onLocationChanged(location: Location) {

  }

  override fun onProviderEnabled(provider: String) {
  }

  override fun onProviderDisabled(provider: String) {
  }

  override fun onStatusChanged(provider: String?, status: Int, extras: Bundle?) {

  }
}
