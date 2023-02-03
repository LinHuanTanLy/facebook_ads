import 'package:flutter_test/flutter_test.dart';
import 'package:facebook_ads/facebook_ads.dart';
import 'package:facebook_ads/facebook_ads_platform_interface.dart';
import 'package:facebook_ads/facebook_ads_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFacebookAdsPlatform
    with MockPlatformInterfaceMixin
    implements FacebookAdsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool?> clearUserData() {
    // TODO: implement clearUserData
    throw UnimplementedError();
  }

  @override
  Future<bool?> clearUserID() {
    // TODO: implement clearUserID
    throw UnimplementedError();
  }

  @override
  Future<bool?> flush() {
    // TODO: implement flush
    throw UnimplementedError();
  }

  @override
  Future<String?> getAnonymousId() {
    // TODO: implement getAnonymousId
    throw UnimplementedError();
  }

  @override
  Future<String?> getApplicationId() {
    // TODO: implement getApplicationId
    throw UnimplementedError();
  }

  @override
  Future<bool?> logAddToCart(String? id, String? type, String currency, double price) {
    // TODO: implement logAddToCart
    throw UnimplementedError();
  }

  @override
  Future<bool?> logEvent(String name, {Map<String, dynamic>? parameters, double? valueToSum}) {
    // TODO: implement logEvent
    throw UnimplementedError();
  }

  @override
  Future<bool?> logPurchase(double? amount, String? currency, Map<String, dynamic> parameters) {
    // TODO: implement logPurchase
    throw UnimplementedError();
  }

  @override
  Future<bool?> logPushNotificationOpen({Map<String, dynamic>? payload, String? action}) {
    // TODO: implement logPushNotificationOpen
    throw UnimplementedError();
  }

  @override
  Future<bool?> logViewContent(String? content, String? id, String? type, String currency, double price) {
    // TODO: implement logViewContent
    throw UnimplementedError();
  }

  @override
  Future<bool?> setAutoLogAppEventsEnabled(bool enabled) {
    // TODO: implement setAutoLogAppEventsEnabled
    throw UnimplementedError();
  }

  @override
  Future<bool?> setDataProcessingOptions(List<String> options, String? country, String? state) {
    // TODO: implement setDataProcessingOptions
    throw UnimplementedError();
  }

  @override
  Future<String?> setUserData({String? email, String? firstName, String? lastName, String? phone, String? dateOfBirth, String? gender, String? city, String? state, String? zip, String? country}) {
    // TODO: implement setUserData
    throw UnimplementedError();
  }

  @override
  Future<bool?> setUserID(String userId) {
    // TODO: implement setUserID
    throw UnimplementedError();
  }
}

void main() {
  final FacebookAdsPlatform initialPlatform = FacebookAdsPlatform.instance;

  test('$MethodChannelFacebookAds is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFacebookAds>());
  });

  test('getPlatformVersion', () async {
    FacebookAds facebookAdsPlugin = FacebookAds();
    MockFacebookAdsPlatform fakePlatform = MockFacebookAdsPlatform();
    FacebookAdsPlatform.instance = fakePlatform;

    expect(await facebookAdsPlugin.getPlatformVersion(), '42');
  });
}
