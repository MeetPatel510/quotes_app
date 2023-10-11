import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/provider/quotes_provider.dart';
import 'package:quotes_app/screen/home_page.dart';
import 'package:quotes_app/screen/intro.dart';
import 'package:quotes_app/screen/splash.dart';


void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => quotesprovider())],
    builder: (context, _) {
      return MaterialApp(
        routes: {
          '/': (context) =>  SplashScreen(),
          'Intro': (context) =>  IntroPae(),
          'Quote': (context) => QuotePage(),
        },
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(
          useMaterial3: true,
        ),
      );
    },
  ));
}
