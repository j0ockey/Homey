import 'package:flutter/material.dart';
import 'package:homey/auth/reset.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './pages/home_page.dart';
import './auth/login.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print('##### Hello User #####');
      } else {
        print('##### Not signed in #####');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              shadowColor: Colors.grey[50],
              elevation: 4.5,
              backgroundColor: const Color(0xFF72B4FF),
              titleTextStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: const IconThemeData(color: Colors.white))),
      // color: const Color(0xFF72B4FF),

      home: FirebaseAuth.instance.currentUser == null
          ? const Login()
          : const HomePage(),
      routes: {
        "login": (context) => const Login(),
        "homepage": (context) => const HomePage(),
        "reset": (context) => const Reset()
      },
    );
  }
}
