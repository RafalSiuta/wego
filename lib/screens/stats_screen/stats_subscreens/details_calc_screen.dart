import 'package:flutter/material.dart';

import '../../../model/calculation_model/calculation_model.dart';

class DetailCalcScreen extends StatelessWidget {
  const DetailCalcScreen({required this.data,required this.heroTag, super.key});
  final CalculationModel? data;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    double fontSize = 12.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
                width: MediaQuery.of(context).size.width - 24,
                fit: BoxFit.contain,
                image: AssetImage(data!.imagePath!)),
        Text('${data!.title}:', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
        RichText(text: TextSpan(
        text: '${data!.value!.toStringAsFixed(2)} ',
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: data!.infoColor, fontSize: fontSize),
        children: <TextSpan>[
        TextSpan(
        text: data!.unit,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith( fontSize: fontSize),
        )
          ],
        ),
      ),
          ])));
  }
}
