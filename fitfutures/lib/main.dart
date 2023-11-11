import 'package:fitfutures/model/user_data_notifier.dart';
import 'package:fitfutures/screens/main_screen.dart';
import 'package:fitfutures/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserDataNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      initialRoute: "/main",
      routes: {
        "/register": (context) => const RegisterScreen(),
        "/main": (context) => const MainScreen(),
      },
    );
  }
}
