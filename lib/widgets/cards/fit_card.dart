import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/calculation_model/calculation_model.dart';

class FitCardSmall extends StatelessWidget {
  const FitCardSmall({ required this.data, super.key});

  final CalculationModel data;

  @override
  Widget build(BuildContext context) {
    double fontSize = 12.0;
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10),

        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          child: Stack(
           children: [
             Container(
               //margin:EdgeInsets.only(top: 15),
               constraints: BoxConstraints.expand(),
               decoration: BoxDecoration(
                 color: Theme.of(context).colorScheme.background,
                 borderRadius: BorderRadius.all(Radius.circular(15.0))
               ),
             ),
             Transform.translate(
               offset: Offset(25, -25),
               child: Align(
                 alignment: Alignment.topRight,
                 child: Container(
                   width: 100,
                   height: 100,
                   decoration: BoxDecoration(
                       color: Theme.of(context).colorScheme.surface,
                       borderRadius: BorderRadius.all(Radius.circular(50.0))
                   ),
                 ),
               ),
             ),
             Column(
               children: [
                 Expanded(
                     flex: 2,
                     child: SizedBox(height: 2,)),
                 Expanded(
                   flex: 3,
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.end,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('${data.shortTitle}:',overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                         RichText(
                              overflow: TextOverflow.ellipsis,
                             text: TextSpan(
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
               ],
             ),
             Column(
               children: [
                 Expanded(
                   flex: 3,
                   child: Image(
                     alignment: Alignment.topRight,
                       width: MediaQuery.of(context).size.width,
                       fit: BoxFit.contain,
                       image: AssetImage(data.imagePath!)),
                 ),
                 Expanded(
                   flex: 2,
                     child: SizedBox(height: 10,)),
               ],
             ),

           ],
          ),
        ),
      ),
    );
  }
}

class FitCardLarge extends StatelessWidget {
  const FitCardLarge({required this.data,required this.openDetailPage, super.key});
  final CalculationModel data;
  final VoidCallback openDetailPage;
  @override
  Widget build(BuildContext context) {
    double fontSize = 12.0;
    return GestureDetector(
      onTap: openDetailPage,
      child: Container(
        margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10),

        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          child: Stack(
            children: [
              Container(
                //margin:EdgeInsets.only(top: 15),
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
              ),
              Transform.translate(
                offset: Offset(25, -25),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.all(Radius.circular(60.0))
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Expanded(
                      child: SizedBox(height: 2,)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${data.title}:', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                          RichText(text: TextSpan(
                              text: '${data.value!.toStringAsFixed(2)} ',
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: data.infoColor, fontSize: fontSize),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${data.unit}',
                                  style: Theme.of(context).textTheme.headlineMedium!.copyWith( fontSize: fontSize),
                                )
                              ]
                          )),
                          Text('${data.description}', style: Theme.of(context).textTheme.headlineMedium!.copyWith( fontSize: fontSize),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Expanded(
                   // flex: 3,
                    child: Image(
                        alignment: Alignment.topRight,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                        image: AssetImage(data.imagePath!)),
                  ),
                  Expanded(
                     // flex: 2,
                      child: SizedBox(height: 10,)),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

