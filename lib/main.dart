import 'package:bugsweeper/src/pages/game_page.dart';
import 'package:bugsweeper/src/pages/setup_page.dart';
import 'package:bugsweeper/src/pages/start_page.dart';
import 'package:bugsweeper/src/api/difficulty.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bugsweeper',
      theme: _buildTheme(),
      routes: {
        StartPage.routeName: (c) => const StartPage(),
        SetupPage.routeName: (c) => SetupPage(),
        GamePage.routeName: (context) {
          final settings = ModalRoute.of(context)!.settings;
          final difficulty = settings.arguments as Difficulty?;

          return GamePage(difficulty: difficulty ?? Difficulty.easy);
        },
      },
    );
  }
}

ThemeData _buildTheme() {
  final baseTheme = ThemeData(brightness: Brightness.light);

  return baseTheme.copyWith(
    scaffoldBackgroundColor: Colors.grey[100],
    primaryColor: Colors.amber,
    textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
    appBarTheme: baseTheme.appBarTheme.copyWith(
      iconTheme: baseTheme.appBarTheme.iconTheme?.copyWith(
        color: Colors.grey[800],
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Colors.amber,
      secondary: Colors.amber,
    ),
  );
}
