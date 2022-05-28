import 'package:bugsweeper/src/pages/game_page.dart';
import 'package:bugsweeper/src/pages/setup_game_page.dart';
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
        '/': (c) => const StartPage(),
        '/setup_game': (c) => SetupGamePage(),
        '/play': (context) {
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
    primaryColor: Colors.amber[800],
    textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
    appBarTheme: baseTheme.appBarTheme.copyWith(
      iconTheme: baseTheme.appBarTheme.iconTheme?.copyWith(
        color: Colors.grey[800],
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Colors.amber[800],
      secondary: Colors.amber[800],
    ),
  );
}
