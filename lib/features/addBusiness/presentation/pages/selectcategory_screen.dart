import 'package:flutter/material.dart';

class SelectcategoryScreen extends StatefulWidget {
  const SelectcategoryScreen({super.key});

  @override
  State<SelectcategoryScreen> createState() => _SelectcategoryScreenState();
}

class _SelectcategoryScreenState extends State<SelectcategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Select Catrgory"),
      ),
    );
  }
}
