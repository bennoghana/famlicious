import 'package:famlicious/views/auth/createaccount_view.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Famlicious',
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromRGBO(249, 251, 252, 1),
          cardColor: Colors.white,
          appBarTheme: AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              actionsIconTheme: IconThemeData(color: Colors.black)),
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.black),
            bodyText2: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black)),
      darkTheme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.black,
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              actionsIconTheme: IconThemeData(color: Colors.white))),
      themeMode: ThemeMode.system,
      home:  CreateAccountsView(),
    );
  }
}
