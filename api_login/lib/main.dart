

import 'package:api_login/controller/auth_contrller.dart';
import 'package:api_login/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
    ],child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    ),
    );
  }
}

