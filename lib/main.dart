import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:taska/app/app.bottomsheets.dart';
import 'package:taska/app/app.locator.dart';
import 'package:taska/app/app.router.dart';
import 'package:taska/utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await setupLocator();
  setupBottomSheetUi();
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.homeView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      theme: kTLightTheme,
      darkTheme: kTDarkTheme,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
