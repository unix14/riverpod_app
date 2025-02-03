import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/core/providers/service_locator.dart';

final supportedLanguages = [
  Locale('he', 'IL'),
  Locale('en', 'US'),
  Locale('ar', 'SA'),
];

class LanguageManager extends Notifier<Locale> {
  static const _defaultLanguageKey = "_defaultLanguageKey";
  static const _defaultLocale = Locale('he', 'IL');

  Locale selectedLanguage() => state;

  bool isRTL() => state.languageCode == 'ar' || state.languageCode == 'he';

  void changeLanguage({Locale locale = _defaultLocale}) {
    ref.read(storageManagerProvider.future).then(
          (sm) => sm.put(_defaultLanguageKey, locale.languageCode),
    );
    state = locale;
  }

  @override
  Locale build() {
    ref.read(storageManagerProvider).when(
        data: (sm) {
          sm.get(_defaultLanguageKey, defaultValue: 'he').then((value) =>
              changeLanguage(
                  locale: supportedLanguages
                      .firstWhere((element) => element.languageCode == value)));
        },
        error: (_, __) => supportedLanguages.first,
        loading: () => supportedLanguages.first);
    return supportedLanguages.first;
  }
}
