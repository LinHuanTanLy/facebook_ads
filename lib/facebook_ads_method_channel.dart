import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'facebook_ads_platform_interface.dart';

/// An implementation of [FacebookAdsPlatform] that uses method channels.
class MethodChannelFacebookAds extends FacebookAdsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('facebook_ads');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> clearUserData() async {
    final result = await methodChannel.invokeMethod<bool>('clearUserData');
    return result;
  }

  @override
  Future<String?> setUserData(
      {String? email,
      String? firstName,
      String? lastName,
      String? phone,
      String? dateOfBirth,
      String? gender,
      String? city,
      String? state,
      String? zip,
      String? country}) async {
    return await methodChannel.invokeMethod<String>("setUserData", {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "dateOfBirth": dateOfBirth,
      "gender": gender,
      "city": city,
      "state": state,
      "zip": zip,
      "country": country,
    });
  }

  @override
  Future<bool?> clearUserID() async {
    return await methodChannel.invokeMethod<bool>("clearUserID");
  }

  @override
  Future<bool?> flush() async {
    return await methodChannel.invokeMethod<bool>("flush");
  }

  @override
  Future<String?> getApplicationId() async {
    return await methodChannel.invokeMethod<String>("getApplicationId");
  }

  @override
  Future<bool?> logEvent(String name,
      {Map<String, dynamic>? parameters, double? valueToSum}) async {
    return await methodChannel.invokeMethod<bool>("logEvent",
        {"name": name, "parameters": parameters, "valueToSum": valueToSum});
  }

  @override
  Future<bool?> logPushNotificationOpen(
      {Map<String, dynamic>? payload, String? action}) async {
    return await methodChannel.invokeMethod<bool>("logPushNotificationOpen", {
      "action": action,
      "payload": payload,
    });
  }

  @override
  Future<bool?> setUserID(String userId) async {
    return await methodChannel.invokeMethod<bool>("setUserID", {
      "userId": userId,
    });
  }

  @override
  Future<bool?> setAutoLogAppEventsEnabled(bool enabled) async {
    return await methodChannel.invokeMethod<bool>(
        "setAutoLogAppEventsEnabled", enabled);
  }

  @override
  Future<bool?> setDataProcessingOptions(
      List<String> options, String? country, String? state) async {
    return await methodChannel.invokeMethod<bool>("setDataProcessingOptions",
        {"options": options, "country": country, "state": country});
  }

  @override
  Future<String?> getAnonymousId() async {
    return await methodChannel.invokeMethod<String>("getAnonymousId");
  }

  @override
  Future<bool?> logPurchase(
      double? amount, String? currency, Map<String, dynamic> parameters) async {
    return await methodChannel.invokeMethod<bool>("logPurchase",
        {"amount": amount, "currency": currency, "parameters": parameters});
  }

  @override
  Future<bool?> logAddToCart(
      String? id, String? type, String currency, double price) async {
    return await methodChannel.invokeMethod<bool>("logAddToCart",
        {"type": type, "id": id, "currency": currency, "price": price});
  }

  @override
  Future<bool?> logViewContent(String? content, String? id, String? type,
      String currency, double price) async {
    return await methodChannel.invokeMethod<bool>("logViewContent", {
      "type": type,
      "id": id,
      "currency": currency,
      "price": price,
      "content": content
    });
  }
}
