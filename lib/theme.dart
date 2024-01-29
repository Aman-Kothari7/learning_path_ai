import 'package:flutter/material.dart';

// Define custom fonts
final TextStyle rubikBold = TextStyle(
  fontFamily: 'Rubik',
  fontWeight: FontWeight.bold,
  fontSize: 36,
);

final TextStyle montserrat = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 24,
);

final TextStyle openSans = TextStyle(fontFamily: 'OpenSans', fontSize: 20);

final TextStyle notoSans = TextStyle(
  fontFamily: 'NotoSans',
);

// Define your app's theme
final ThemeData customTheme = ThemeData(
  // Primary color, accent color, etc.
  // ...

  // Define text themes with custom fonts and font sizes
  textTheme: TextTheme(
    displayLarge: rubikBold, // Heading should be bold Rubik
    displayMedium: montserrat, // Main body headings like left panel
    bodyLarge: openSans, // The main generated text
    bodyMedium: notoSans, // An alternative font for the main text
  ),
);
