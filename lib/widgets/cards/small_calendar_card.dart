import 'package:flutter/material.dart';
import 'package:wego/utils/constans/prefs_keys.dart';
import 'package:wego/utils/extensions/string_extension.dart';
import '../../utils/internationalization/app_localizations.dart';
import '../shapes/card_shape.dart';

class SmallCalendarCard extends StatelessWidget {
  const SmallCalendarCard({this.imagePath = '',required this.itemsList, required this.openDetails, required this.title, required this.subtitle, required this.value, this.category, required this.heroTag, super.key});
  final String? imagePath;
  final List? itemsList;
  final String? title;
  final String? subtitle;
  final double? value;
  final String? category;
  final VoidCallback openDetails;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    double fontSize = 10.0;
    double smallFontSize = 8.0;
    var bcgColor;
    if(category == workoutCategory){
      bcgColor = Color(0xFFF1BCD5);
    }else if(category == mealCategory){
      bcgColor = Color(0xFFEDF0A5);
    }else if(category == drinkCategory){
      bcgColor = Color(0xFFA0DCF1);
    }else if(category == supplementCategory){
      bcgColor = Color(0xFF85DA96);
    }else {
      bcgColor = Theme.of(context).colorScheme.surface;
    }
    return GestureDetector(
      onTap: openDetails,
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
                    color: bcgColor,

                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                          child: SizedBox(height: 50,)
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 16,
                               height: MediaQuery.of(context).size.height,
                              padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).indicatorColor,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), bottomLeft: Radius.circular(5.0),
                                ),
                              ), child: RotatedBox(
                                quarterTurns: -1,
                                child: Text(title!,textAlign:TextAlign.center, overflow: TextOverflow.ellipsis,maxLines: 1, style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: fontSize, ),)),),
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

                                      // Text(subtitle!,overflow: TextOverflow.ellipsis,maxLines: 1, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: smallFontSize),),
                                    ),
                                    Expanded(
                                        child:
                                        ListView.builder(
                                          itemCount: 4,
                                          padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 3.0),
                                          itemBuilder: (context, index){
                                            int number = index + 1;
                                            return
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    maxLines:1,
                                                    text: TextSpan(
                                                        text: '${number}. ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineMedium!
                                                            .copyWith(fontSize: smallFontSize),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: 'bench press '.capitalizeFirstLetter(),
                                                          ),
                                                          TextSpan(
                                                            text: ' 4 sets'.capitalizeFirstLetter(),
                                                            // style: Theme.of(context)
                                                            //     .textTheme
                                                            //     .headlineMedium!
                                                            //     .copyWith(fontSize: fontSize),
                                                          )
                                                        ]),
                                                  ),
                                                  //Icon(Icons.sports_gymnastics),
                                                  // Text('${number}) bench press 8x10'.capitalizeFirstLetter(), style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                                                ],
                                              );
                                          },
                                        )
                                        // ListView(
                                        //   padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 3.0),
                                        //   children: [
                                        //     Text('bench press 8x10', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: smallFontSize),),
                                        //     Text('bench press 8x10', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: smallFontSize),),
                                        //     Text('bench press 8x10', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: smallFontSize),),
                                        //     Text('bench press 8x10', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: smallFontSize),),
                                        //
                                        //   ],
                                        // )
                                    ),
                                  ],
                                )

                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
