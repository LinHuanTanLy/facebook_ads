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
