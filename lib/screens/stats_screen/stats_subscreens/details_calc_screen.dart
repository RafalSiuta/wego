import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wego/providers/logic_provider/logic_provider.dart';
import 'package:wego/widgets/responsive/column_row_builder.dart';

import 'package:provider/provider.dart';
import '../../../model/calculation_model/calculation_model.dart';
import '../../../model/color/color_switch.dart';
import '../../../model/menu/nav_model.dart';
import '../../../utils/dimensions/size_info.dart';
import '../../../utils/internationalization/app_localizations.dart';
import '../../../widgets/buttons/menu_button.dart';
import '../../../widgets/headers/date_header.dart';
import '../../../widgets/headers/sliver_date_header.dart';
import '../../../widgets/headers/sliver_header.dart';
import '../../../widgets/headers/sliver_image_header.dart';
import '../../../widgets/shapes/card_small_pattern.dart';

class DetailCalcScreen extends StatefulWidget {
  const DetailCalcScreen({required this.data,required this.heroTag, super.key});
  final CalculationModel? data;
  final String heroTag;


  @override
  State<DetailCalcScreen> createState() => _DetailCalcScreenState();
}

class _DetailCalcScreenState extends State<DetailCalcScreen> {

  int navIndex = 0;

  List<NavModel> _menuItems = [
    NavModel(title: "save_to_chart", icon: Icons.add_chart),
    NavModel(title: "add_favorite", icon: Icons.favorite_border),
    NavModel(title: "page_close", icon: Icons.close),
  ];

  ScrollDirection scrollDirection = ScrollDirection.idle;

  bool isBottomBarVisible = true;

  @override
  Widget build(BuildContext context) {
    var titleFontSize = SizeInfo.headerSubtitleSize;
    var descriptionFontSize = SizeInfo.taskCreatorDescription;
    var edgePadding = SizeInfo.leftEdgePadding;
    var cardBcgColor  = ColorSwitch(category: widget.data!.category);
    cardBcgColor.getColor(context);

    var shapeDecorationSize = MediaQuery.of(context).size.width;
    return
    Consumer<LogicProvider>(builder: (context, logic, child){
      return
      Scaffold(
          backgroundColor: cardBcgColor.bcgColor,
          extendBody: true,
          body: SafeArea(
              child: Stack(
                children: [
                  Transform.translate(
                    offset: Offset(70, -70),
                    child: CustomPaint(
                      size: Size(shapeDecorationSize , shapeDecorationSize ),
                      painter: CardSmallPattern(color: cardBcgColor.patternColor),
                    ),
                  ),
                  NotificationListener<UserScrollNotification>(
                    onNotification: (notification) {
                      // Sprawdź kierunek przewijania
                      setState(() {
                        scrollDirection = notification.direction;
                        isBottomBarVisible = notification.direction != ScrollDirection.reverse;
                      });
                      // Jeśli potrzebujesz podjąć jakieś działanie w zależności od kierunku, możesz to zrobić tutaj
                      if (scrollDirection == ScrollDirection.forward) {
                        print("Przewijanie w dół");
                      } else if (scrollDirection == ScrollDirection.reverse) {
                        print("Przewijanie w górę");
                      } else {
                        print("Brak przewijania");
                      }
                      return true; // Zwróć true, aby wskazać, że powiadomienie zostało obsłużone
                    },
                    child: CustomScrollView(
                      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      slivers: [
                        SliverPersistentHeader(
                          pinned: false,

                          delegate: SliverDateHeader(isIconVisible: false),),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: SliverImageHeader(
                              maxHeight: shapeDecorationSize,
                              data: widget.data!,
                              heroTag: widget.heroTag
                          ),),
                        SliverList(
                          delegate: SliverChildListDelegate([
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: edgePadding/2, ),
                              padding: EdgeInsets.symmetric(horizontal: edgePadding,),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                // borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),

                              ),
                              child: Text(AppLocalizations.of(context)!.translate(widget.data!.description!),
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(height: 1.8, fontSize: descriptionFontSize),),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: edgePadding/2, ),
                              padding: EdgeInsets.symmetric(horizontal: edgePadding,),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                // borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),

                              ),
                              child: Text(AppLocalizations.of(context)!.translate(widget.data!.longDescription!),
                                maxLines: 100,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(height: 1.8, fontSize: descriptionFontSize),),
                            ),
                          ]),),


                        // SliverPersistentHeader(
                        //   pinned: true,
                        //   delegate: LargeSliverHeader(title: "detail_title", isInfoVisible: false, isBcgTransparent: false,margin: EdgeInsets.symmetric(horizontal: edgePadding/2),padding: EdgeInsets.symmetric(horizontal: edgePadding) ),),

                        SliverToBoxAdapter(
                            child:SizedBox(height: 50,)
                        ),

                      ],
                    ),
                  ),
                  Visibility(
                    visible: isBottomBarVisible ,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 50,
                       // width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Theme.of(context).colorScheme.background.withOpacity(isBottomBarVisible ? 1.0 : 0.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 3.0,
                              offset: Offset(0.5, 2.0),
                              color: Theme.of(context).unselectedWidgetColor
                            )
                          ]

                        ),
                        child: RowBuilder(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          itemCount: _menuItems.length,
                          itemBuilder: (context, index){
                            var menuItem = _menuItems[index];
                            return MenuButton(
                              onPress: (){
                                setState(() {
                                  if(index == 1){
                                    logic.addToFavorite(widget.data!);
                                    print("value from model:${widget.data!.title} is: ${widget.data!.isFavorite}");
                                  }else if(index == 2){
                                    Navigator.pop(context);
                                  }
                                });

                              },
                              isChecked: index == 1 ? widget.data!.isFavorite! : false,
                              icon: widget.data!.isFavorite! && index == 1 ? Icons.favorite :  menuItem.icon ,
                              title: menuItem.title,
                              fontSize: 8.0,
                              spaceMargin: 12,

                            );
                          },
                        ),
                      ),
                    ),
                  )

                ],
              )),

      );
    });


  }
}
