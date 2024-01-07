import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';

class EmptyListDisplay extends StatelessWidget {
  const EmptyListDisplay({this.title, super.key});

  final String? title;

  @override
  Widget build(BuildContext context) {
    var headerSubtitleSize  =15.0;
    return Center(
      child: PlayAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.5, end: 1.0),
        duration: const Duration(milliseconds: 300),
        delay: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: Text(
              title!,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: headerSubtitleSize, letterSpacing: 1),
            ),
          );
        },
      ),
    );
  }
}
