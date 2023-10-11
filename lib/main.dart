import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/model/theme_model.dart';
import 'package:quotes_app/provider/quotes_provider.dart';
import 'package:quotes_app/provider/theme_provider.dart';
import 'package:quotes_app/screen/home_page.dart';
import 'package:quotes_app/screen/intro.dart';
import 'package:quotes_app/screen/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool appTheme = prefs.getBool("isDark") ?? false;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => quotesprovider(),
      ),ChangeNotifierProvider(
        create: (context) => ThemeProvider(
          themeModel: ThemeModel(isDark: appTheme),
        ),
      ),

    ],
    builder: (context, _) {
      return MaterialApp(
        routes: {
          '/': (context) => SplashScreen(),
          'Intro': (context) => IntroPae(),
          'Quote': (context) => QuotePage(),
        },
        debugShowCheckedModeBanner: false,
        title: '',
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ),
        themeMode: (Provider.of<ThemeProvider>(context).themeModel.isDark)
            ? ThemeMode.dark
            : ThemeMode.light,
      );
    },
  ));
}
