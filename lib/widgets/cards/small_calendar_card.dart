import 'package:flutter/material.dart';
import 'package:wego/utils/constans/prefs_keys.dart';
import 'package:wego/utils/extensions/string_extension.dart';
import '../../model/color/color_switch.dart';
import '../../model/user_calendar_model/calendar_items_model.dart';
import '../../utils/internationalization/app_localizations.dart';
import '../shapes/card_large_pattern.dart';
import '../shapes/card_shape.dart';

class SmallCalendarCard extends StatelessWidget {
  const SmallCalendarCard({this.imagePath = '',required this.itemsList, required this.onTap, required this.title, required this.subtitle, required this.value, this.category, required this.heroTag, super.key});
  final String? imagePath;
  final List<CalendarItemsModel>? itemsList;
  final String? title;
  final String? subtitle;
  final double? value;
  final String? category;
  final VoidCallback? onTap;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    //double fontSize = 10.0;
    double smallFontSize = 8.0;
    double rightPadding = 5.0;
    var cardBcgColor  = ColorSwitch(category: category);
    cardBcgColor.getColor(context);
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 4.5/6,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [

            Container(
              margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10),
              child: ClipPath(
                clipper: CardShape(),
                child: Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    color: cardBcgColor.bcgColor,
                  ),
                  child: CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height ),
                    painter: CardLargePattern(color: cardBcgColor.patternColor),//CardSmallPattern

                  ),

                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                    flex: 3,
                    child: SizedBox(height: 50,)
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                   // constraints: BoxConstraints.expand(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 16,
                          height: MediaQuery.of(context).size.height,
                          padding: EdgeInsets.only(top: 3.0, bottom: 3.0,left: 2.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).indicatorColor,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), bottomLeft: Radius.circular(5.0),
                            ),
                          ), child: RotatedBox(
                            quarterTurns: -1,
                            child: Text(title!,textAlign:TextAlign.center, overflow: TextOverflow.ellipsis,maxLines: 1, style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: smallFontSize, ),)),),
                        Expanded(
                          child: Container(
                              constraints: BoxConstraints.expand(),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(5.0), bottomRight: Radius.circular(0.0),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:2.0, left: 5.0, right: 5.0),
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: TextSpan(
                                          text: '${itemsList!.length } ',
                                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: smallFontSize),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: "${AppLocalizations.of(context)!.translate(subtitle!).capitalizeFirstLetter()} :",
                                            )
                                          ]),
                                    ),
                                  ),
                                  Expanded(
                                      child:
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: itemsList!.length,
                                        itemBuilder: (context, index){
                                          int number = index + 1;
                                          var data = itemsList![index];
                                          return
                                            Padding(
                                              padding: const EdgeInsets.only(top: 2.0, bottom: 2.0,left: 5.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex:3,
                                                    child: RichText(
                                                      maxLines:1,
                                                      overflow: TextOverflow.ellipsis,
                                                      text: TextSpan(
                                                          text: '${number}. ',
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headlineLarge!
                                                              .copyWith(fontSize: smallFontSize),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: '${data.name} '.capitalizeFirstLetter(),
                                                             ),
                                                          ]),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                      flex: 1,
                                                      child: SizedBox(width: 2.0,)),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 5.0),
                                                    child: Icon( data.isDone! ? Icons.check_box : Icons.check_box_outline_blank, size: smallFontSize,
                                                      color: data.isDone! ? Theme.of(context).indicatorColor : Theme.of(context).unselectedWidgetColor,),
                                                  )
                                                ],
                                              ),
                                            );
                                        },
                                      )
                                  ),
                                  SizedBox(height: 7.0,)
                                ],
                              )

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //image
            Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Hero(
                      tag: heroTag ?? '',
                      child: Image(
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.contain,
                          image: AssetImage(imagePath!)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(height: 10,)
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
