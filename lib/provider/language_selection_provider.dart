import 'package:flutter/cupertino.dart';

class LanguageSelectionProvider with ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale language) {
    _locale = language;
    notifyListeners();
  }
}
