
import 'facebook_ads_platform_interface.dart';

class FacebookAds {
  Future<String?> getPlatformVersion() {
    return FacebookAdsPlatform.instance.getPlatformVersion();
  }
}
