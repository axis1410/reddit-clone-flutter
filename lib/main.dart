import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './features/auth/screens/login_screen.dart';
import './theme/pallete.dart';
import './firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
