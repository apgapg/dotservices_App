import 'package:dot_my_services/pages/home_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DOT Services',
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[observer],
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black87),
          elevation: 0.5,
          color: Colors.white,
        ),
        fontFamily: 'Lato',
      ),
      darkTheme: kIsWeb
          ? null
          : ThemeData(
              brightness: Brightness.dark,
              appBarTheme: AppBarTheme(
                elevation: 1,
              ),
              fontFamily: 'Lato',
            ),
      home: HomePage(),
    );
  }
}
