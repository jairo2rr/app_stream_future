import 'package:flutter/material.dart';

Widget contactItem(String name) {
  return Row(children: [
    Text(name),
    const SizedBox(width: 8.0),
    const Text("Offline", style: TextStyle(color: Colors.grey),)
  ]);
}
