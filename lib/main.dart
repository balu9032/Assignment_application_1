// import 'package:assignment_1/screens/dummy.dart';
import 'package:assignment_1/screens/homepage.dart';
import 'package:flutter/material.dart';

// final theme = ThemeData(
//   useMaterial3: true,
//   colorScheme: ColorScheme.fromSeed(
//     brightness: Brightness.dark,
//     seedColor: const Color.fromARGB(255, 248, 179, 125),
//   ),
//   textTheme: GoogleFonts.latoTextTheme(),
// );

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      themeMode: ThemeMode.system,
      // theme: theme,
      home: HomePage(),
    );
  }
}
