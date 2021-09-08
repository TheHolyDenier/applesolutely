import 'dart:ui';

import 'package:applesolutely/lang/en_US.dart';
import 'package:applesolutely/lang/es_ES.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalizationService extends Translations {
  final key = 'lng';
  static const local = const Locale('en', 'US');
  static const fallBackLocale = const Locale('en', 'US');
  static final langs = ['English', 'Español'];
  static final locales = [const Locale('en', 'US'), const Locale('es', 'ES')];

  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUS, 'es_ES': esES};

  void changeLocale(String lang) {
    final locale = getLocaleFromLanguage(lang);
    final box = GetStorage();
    box.write(key, lang);
    Get.updateLocale(locale ?? LocalizationService.fallBackLocale);
  }

  Locale? getLocaleFromLanguage(String lang) {
    final int index = langs.indexOf(lang);
    return index == -1 ? Get.locale : locales[index];
  }

  Locale getCurrentLocale() {
    final box = GetStorage();
    if (box.read(key) != null) {
      return getLocaleFromLanguage(box.read(key)) ??
          LocalizationService.fallBackLocale;
    }
    if (Get.deviceLocale != null && locales.contains(Get.deviceLocale!)) {
      changeLocale(langs[locales.indexOf(Get.deviceLocale!)]);
      return Get.deviceLocale!;
    }
    return LocalizationService.fallBackLocale;
  }

  String getCurrentLang() => GetStorage().read(key) ?? 'English';
}
