import 'package:firebase_tutorial/controller/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Auth"),
      ),
      body: Consumer<AuthProvider>(
        builder: (context , provider , _) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (v)=>provider.email = v,
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    obscureText: true,
                    onChanged: (val)=>provider.password = val,
                    decoration: const InputDecoration(labelText: "Password"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.all(16),
                    onPressed: ()=> provider.register(context),
                    color: Colors.deepOrange,
                    child: const Text("Register",style: TextStyle(fontSize: 25),),
                  ),
                  const SizedBox(height: 10,),
                  MaterialButton(
                    padding: const EdgeInsets.all(16),
                    onPressed: ()=> provider.login(context),
                    color: Colors.deepOrange,
                    child: const Text("Sign In",style: TextStyle(fontSize: 25),),
                  ),
                  const SizedBox(height: 10,),

                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
