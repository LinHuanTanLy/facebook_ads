//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <facebook_ads/facebook_ads_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) facebook_ads_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FacebookAdsPlugin");
  facebook_ads_plugin_register_with_registrar(facebook_ads_registrar);
}
