import 'package:flutter/material.dart';
import 'package:list_displayer/list_displayer.dart';

void main() {
  runApp(const MainDisplayer());
}

class MainDisplayer extends StatelessWidget {
  const MainDisplayer({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListDisplayer(),
    );
  }
}
