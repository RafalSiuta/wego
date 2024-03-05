import 'package:flutter/material.dart';
import 'package:wego/utils/constans/prefs_keys.dart';
import 'package:wego/utils/extensions/string_extension.dart';
import 'package:wego/widgets/shapes/card_large_pattern.dart';
import '../../model/color/color_switch.dart';
import '../../model/user_calendar_model/calendar_items_model.dart';
import '../../utils/internationalization/app_localizations.dart';
import '../shapes/card_shape.dart';


class WelcomeCard extends StatelessWidget {
  const WelcomeCard({this.imagePath = '',required this.itemsList, required this.onTap, required this.title, required this.subtitle, required this.value, this.category, required this.heroTag, super.key});
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
    double fontSize = 10.0;
    double largeFontSize = 15.0;
    double rightPadding = 5.0;
    var cardBcgColor  = ColorSwitch(category: category);
    cardBcgColor.getColor(context);
    return GestureDetector(
      onTap: onTap,
      child: Stack(
          children: [
            //shape card
            Container(
              margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 20),
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
                    flex: 5,
                    child: SizedBox(height: 20,)),
                //whit rounded text card
                Expanded(
                    flex: 4,
                    child: Stack(
                      children:[

                        Container(
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        padding: EdgeInsets.all(8.0),
                        constraints: BoxConstraints.expand(),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0), bottomLeft:Radius.circular(15.0) )
                        ),
                      ),
                        Container(
                          width: 30,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          //constraints: BoxConstraints.expand(),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Theme.of(context).indicatorColor,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), bottomLeft:Radius.circular(15.0) )
                          ),
                        ),
                      ]
                    ),)
              ],
            ),
            //image column:
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Hero(
                      tag: heroTag ?? "",
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
            Column(
              children: [
                Expanded(
                    child: SizedBox(height: 10,)),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
                    constraints: BoxConstraints.expand(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0, top: 5.0),
                          child: RotatedBox(
                              quarterTurns: -1,
                              child: Text(title!,overflow: TextOverflow.ellipsis,maxLines: 1, style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: largeFontSize),),

                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 18,bottom: 5, right: rightPadding),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        text: TextSpan(
                                            text: '${itemsList!.length } ',
                                            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: fontSize),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: "${AppLocalizations.of(context)!.translate(subtitle!).capitalizeFirstLetter()} :",
                                              )
                                            ]),
                                      ),
                                      // Text(
                                      //  // subtitle!
                                      //   AppLocalizations.of(context)!.translate(subtitle!).capitalizeFirstLetter()
                                      //   ,overflow: TextOverflow.ellipsis,maxLines: 1, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: fontSize),),
                                       Icon(
                                          Icons.info_outline,
                                        color: Theme.of(context).unselectedWidgetColor,
                                      )
                                      // IconButton(
                                      //   padding: EdgeInsets.zero,
                                      //   alignment: Alignment.centerRight,
                                      //     onPressed: onTap,
                                      //     icon: const Icon(
                                      //         Icons.info_outline
                                      //     ))
                                    ]),
                              ),
                              //items list
                              Expanded(
                                  child: ListView.builder(
                                    itemCount: itemsList!.length,
                                    itemBuilder: (context, index){
                                      int number = index + 1;
                                      var data = itemsList![index];
                                      return
                                        Padding(
                                          padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, right: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                maxLines:1,
                                                text: TextSpan(
                                                    text: '${number}. ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineLarge!
                                                        .copyWith(fontSize: fontSize),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: '${data.name} '.capitalizeFirstLetter(),
                                                      ),
                                                      TextSpan(
                                                        text: '${data.qty} '.capitalizeFirstLetter(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineMedium!
                                                            .copyWith(fontSize: fontSize),
                                                      )
                                                    ]),
                                              ),
                                              Expanded(child: SizedBox(width: 2.0,)),
                                              Icon( data.isDone! ? Icons.check_box_outline_blank : Icons.check_box_outline_blank, size: fontSize,),
                                              // Text('${number}) bench press 8x10'.capitalizeFirstLetter(), style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                                            ],
                                          ),
                                        );
                                    },
                              )
                              ),
                              //progrss bar
                              Padding(
                                padding: EdgeInsets.only(right: rightPadding),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(AppLocalizations.of(context)!.translate("progress_bar").capitalizeFirstLetter(), style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                                        Text('${value!*100}%', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                                      child: LinearProgressIndicator(
                                        value: value,
                                        semanticsLabel: 'Progress',
                                        backgroundColor: Theme.of(context).unselectedWidgetColor.withOpacity(0.5),
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          cardBcgColor.bcgColor!
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),


          ]
      ),
    );
  }
}
