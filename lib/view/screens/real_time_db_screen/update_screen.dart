import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_tutorial/view/screens/real_time_db_screen/real_time_db_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key, required this.contactKey}) : super(key: key);

  final String contactKey;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController contactName = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  String? url;
  String? url1;

  File? file;
  ImagePicker image = ImagePicker();
  DatabaseReference? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('contacts');
    contactData();
  }

  void contactData() async {
    DataSnapshot snapshot = await dbRef!.child(widget.contactKey).get();

    Map contactInfo = snapshot.value as Map;

    setState(() {
      contactName.text = contactInfo['name'];
      contactNumber.text = contactInfo['number'];
      url = contactInfo['url'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Record'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: url == null
                    ? MaterialButton(
                        height: 100,
                        child: Image.file(
                          file!,
                          fit: BoxFit.fill,
                        ),
                        onPressed: () {
                          getImage();
                        },
                      )
                    : MaterialButton(
                        height: 100,
                        child: CircleAvatar(
                          maxRadius: 100,
                          backgroundImage: NetworkImage(
                            url!,
                          ),
                        ),
                        onPressed: () {
                          getImage();
                        },
                      ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: contactName,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Name',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: contactNumber,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Number',
              ),
              maxLength: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 40,
              onPressed: () {
                // getImage();

                if (file != null) {
                  uploadFile();
                } else {
                  directUpdate();
                }
              },
              color: Colors.orange,
              child: const Text(
                "Update",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      url = null;
      file = File(img!.path);
    });

    // print(file);
  }

  uploadFile() async {
    try {
      var imageFile = FirebaseStorage.instance
          .ref()
          .child("contact_photo")
          .child("/${contactName.text}.jpg");

      UploadTask task = imageFile.putFile(file!);

      TaskSnapshot snapshot = await task;

      url1 = await snapshot.ref.getDownloadURL();

      setState(() {
        url1 = url1;
      });
      if (url1 != null) {
        Map<String, String> Contact = {
          'name': contactName.text,
          'number': contactNumber.text,
          'url': url1!,
        };

        dbRef!.child(widget.contactKey).update(Contact).whenComplete(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const RealTimeDatabaseScreen(),
            ),
          );
        });
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  directUpdate() {
    if (url != null) {
      Map<String, String> Contact = {
        'name': contactName.text,
        'number': contactNumber.text,
        'url': url!,
      };

      dbRef!.child(widget.contactKey).update(Contact).whenComplete(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const RealTimeDatabaseScreen(),
          ),
        );
      });
    }
  }
}
