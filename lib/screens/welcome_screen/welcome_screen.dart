
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:wego/widgets/cards/fit_card.dart';
import 'package:wego/widgets/headers/date_header.dart';
import 'package:flutter/material.dart';

import '../../providers/logic_provider/logic_provider.dart';
import '../../providers/welcome_provider/welcome_provider.dart';
import '../../widgets/cards/welcome_card.dart';
import '../../widgets/carousel/indicators.dart';
import '../../widgets/headers/widget_header.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {


  @override
  Widget build(BuildContext context) {
    double fontSize = 12.0;
    return  Consumer2<LogicProvider,WelcomeProvider>(
      builder: (context, logic, welcomeProvider, child){
        return
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateHeader(),
              Expanded(
                child: CarouselSlider.builder(
                  itemCount: welcomeProvider.userDataCalendarListCounter,
                  carouselController: welcomeProvider.carouselController,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                    var data = welcomeProvider.userDataCalendar[itemIndex];
                    return WelcomeCard(
                              title: data.title,
                              value: data.progressValue,
                              imagePath: data.imagePath,
                            );
                  },
                  options: CarouselOptions(
                      height: MediaQuery.of(context).size.height,
                      aspectRatio: 2/6,
                      viewportFraction: 0.65,
                      initialPage: welcomeProvider.currentPage,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: false,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, fun){
                       welcomeProvider.onCarouselChange(index);
                      }
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.arrow_left),
                      onPressed: welcomeProvider.goToPrevious
                  ),
                  SliderIndicators(
                    items: welcomeProvider.userDataCalendar,
                    itemCount: welcomeProvider.userDataCalendarListCounter,
                    mapIndicators: (i, url) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                        child: Icon(
                          Icons.circle,
                          size: 6.0,
                          color: welcomeProvider.currentPage == i
                              ? Theme.of(context).indicatorColor
                              : Theme.of(context).unselectedWidgetColor,
                        ),
                      );
                    },
                  ),
                  IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.arrow_right),
                      onPressed: welcomeProvider.goToNext
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetHeader(
                    title: "FitNumbers",
                    fontSize: 18,
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: fontSize),
                  ),
                  Divider(indent: fontSize, endIndent: fontSize,),
                  //todo add categories to sort list items
                  Container(
                    margin: EdgeInsets.all(8.0),

                    height: MediaQuery.of(context).size.height / 6,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: logic.numbersListCounter,
                        itemBuilder: (context,index){
                      final listData = logic.mainNumbersList[index];
                      return FitCardSmall(data: listData);
                          // AspectRatio(
                          //   aspectRatio: 1,
                          //   child: Card(
                          //     margin: EdgeInsets.all(5.0),
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Text('${listData.shortTitle}:', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                          //           RichText(text: TextSpan(
                          //               text: '${listData.value!.toStringAsFixed(2)} ',
                          //               style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: listData.infoColor, fontSize: fontSize),
                          //               children: <TextSpan>[
                          //                 TextSpan(
                          //                   text: listData.unit,
                          //                   style: Theme.of(context).textTheme.headlineMedium!.copyWith( fontSize: fontSize),
                          //                 )
                          //               ]
                          //           )),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // );
                    }),
                  ),
                ],
              )


            ],
          );
      },
    );


  }
}
