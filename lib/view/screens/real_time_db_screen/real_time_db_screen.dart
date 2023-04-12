import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_tutorial/view/screens/real_time_db_screen/create_screen.dart';
import 'package:firebase_tutorial/view/screens/real_time_db_screen/update_screen.dart';
import 'package:flutter/material.dart';

class RealTimeDatabaseScreen extends StatelessWidget {
  const RealTimeDatabaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('contacts');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Contacts',
        ),
      ),

      // Listen on any changes on the FirebaseDatabase Reference
      body: FirebaseAnimatedList(
        query: dbRef,
        shrinkWrap: true,
        itemBuilder: (context, singleSnapshot, animation, index) {
          Map contact = singleSnapshot.value as Map;
          debugPrint(contact.toString());
          debugPrint("=======================");
          contact['key'] = singleSnapshot.key;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UpdateScreen(
                    contactKey: contact['key'],
                  ),
                ),
              );
              // print(contact['key']);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: Colors.orange,
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red[900],
                  ),
                  onPressed: () {
                    dbRef.child(contact['key']).remove();
                  },
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    contact['url'],
                  ),
                ),
                title: Text(
                  contact['name'],
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  contact['number'],
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
