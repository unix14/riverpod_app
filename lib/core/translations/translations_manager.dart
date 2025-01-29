
import 'translations_map.dart';

enum SupportedLanguages { hebrew, english, arabic }

extension SupportedLanguagesExtension on SupportedLanguages {
  String get languageCode {
    switch (this) {
      case SupportedLanguages.hebrew:
        return 'he_IW';
      case SupportedLanguages.english:
        return 'en_EN';
      case SupportedLanguages.arabic:
        return 'ar_IL';
    }
  }
}

class TranslationsManager {

  Map<String, String> _translationMap = translationsDefaults;

  fetch({SupportedLanguages lang = SupportedLanguages.english}) {

    // _translationMap = {}; // todo network fetch translation
  }

  String get(String key) {
    return _translationMap[key] ?? getDefaultValue(key);
  }

  getDefaultValue(String key) {
    return key;
  }
}

