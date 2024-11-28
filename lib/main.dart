import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shihas_noviindus/Providers/loginprovider.dart';
import 'package:shihas_noviindus/Providers/patientProvider.dart';
import 'package:shihas_noviindus/Views/splash.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => PatientProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noviindus Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}



// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Noviindus Test',
//       theme: ThemeData(
//         primaryColor: const Color(0xFF006837), // Primary color
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color(0xFF006837), // Seed color for dynamic theming
//         ).copyWith(
//           primary: const Color(0xFF006837), // Ensure primary matches
//           secondary: const Color(0xFF4CAF50), // Secondary color
//         ),
//         textTheme: GoogleFonts.poppinsTextTheme(), // Use Poppins font
//         useMaterial3: true,
//       ),
//       home: const SplashScreen(),
//     );
//   }
// }