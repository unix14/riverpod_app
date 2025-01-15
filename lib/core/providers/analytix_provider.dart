
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/core/analitix/abstract/analytix_manager.dart';

final AutoDisposeProvider<AnalytixManager> analytixProvider = Provider.autoDispose((ref) {
  AnalytixManager analyticsManager = AnalytixManager();
  analyticsManager.addReporters([
    /// Todo:: add more custom reporters ( Such as: Mixpanel and Firebase )
    PrinterReporter(),
    // CustomReporter(),
  ]);
  return analyticsManager;
});