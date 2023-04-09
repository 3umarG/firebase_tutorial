import 'package:flutter/material.dart';

class FireBaseOptionButton extends StatelessWidget {
  const FireBaseOptionButton({Key? key, required this.title, required this.onPressed}) : super(key: key);

  final String title;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
      padding: const EdgeInsets.all(16),
      onPressed: onPressed,
      color: Colors.orange,
      child: Text(title,style: const TextStyle(fontSize: 25 , color: Colors.black87),),
    );
  }
}
