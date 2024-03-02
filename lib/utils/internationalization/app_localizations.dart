import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {

  AppLocalizations({this.locale});

  late final Locale? locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String>? _localizedStrings;

  Future<bool> load() async {
    String jsonString;

    try {
      jsonString =
          await rootBundle.loadString('lang/${locale!.languageCode}.json');
    } catch (e) {
      jsonString = await rootBundle.loadString('lang/en.json');
    }

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      if (key == null || key == '') {
        return MapEntry(key, '');
      } else{
        return MapEntry(key, value.toString());
      }

    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return key == null || key == "" ? key : _localizedStrings![key] ?? '';
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'pl'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale: locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => true; //false
}
