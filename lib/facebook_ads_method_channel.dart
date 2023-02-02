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
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
