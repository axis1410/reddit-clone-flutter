import 'package:flutter/material.dart';

import './features/auth/screens/login_screen.dart';
import './theme/pallete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reddit Clone',
      debugShowCheckedModeBanner: false,
      theme: Pallete.darkModeAppTheme,
      home: const Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}
