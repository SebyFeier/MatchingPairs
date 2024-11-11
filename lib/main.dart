import 'package:flutter/material.dart';
import 'package:matching_pairs/first_page.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.system,
      home: const FirstPage()));
}
