import 'package:dot_my_services/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DOT Services',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black87),
          elevation: 2,
        ),
        fontFamily: 'Nunito',
      ),
      home: HomePage(),
    );
  }
}
