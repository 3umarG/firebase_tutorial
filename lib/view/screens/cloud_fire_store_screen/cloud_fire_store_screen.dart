import 'package:firebase_tutorial/controller/cloud_fire_store_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CloudFireStoreScreen extends StatelessWidget {
  const CloudFireStoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cloud Firestore"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Consumer<CloudFireStoreProvider>(
            builder: (context , provider , _) {
              return Column(
                children: [
                  TextFormField(
                    onChanged: (value){
                      provider.name = value;
                    },
                    decoration: const InputDecoration(labelText: "Name"),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    onChanged: (value)=> provider.age = value,
                    decoration: const InputDecoration(labelText: "Age"),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) => provider.email = val,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        color: Colors.amber,
                        onPressed: ()=> provider.addStudent(context),
                        child: const Text("Post"),
                      ),
                      MaterialButton(
                        color: Colors.amber,
                        onPressed: ()=> provider.updateStudent(context),
                        child: const Text("Update"),
                      ),
                      MaterialButton(
                        onPressed: ()=> provider.getAllStudents(context),
                        color: Colors.amber,
                        child: const Text("Get"),
                      ),
                      MaterialButton(
                        onPressed: ()=> provider.deleteByName(context),
                        color: Colors.amber,
                        child: const Text("Delete"),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: provider.students.length,
                      itemBuilder: (context, index) =>  ListTile(
                        title: Text(provider.students[index].name),
                        subtitle: Text(provider.students[index].email),
                        trailing: Text(provider.students[index].age),
                      ),
                    ),
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
