import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satya_sai/model_class/exhibit_model.dart';
import 'package:satya_sai/provider/audio_player_provider.dart';
import 'package:satya_sai/provider/language_selection_provider.dart';
import 'package:satya_sai/provider/selected_exhibit_provider.dart';
import 'package:satya_sai/screens/detailed_zone/zone_detail.dart';
import 'package:satya_sai/screens/home_page.dart';
import 'package:satya_sai/screens/landing_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:satya_sai/screens/language_slection/language_selection.dart';
import 'package:satya_sai/screens/splash_screen.dart';
import 'package:satya_sai/screens/swami_splash_screen.dart';
import 'package:satya_sai/screens/zone_view/list_view.dart';

import 'generated/l10n.dart';
import 'l10n/l10n.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AudioPlayerProvider>(
            create: (context) => AudioPlayerProvider()),
        ChangeNotifierProvider<SelectedExhibitProvider>(create: (context)=>SelectedExhibitProvider()),
        ChangeNotifierProvider<LanguageSelectionProvider>(create: (context)=>LanguageSelectionProvider())
      ],
      builder: (context, child) => Consumer<LanguageSelectionProvider>(
        builder:(context,obj,_)=> MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          locale: Provider.of<LanguageSelectionProvider>(context,listen:true).locale,
          localizationsDelegates: const [
            // AppLocalizations.delegate,
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute(
                builder: (context) => makeRoute(
                    context: context,
                    routeName: settings.name ?? '',
                    arguments: settings.arguments ?? 's'),
                maintainState: true,
                fullscreenDialog: true);
          },
        ),
      ),
    ),
  );
}

Widget makeRoute(
    {required BuildContext context,
    required String routeName,
    required Object arguments}) {
  final Widget child =
      _buildRoute(context: context, routeName: routeName, arguments: arguments);
  return child;
}

Widget _buildRoute({
  required BuildContext context,
  required String routeName,
  required Object arguments,
}) {
  switch (routeName) {
    case '/':
      return const HomePage();
    case '/SwamiSplashScreen':
      return const SwamiSplashScreen();
    case '/SplashScreen':
      return const SplashScreen();
    case '/LandingPage':
      return const LandingPage();
    case '/ListViewPage':
      return const ListViewPage();
    case '/LanguageSelection':
      return LanguageSelection();
    case '/DetailedZone':
      ExhibitModel exhibit = arguments as ExhibitModel;
      return DetailedZone(exhibit);
    default:
      throw 'Route $routeName is not defined';
  }
}
