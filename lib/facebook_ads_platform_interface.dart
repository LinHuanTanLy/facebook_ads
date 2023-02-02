import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'facebook_ads_method_channel.dart';

abstract class FacebookAdsPlatform extends PlatformInterface {
  /// Constructs a FacebookAdsPlatform.
  FacebookAdsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FacebookAdsPlatform _instance = MethodChannelFacebookAds();

  /// The default instance of [FacebookAdsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFacebookAds].
  static FacebookAdsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FacebookAdsPlatform] when
  /// they register themselves.
  static set instance(FacebookAdsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> clearUserData() {
    throw UnimplementedError('clearUserData() has not been implemented.');
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
    throw UnimplementedError('setUserData() has not been implemented.');
  }

  Future<bool?> clearUserID() {
    throw UnimplementedError('clearUserID() has not been implemented.');
  }

  Future<bool?> flush() {
    throw UnimplementedError('flush() has not been implemented.');
  }

  Future<String?> getApplicationId() {
    throw UnimplementedError('getApplicationId() has not been implemented.');
  }

  Future<bool?> logEvent(String name,
      {Map<String, dynamic>? parameters, double? valueToSum}) {
    throw UnimplementedError('logEvent() has not been implemented.');
  }

  Future<bool?> logPushNotificationOpen(
      {Map<String, dynamic>? payload, String? action}) {
    throw UnimplementedError(
        'logPushNotificationOpen() has not been implemented.');
  }

  Future<bool?> setUserID(String userId) {
    throw UnimplementedError('setUserID() has not been implemented.');
  }

  Future<bool?> setAutoLogAppEventsEnabled(bool enabled) {
    throw UnimplementedError(
        'setAutoLogAppEventsEnabled() has not been implemented.');
  }

  Future<bool?> setDataProcessingOptions(
    List<String> options,
    String? country,
    String? state,
  ) {
    throw UnimplementedError(
        'setDataProcessingOptions() has not been implemented.');
  }

  Future<String?> getAnonymousId() {
    throw UnimplementedError('getAnonymousId() has not been implemented.');
  }

  Future<bool?> logPurchase(
      double? amount, String? currency, Map<String, dynamic> parameters) {
    throw UnimplementedError('logPurchase() has not been implemented.');
  }

  Future<bool?> logViewContent(String? content, String? id, String? type,
      String currency, double price) {
    throw UnimplementedError('logViewContent() has not been implemented.');
  }

  Future<bool?> logAddToCart(
      String? id, String? type, String currency, double price) {
    throw UnimplementedError('logAddToCart() has not been implemented.');
  }
}
