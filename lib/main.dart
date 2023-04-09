import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_tutorial/controller/cloud_fire_store_provider.dart';
import 'package:firebase_tutorial/view/screens/main_view/main_view_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CloudFireStoreProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider())
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Firebase Tutorial"),
        ),
        body: const MainViewBody());
  }
}
