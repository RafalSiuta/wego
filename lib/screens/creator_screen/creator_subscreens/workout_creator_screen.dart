import 'package:flutter/material.dart';

import '../../../widgets/shapes/card_large_pattern.dart';
import '../../../widgets/shapes/card_small_pattern.dart';

class WorkoutCreatorScreen extends StatelessWidget {
  const WorkoutCreatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[

        const Center(

        child: Text("Workout creator"),),

      ]
    );
  }
}
