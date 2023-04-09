import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/student_model.dart';

class CloudFireStoreProvider extends ChangeNotifier {
  // Reference to Collection in Cloud
  final CollectionReference _studentCollection =
      FirebaseFirestore.instance.collection("students");

  String _name = "";
  String _email = "";
  String _age = "";

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set age(String value) {
    _age = value;
    notifyListeners();
  }

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  List<Student> _students = [];

  List<Student> get students => _students;

  Future<void> addStudent(BuildContext context) async {
    try {
      await _studentCollection.doc(_name).set({
        "name":_name,
        "email": _email,
        "age": _age,
      });

      const snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text('Student Added Successfully !!'),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        await getAllStudents(context);
      }
    } catch (e) {
      const snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Can\'t Added Student Successfully !!'),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Future<void> updateStudent(BuildContext context) async {
    try {
      await _studentCollection
          .doc(_name)
          .update({"email": _email, "age": _age});

      const snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text('Student Updated Successfully !!'),
      );

      if (context.mounted) {
        var sm = ScaffoldMessenger.of(context);
        sm.showSnackBar(snackBar);
        await getAllStudents(context);
      }
    } catch (e) {
      const snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Can\'t Update Student !!'),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Future<void> deleteByName(BuildContext context) async {
    try {
      // await _studentCollection.add({
      //   "name": _name,
      //   "email": _email,
      //   "age": _age,
      // });

      await _studentCollection.doc(_name).delete();

      const snackBar = SnackBar(
        content: Text('Student Deleted Successfully !!'),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        await getAllStudents(context);
      }
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Can\'t Deleted Student Successfully !!'),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Future<void> getAllStudents(BuildContext context) async {
    try {
      var collectionResult = await _studentCollection.orderBy("name").get();
      collectionResult.docs.forEach((element) {
        debugPrint("==============================");
        debugPrint(element['name'].toString());
        debugPrint(element['email'].toString());
        debugPrint(element['age'].toString());
        debugPrint("==============================");

        _students = List<Student>.from(
          collectionResult.docs.map(
            (e) => Student(
              name: e['name'],
              email: e['email'],
              age: e['age'],
            ),
          ),
        );
      });

      const snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text('Get Student Successfully !!'),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      const snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Can\'t Get Student Successfully !!'),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
