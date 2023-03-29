import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_page_with_firebase/constant.dart';
import 'package:login_page_with_firebase/page/auth/login_page.dart';
import 'package:login_page_with_firebase/page/auth/sign_up.dart';
import 'package:login_page_with_firebase/page/home_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false, statusBarColor: Colors.indigo));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      // ! FLUTTER'ın paketsiz bir şekilde bizi yönlendirme şekli
      routes: {
        '/loginPage': (context) => const LoginPage(),
        '/signUp': (context) => const SignUp(),
        '/homePage': (context) => const HomePage()
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: CustomColors.textButtonColor),
        scaffoldBackgroundColor: CustomColors.scaffoldBackgroundColor,
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
