import 'package:firebase_tutorial/view/screens/auth/auth_screen.dart';
import 'package:firebase_tutorial/view/screens/cloud_fire_store_screen/cloud_fire_store_screen.dart';
import 'package:flutter/material.dart';

import '../../widgets/fire_base_option_btn.dart';
import '../real_time_db_screen/real_time_db_screen.dart';

class MainViewBody extends StatelessWidget {
  const MainViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FireBaseOptionButton(
            title: "Firebase Cloud Firestore",
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => const CloudFireStoreScreen(),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          FireBaseOptionButton(
            title: "Authentication",
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => const AuthScreen(),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          FireBaseOptionButton(
            title: "Realtime Database",
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => const RealTimeDatabaseScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
