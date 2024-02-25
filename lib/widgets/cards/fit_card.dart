import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/calculation_model/calculation_model.dart';
import '../../model/color/color_switch.dart';
import '../../utils/internationalization/app_localizations.dart';
import '../shapes/card_small_pattern.dart';

class FitCardSmall extends StatelessWidget {
  const FitCardSmall({ required this.data, required this.heroTag, super.key});

  final CalculationModel data;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    double fontSize = 10.0;
    var cardBcgColor  = ColorSwitch(category: data.category);
    cardBcgColor.getColor(context);
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5.0),

        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          child: Stack(
            alignment: Alignment.topCenter,
           children: [
             Container(
               //margin:EdgeInsets.only(top: 15),
               constraints: BoxConstraints.expand(),
               decoration: BoxDecoration(
                 color: cardBcgColor.bcgColor,
                 borderRadius: BorderRadius.all(Radius.circular(15.0))
               ),
             ),
             Transform.translate(
               offset: Offset(32, -15),
               child: CustomPaint(
                 size: Size(100, 100 ),
                 painter: CardSmallPattern(color: cardBcgColor.patternColor),

               ),
             ),
             Column(
               children: [
                 Expanded(
                     flex: 2,
                     child: SizedBox(height: 2,)),
                 Expanded(
                   flex: 3,
                   child: Container(
                     constraints: BoxConstraints.expand(),
                     decoration: BoxDecoration(
                         color: Theme.of(context).colorScheme.background,
                         borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0),bottomLeft: Radius.circular(15.0),bottomRight: Radius.circular(15.0))
                     ),
                     child: Padding(
                       padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                       child: SingleChildScrollView(
                        // scrollDirection: Ax,
                         reverse: true,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.end,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             // Text('${data.shortTitle}:',overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                             RichText(
                                 overflow: TextOverflow.ellipsis,
                                 textAlign: TextAlign.center,
                                 maxLines: 2,
                                 text: TextSpan(
                                     text: '${data.shortTitle}\n',
                                     style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: fontSize,),
                                     children: <TextSpan>[
                                       TextSpan(
                                         text: AppLocalizations.of(context)!.translate(data.title!),
                                         style: Theme.of(context).textTheme.headlineMedium!.copyWith( fontSize: fontSize),
                                       )
                                     ]
                                 )),
                             RichText(
                                 overflow: TextOverflow.ellipsis,
                                 textAlign: TextAlign.center,
                                 maxLines: 1,
                                 text: TextSpan(
                                 text: '${data.value!.toStringAsFixed(2)} ',
                                 style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: data.infoColor, fontSize: fontSize),
                                 children: <TextSpan>[
                                   TextSpan(
                                     text: AppLocalizations.of(context)!.translate(data.unit!),
                                     style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: data.infoColor, fontSize: fontSize),
                                   )
                                 ]
                             )),
                             Align(
                               alignment: Alignment.bottomRight,
                               child: Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 5.0),
                                 child: Icon(
                                   Icons.info_outline,
                                   size: fontSize + 2,
                                   color: Theme.of(context).unselectedWidgetColor,
                                 ),
                               ),
                             )

                           ],
                         ),
                       ),
                     ),
                   ),
                 ),
               ],
             ),
             Column(
               children: [
                 Expanded(
                   flex: 5,
                   child: Padding(
                     padding: const EdgeInsets.only(top: 3,right: 7),
                     child: Hero(
                       tag: heroTag ?? '',
                       child: Image(
                       alignment: Alignment.topRight,
                       width: MediaQuery.of(context).size.width,
                       fit: BoxFit.contain,
                       image: AssetImage(data.imagePath!)),
                     ),
                   ),),
                 Expanded(
                   flex: 4,
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
  const FitCardLarge({required this.data,required this.openDetailPage, required this.heroTag, super.key});
  final CalculationModel data;
  final VoidCallback openDetailPage;
  final String? heroTag;
  @override
  Widget build(BuildContext context) {
    double fontSize = 12.0;
    var cardBcgColor  = ColorSwitch(category: data.category);
    cardBcgColor.getColor(context);
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
                    color: cardBcgColor.bcgColor,
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
              ),
              Transform.translate(
                offset: Offset(32, -25),
                child: CustomPaint(
                  size: Size(150, 150 ),
                  painter: CardSmallPattern(color: cardBcgColor.patternColor),

                ),
              ),
              Column(
                children: [
                  Expanded(
                    flex: 1,
                      child: SizedBox(height: 2,)),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(.0),
                      child:
                      Column(
                        children: [
                          Expanded(
                              flex: 2,
                              child: SizedBox(height: 2,)),
                          Expanded(
                            flex: 3,
                            child: Container(
                              constraints: BoxConstraints.expand(),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.background,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0),bottomLeft: Radius.circular(15.0),bottomRight: Radius.circular(15.0))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0,right: 8.0, left: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Text('${data.shortTitle}:',overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                                    RichText(
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        text: TextSpan(
                                            text: '${data.shortTitle}\n',

                                            style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: fontSize,),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: AppLocalizations.of(context)!.translate(data.title!),
                                                style: Theme.of(context).textTheme.headlineMedium!.copyWith( fontSize: fontSize),
                                              )
                                            ]
                                        )),
                                    RichText(
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        text: TextSpan(
                                            text: '${data.value!.toStringAsFixed(2)} ',
                                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: data.infoColor, fontSize: fontSize),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: AppLocalizations.of(context)!.translate(data.unit!),
                                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: data.infoColor, fontSize: fontSize),
                                              )
                                            ]
                                        )),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                                        child: Icon(
                                            Icons.info_outline,
                                            color: Theme.of(context).unselectedWidgetColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                    child: Hero(
                      tag: heroTag ?? '',
                      child: Image(
                          alignment: Alignment.topRight,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.contain,
                          image: AssetImage(data.imagePath!)),
                    ),
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

