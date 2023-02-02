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
}
