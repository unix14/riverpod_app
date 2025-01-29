import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/core/router/navigation_manager.dart';

import 'core/providers/service_locator.dart';

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(appStartupProvider, (previous, state) {
      if(state.value == true){
        ref.read(navigationManagerProvider).goToLoginScreen();
      }
    });

    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 50),
          Text('Initializing...'),
        ],
      ),
    );
  }
}