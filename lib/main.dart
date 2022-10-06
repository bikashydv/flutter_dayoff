import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dayoff/logic/company_profile_provider.dart';
import 'package:dayoff/logic/holiday_request_provider.dart';
import 'package:dayoff/screens/login_screen/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'logic/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) {
            return AuthProvider(FirebaseFirestore.instance);
          }),
          ChangeNotifierProvider(create: (context) {
            return HolidayRequestProvider();
          }),
          ChangeNotifierProvider(create: (context) {
            return CompanyProfile();
          }),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoginPage(),
        ));
  }
}

class Temp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Text("ASD"),
    );
  }
}
