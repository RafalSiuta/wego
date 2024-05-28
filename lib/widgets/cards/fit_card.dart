import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/calculation_model/calculation_model.dart';
import '../../model/color/color_switch.dart';
import '../../utils/dimensions/size_info.dart';
import '../../utils/internationalization/app_localizations.dart';
import '../shapes/card_small_pattern.dart';

class FitCardMini extends StatelessWidget {
  const FitCardMini({this.iconData,required this.title,required this.category, required this.onTap,required this.value, super.key});
 // final CalculationModel data;
  final IconData? iconData;
  final String? title;
  final String? category;
  final Function(bool)? onTap;
  final bool? value;

  @override
  Widget build(BuildContext context) {
    double fontSize = 10.0;
    double iconSize = SizeInfo.iconSize;
    var cardBcgColor  = ColorSwitch(category: category);
    cardBcgColor.getColor(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        selectedColor: cardBcgColor.bcgColor,
        disabledColor: Theme.of(context).unselectedWidgetColor,
        showCheckmark: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
        elevation: 0,
        avatar: iconData != null ? Icon(iconData,color: Theme.of(context).textTheme.headlineMedium!.color, size: iconSize,)
        : null,
        label: Padding(
          padding: EdgeInsets.only(left: iconData != null ? 5.0 : 0),
          child: Text(
            title!,
            textAlign:  TextAlign.center,
            style: value! ? Theme.of(context).textTheme.headlineMedium!.copyWith( fontSize: fontSize, ):Theme.of(context).textTheme.displaySmall!.copyWith( fontSize: fontSize, ) ,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: Theme.of(context).unselectedWidgetColor),
        ),
        selected: value!,
        onSelected: onTap,
        side: BorderSide(style: value! ? BorderStyle.none : BorderStyle.solid, width: 0.5, color: Theme.of(context).unselectedWidgetColor.withOpacity(0.5)),
      ),
    );
  }
}


class FitCardSmall extends StatelessWidget {
  const FitCardSmall({ required this.data, required this.onTap, required this.heroTag, super.key});

  final CalculationModel data;
  final String? heroTag;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    double fontSize = 10.0;
    double iconSize = SizeInfo.iconSize;
    var cardBcgColor  = ColorSwitch(category: data.category);
    cardBcgColor.getColor(context);
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: onTap,
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
                       child: SizedBox(height: 10,)),
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
                                   text: data.value != null ? '${data.value!.toStringAsFixed(2)} ': "",
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
               Align(
                 alignment: Alignment.topLeft,
                 child: Container(
                   padding: const EdgeInsets.all(8.0),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(iconSize)),
                     color: cardBcgColor.patternColor
                   ),
                   child: Icon(data.symbol, size: iconSize,
                     color: Theme.of(context).colorScheme.secondary,
                   ),
                 ),

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
    double iconSize = SizeInfo.iconSize;
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
                                        maxLines: 1,
                                        text: TextSpan(
                                            text: data.value != null ? '${data.value!.toStringAsFixed(2)} ': "",
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
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: cardBcgColor.patternColor
                  ),
                  child: Icon(data.symbol, size: iconSize,color: Theme.of(context).colorScheme.secondary,),
                ),

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

