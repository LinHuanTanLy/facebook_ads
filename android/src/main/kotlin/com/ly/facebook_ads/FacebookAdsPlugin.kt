package com.ly.facebook_ads

import android.content.Context
import android.os.AsyncTask
import android.os.Bundle
import android.text.TextUtils
import android.util.Log
import androidx.annotation.NonNull
import com.facebook.FacebookSdk
import com.facebook.appevents.AppEventsConstants
import com.facebook.appevents.AppEventsLogger
import com.google.android.gms.ads.identifier.AdvertisingIdClient
import com.google.android.gms.common.GooglePlayServicesNotAvailableException
import com.google.android.gms.common.GooglePlayServicesRepairableException
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.IOException
import java.util.*


/** FacebookAdsPlugin */
class FacebookAdsPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var logger: AppEventsLogger
    private lateinit var anonymousId: String
    private lateinit var context: Context
    private lateinit var googleAdvertisingID: String
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "facebook_ads")
        context = flutterPluginBinding.applicationContext
        channel.setMethodCallHandler(this)
        logger = AppEventsLogger.newLogger(flutterPluginBinding.applicationContext)
        anonymousId =
            AppEventsLogger.getAnonymousAppDeviceGUID(flutterPluginBinding.applicationContext)
        getGoogleAdvertisingID(context)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getPlatformVersion" -> handlePlatformVersion(call, result)
            "clearUserData" -> handleClearUserData(call, result)
            "setUserData" -> handleSetUserData(call, result)
            "clearUserID" -> handleCleanUserId(call, result)
            "flush" -> handleFlush(call, result)
            "getApplicationId" -> handleGetApplicationId(call, result)
            "logEvent" -> handleLogEvent(call, result)
            "logPushNotificationOpen" -> handleLogPushNotificationOpen(call, result)
            "setUserID" -> handleSetUserId(call, result)
            "setAutoLogAppEventsEnabled" -> handleSetAutoLogAppEventsEnabled(call, result)
            "setDataProcessingOptions" -> handleSetDataProcessingOptions(call, result)
            "getAnonymousId" -> handleGetAnonymousId(call, result)
            "logPurchase" -> handlePurchased(call, result)
            "logViewContent" -> handleLogViewContent(call, result)
            "logAddToCart" -> handleLogAddToCart(call, result)
            "getGoogleAdvertisingID" -> handleGoogleAdvertisingID(call, result)
        }
    }

    /**
     * 加入购物车
     */
    private fun handleLogAddToCart(call: MethodCall, result: Result) {
        val id = call.argument("id") as? String
        val type = call.argument("type") as? String
        val currency = call.argument("currency") as? String
        val price = call.argument("price") as? Double

        val map = mapOf<String, Any?>(
            "id" to id,
            "type" to type,
            "currency" to currency,
            "price" to price,
        )
        val parameterBundle = createBundleFromMap(map)
        logger.logEvent(
            AppEventsConstants.EVENT_NAME_ADDED_TO_CART, parameters = parameterBundle
        )
        result.success(true)
    }


    /**
     * 购买事件
     */
    private fun handlePurchased(call: MethodCall, result: Result) {
        val amount = (call.argument("amount") as? Double)?.toBigDecimal()
        val currency = Currency.getInstance(call.argument("currency") as? String)
        val parameters = call.argument("parameters") as? Map<String, Object>
        val parameterBundle = createBundleFromMap(parameters) ?: Bundle()

        logger.logPurchase(amount, currency, parameterBundle)
        result.success(true)
    }

    /**
     * 获取AnonymousId
     */
    private fun handleGetAnonymousId(call: MethodCall, result: Result) {
        result.success(anonymousId)
    }

    /**
     * 设置数据处理选项
     */
    private fun handleSetDataProcessingOptions(call: MethodCall, result: Result) {
        val options = call.argument("options") as? ArrayList<String> ?: arrayListOf()
        val country = call.argument("country") as? Int ?: 0
        val state = call.argument("state") as? Int ?: 0
        FacebookSdk.setDataProcessingOptions(options.toTypedArray(), country, state)
        result.success(true)
    }

    /**
     * 为应用程序 com.facebook.appevents.AppEventsLogger 设置自动记录事件标志
     */
    private fun handleSetAutoLogAppEventsEnabled(call: MethodCall, result: Result) {
        val enabled = call.arguments as Boolean
        FacebookSdk.setAutoLogAppEventsEnabled(enabled)
        result.success(true)
    }

    /**
     * ViewContent事件
     */
    private fun handleLogViewContent(call: MethodCall, result: Result) {

        val content = call.argument("content") as? String
        val id = call.argument("id") as? String
        val type = call.argument("type") as? String
        val currency = call.argument("currency") as? String
        val price = call.argument("price") as? Double

        val map = mapOf<String, Any?>(
            "content" to content,
            "id" to id,
            "type" to type,
            "currency" to currency,
            "price" to price,
        )
        val parameterBundle = createBundleFromMap(map)
        logger.logEvent(
            AppEventsConstants.EVENT_NAME_VIEWED_CONTENT, parameters = parameterBundle
        )
        result.success(true)
    }


    /**
     * 设置用户id
     */
    private fun handleSetUserId(call: MethodCall, result: Result) {
        val userId = call.argument("userId") as? String
        AppEventsLogger.setUserID(userId)
        result.success(true)
    }

    /**
     * 推送开关
     */
    private fun handleLogPushNotificationOpen(call: MethodCall, result: Result) {
        val payload = call.argument("payload") as? Map<String, Objects>
        val action = call.argument("action") as? String
        val parameterBundle = createBundleFromMap(payload)
        if (parameterBundle != null && action != null) {
            logger.logPushNotificationOpen(payload = parameterBundle, action = action)
            result.success(true)
        } else {
            result.success(false)
        }
    }

    /**
     * log事件
     */
    private fun handleLogEvent(call: MethodCall, result: Result) {
        val eName = call.argument("name") as? String
        val eParams = call.argument("parameters") as? Map<String, Objects>
        val eValueToSum = call.argument("valueToSum") as? Double
        if (eParams != null && eValueToSum != null) {
            val parameterBundle = createBundleFromMap(eParams)
            logger.logEvent(eName, eValueToSum, parameterBundle)
        } else if (eParams != null) {
            val parameterBundle = createBundleFromMap(eParams)
            logger.logEvent(eName, parameterBundle)
        } else if (eValueToSum != null) {
            logger.logEvent(eName, eValueToSum)
        } else {
            logger.logEvent(eName)
        }
        result.success(true)
    }

    /**
     * 获取ApplicationId
     */
    private fun handleGetApplicationId(call: MethodCall, result: Result) {
        result.success(logger.applicationId)
    }

    /**
     * 刷新
     */
    private fun handleFlush(call: MethodCall, result: Result) {
        logger.flush()
        result.success(true)
    }

    /**
     * 清除用户id
     */
    private fun handleCleanUserId(call: MethodCall, result: Result) {
        AppEventsLogger.clearUserID()
        result.success(true)
    }

    /**
     * 设置用户数据
     */
    private fun handleSetUserData(call: MethodCall, result: Result) {
        val parameters = call.argument("parameters") as? Map<String, Object>
        val parameterBundle = createBundleFromMap(parameters)

        AppEventsLogger.setUserData(
            parameterBundle?.getString("email"),
            parameterBundle?.getString("firstName"),
            parameterBundle?.getString("lastName"),
            parameterBundle?.getString("phone"),
            parameterBundle?.getString("dateOfBirth"),
            parameterBundle?.getString("gender"),
            parameterBundle?.getString("city"),
            parameterBundle?.getString("state"),
            parameterBundle?.getString("zip"),
            parameterBundle?.getString("country")
        )

        result.success("")
    }

    /**
     * 清除用户数据
     */
    private fun handleClearUserData(call: MethodCall, result: Result) {
        AppEventsLogger.clearUserData()
        result.success(true)
    }

    private fun handlePlatformVersion(call: MethodCall, result: Result) {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    private fun createBundleFromMap(parameterMap: Map<String, Any?>?): Bundle? {
        if (parameterMap == null) {
            return null
        }

        val bundle = Bundle()
        for (jsonParam in parameterMap.entries) {
            val value = jsonParam.value
            val key = jsonParam.key
            if (value is String) {
                bundle.putString(key, value as String)
            } else if (value is Int) {
                bundle.putInt(key, value as Int)
            } else if (value is Long) {
                bundle.putLong(key, value as Long)
            } else if (value is Double) {
                bundle.putDouble(key, value as Double)
            } else if (value is Boolean) {
                bundle.putBoolean(key, value as Boolean)
            } else if (value is Map<*, *>) {
                val nestedBundle = createBundleFromMap(value as Map<String, Any>)
                bundle.putBundle(key, nestedBundle as Bundle)
            } else {
                throw IllegalArgumentException(
                    "Unsupported value type: " + value?.javaClass?.kotlin
                )
            }
        }
        return bundle
    }

    private fun handleGoogleAdvertisingID(call: MethodCall, result: Result) {
        if (TextUtils.isEmpty(googleAdvertisingID)) {
            getGoogleAdvertisingID(context)
        }
        result.success(googleAdvertisingID)
    }


    private fun getGoogleAdvertisingID(context: Context): String? {
        AsyncTask.execute(Runnable {
            try {
                val adInfo: AdvertisingIdClient.Info =
                    AdvertisingIdClient.getAdvertisingIdInfo(context)
                val adId: String? = adInfo.id
                adId?.let { Log.e("adId", it) }
                if (adId != null) {
                    googleAdvertisingID = adId
                };
            } catch (exception: IOException) {
                // Error handling if needed
                exception.printStackTrace()
            } catch (exception: GooglePlayServicesRepairableException) {
                exception.printStackTrace()
            } catch (exception: GooglePlayServicesNotAvailableException) {
                exception.printStackTrace()
            }
        })
        return ""
    }
}
