import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nested/nested.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/theme/theme.dart';

void mainCommon(List<SingleChildWidget> providers) {
  runApp(
    MultiProvider(
      providers: providers,
      child: MaterialApp(debugShowCheckedModeBanner: false, home: BlaBlaApp()),
    ),
  );
}
class BlaBlaApp extends StatelessWidget {
  const BlaBlaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: blaTheme,
      home: Scaffold(body: HomeScreen()),
    );
  }
}