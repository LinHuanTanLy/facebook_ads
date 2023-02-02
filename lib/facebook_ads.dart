import 'facebook_ads_platform_interface.dart';

class FacebookAds {
  Future<String?> getPlatformVersion() {
    return FacebookAdsPlatform.instance.getPlatformVersion();
  }

  Future<bool?> clearUserData() {
    return FacebookAdsPlatform.instance.clearUserData();
  }

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
      String? country}) {
    return FacebookAdsPlatform.instance.setUserData(
        email: email,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        dateOfBirth: dateOfBirth,
        gender: gender,
        city: city,
        state: state,
        zip: zip,
        country: country);
  }

  Future<bool?> logEvent(String name,
      {Map<String, dynamic>? parameters, double? valueToSum}) async {
    return FacebookAdsPlatform.instance
        .logEvent(name, parameters: parameters, valueToSum: valueToSum);
  }

  Future<bool?> clearUserID() {
    return FacebookAdsPlatform.instance.clearUserID();
  }

  Future<bool?> flush() {
    return FacebookAdsPlatform.instance.flush();
  }

  Future<String?> getApplicationId() {
    return FacebookAdsPlatform.instance.getApplicationId();
  }

  Future<bool?> logPushNotificationOpen(
      {Map<String, dynamic>? payload, String? action}) {
    return FacebookAdsPlatform.instance
        .logPushNotificationOpen(payload: payload, action: action);
  }

  Future<bool?> setUserID(String userId) {
    return FacebookAdsPlatform.instance.setUserID(userId);
  }

  Future<bool?> setAutoLogAppEventsEnabled(bool enabled) {
    return FacebookAdsPlatform.instance.setAutoLogAppEventsEnabled(enabled);
  }

  Future<bool?> setDataProcessingOptions(
    List<String> options,
    String? country,
    String? state,
  ) {
    return FacebookAdsPlatform.instance
        .setDataProcessingOptions(options, country, state);
  }

  Future<String?> getAnonymousId() {
    return FacebookAdsPlatform.instance.getAnonymousId();
  }

  Future<bool?> logPurchase(
      double? amount, String? currency, Map<String, dynamic> parameters) {
    return FacebookAdsPlatform.instance
        .logPurchase(amount, currency, parameters);
  }

  Future<bool?> logViewContent(String? content, String? id, String? type,
      String currency, double price) {
    return FacebookAdsPlatform.instance
        .logViewContent(content, id, type, currency, price);
  }

  Future<bool?> logAddToCart(
      String? id, String? type, String currency, double price) {
    return FacebookAdsPlatform.instance.logAddToCart(id, type, currency, price);
  }
}
