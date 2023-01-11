// loggedOut route
import 'package:flutter/material.dart';
import 'package:reddit_clone_flutter/features/home/screens/home_screen.dart';
import 'package:routemaster/routemaster.dart';

import './features/auth/screens/login_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

// loggedIn route
final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
});
