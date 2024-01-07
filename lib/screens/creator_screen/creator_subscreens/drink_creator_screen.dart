import 'package:flutter/material.dart';

class DrinksCreatorScreen extends StatefulWidget {
  const DrinksCreatorScreen({super.key});

  @override
  State<DrinksCreatorScreen> createState() => _DrinksCreatorScreenState();
}

class _DrinksCreatorScreenState extends State<DrinksCreatorScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Drinks creator"),);
  }
}