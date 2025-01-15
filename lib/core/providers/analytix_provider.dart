

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/core/analitix/abstract/analytix_manager.dart';

// final analyticsManagerProvider = Provider<AnalytixManager>((ref) {
//   return AnalytixManager();
// });
/// Since AnalytixManager is a singleton - creating a provider is useless
/// and creates a boilerplate code that doesn't contribute to our development process.
///
/// TODO:: delete this file, since it's only an example of bad use of the provider architecture
