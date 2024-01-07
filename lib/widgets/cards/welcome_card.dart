import 'package:flutter/material.dart';

import '../shapes/card_shape.dart';


class WelcomeCard extends StatelessWidget {
  const WelcomeCard({this.imagePath = '', required this.title, required this.value, super.key});
  final String? imagePath;
  final String? title;
  final double? value;

  @override
  Widget build(BuildContext context) {
    double fontSize = 12.0;
    return Stack(
        children: [
          //shape card
          Container(
            margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 20),
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0), bottomLeft:Radius.circular(15.0) ),
    // ),
            child: ClipPath(
              clipper: CardShape(),
              child: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // stops: [0.5,1],
                  colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.onSurface
                  ])),
                ),
              ),
            ),
          //white container card
          Column(
            children: [
              Expanded(
                  flex: 5,
                  child: SizedBox(height: 20,)),
              Expanded(
                  flex: 4,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    padding: EdgeInsets.all(8.0),
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0), bottomLeft:Radius.circular(15.0) )
                    ),
                  ),)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Image(
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.contain,
                      image: AssetImage(imagePath!)),
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
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  constraints: BoxConstraints.expand(),
                  // decoration: BoxDecoration(
                  //  // color: Theme.of(context).colorScheme.background,
                  //   borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))
                  // ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(title!, style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                            IconButton(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.centerRight,
                                onPressed: (){},
                                icon: Icon(
                                    Icons.info
                                ))
                          ]),
                      Expanded(
                          child: ListView(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.sports_gymnastics),
                                Text('bench press 8x10', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.sports_gymnastics),
                                Text('bench press 8x10', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.sports_gymnastics),
                                Text('bench press 8x10', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.sports_gymnastics),
                                Text('bench press 8x10', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                              ],
                            ),
                          ],
                      )),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Progress', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                              Text('${value!*100}%', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: LinearProgressIndicator(
                              value: value,
                              semanticsLabel: 'Progrss',
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),


        ]
    );
  }
}
