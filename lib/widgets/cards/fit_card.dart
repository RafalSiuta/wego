import 'package:flutter/material.dart';

import '../../model/calculation_model/calculation_model.dart';

class FitCardSmall extends StatelessWidget {
  const FitCardSmall({ required this.data, super.key});

  final CalculationModel data;

  @override
  Widget build(BuildContext context) {
    double fontSize = 12.0;
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        margin: EdgeInsets.all(5.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${data.shortTitle}:', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
              RichText(text: TextSpan(
                  text: '${data.value!.toStringAsFixed(2)} ',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: data.infoColor, fontSize: fontSize),
                  children: <TextSpan>[
                    TextSpan(
                      text: data.unit,
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith( fontSize: fontSize),
                    )
                  ]
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class FitCardLarge extends StatelessWidget {
  const FitCardLarge({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

