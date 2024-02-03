import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


class ListSeparated extends StatelessWidget {
  const ListSeparated({
    required this.itemBuilder,
    required this.itemCount,
    required this.separatorBuilder,
    this.separator,
    this.padding = EdgeInsets.zero,
    this.scrollDirection = Axis.vertical,
    super.key});

  final Widget? separator;
  final IndexedWidgetBuilder? itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final int? itemCount;
  final EdgeInsets? padding;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        thickness: 1.0,
        child: AnimationLimiter(
          child: ListView.separated(
            scrollDirection: scrollDirection,
            padding: padding!,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            shrinkWrap: true,
            itemCount: itemCount!,
            itemBuilder: (context,index) => AnimationConfiguration.staggeredList(
              position: index,
              delay: Duration(milliseconds: 100 + (index * 10)),
              duration: const Duration(milliseconds: 300),
              child: ScaleAnimation(
                  scale: 0.8,
                  child: itemBuilder!(context, index)),
            ),
            separatorBuilder: (context,index) => separatorBuilder!(context,index),

          ),
        ),
      ),
    );
  }
}


class ListBuilder extends StatelessWidget {
  const ListBuilder({
    required this.itemBuilder,
  required this.itemCount,
  this.padding = EdgeInsets.zero,
  this.scrollDirection = Axis.vertical,
  super.key});

final IndexedWidgetBuilder? itemBuilder;
final int? itemCount;
final EdgeInsets? padding;
final Axis scrollDirection;

@override
Widget build(BuildContext context) {
  return AnimationLimiter(
    child: ListView.builder(
      scrollDirection: scrollDirection,
      padding: padding!,
      physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics()),
      shrinkWrap: true,
      itemCount: itemCount!,
      itemBuilder: (context,index) => AnimationConfiguration.staggeredList(
        position: index,
        delay: Duration(milliseconds: 100 + (index * 10)),
        duration: const Duration(milliseconds: 300),
        child: ScaleAnimation(
            scale: 0.8,
            child: itemBuilder!(context, index)),
      ),

    ),
  );
}}





