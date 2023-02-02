#include "include/facebook_ads/facebook_ads_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "facebook_ads_plugin.h"

void FacebookAdsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  facebook_ads::FacebookAdsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
