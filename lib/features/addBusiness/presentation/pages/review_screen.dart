import 'package:flutter/material.dart';
class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Review Screen"),
      ),
    );
  }
}
