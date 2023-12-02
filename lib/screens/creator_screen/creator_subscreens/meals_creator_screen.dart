import 'package:flutter/material.dart';

class MealsCreatorScreen extends StatefulWidget {
  const MealsCreatorScreen({super.key});

  @override
  State<MealsCreatorScreen> createState() => _MealsCreatorScreenState();
}

class _MealsCreatorScreenState extends State<MealsCreatorScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Meals creator"),);
  }
}
