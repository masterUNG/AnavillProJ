//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <upi_payment_qrcode_generator/upi_payment_qrcode_generator_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) upi_payment_qrcode_generator_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "UpiPaymentQrcodeGeneratorPlugin");
  upi_payment_qrcode_generator_plugin_register_with_registrar(upi_payment_qrcode_generator_registrar);
}
