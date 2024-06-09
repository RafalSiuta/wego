import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wego/providers/logic_provider/logic_provider.dart';
import 'package:wego/utils/extensions/string_extension.dart';
import 'package:wego/widgets/responsive/column_row_builder.dart';
import 'package:provider/provider.dart';
import '../../../model/calculation_model/calculation_model.dart';
import '../../../model/color/color_switch.dart';
import '../../../model/menu/nav_model.dart';
import '../../../utils/dimensions/size_info.dart';
import '../../../utils/extensions/wego_sys_icons.dart';
import '../../../utils/internationalization/app_localizations.dart';
import '../../../widgets/buttons/menu_button.dart';
import '../../../widgets/chart/chart_card.dart';
import '../../../widgets/headers/date_header.dart';
import '../../../widgets/headers/sliver_date_header.dart';
import '../../../widgets/headers/sliver_header.dart';
import '../../../widgets/headers/sliver_image_header.dart';
import '../../../widgets/headers/sliver_subtitle.dart';
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
    NavModel(title: "save_to_chart", icon: SysIcons.save_chart),
    NavModel(title: "add_favorite", icon: Icons.favorite_border),
    NavModel(title: "page_close", icon: SysIcons.close),
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

    double imgSize = 120;

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
                        SliverToBoxAdapter(
                          child: SizedBox(height: 50,),
                        ),
                        // SliverPersistentHeader(
                        //   pinned: false,
                        //
                        //   delegate: SliverDateHeader(isIconVisible: false),),
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
                              padding: EdgeInsets.only(left: edgePadding, right: edgePadding,),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                // borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),

                              ),
                              child: Text(AppLocalizations.of(context)!.translate(widget.data!.description!),
                                maxLines: 50,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(height: 1.8, fontSize: descriptionFontSize),),
                            ),
                          ]),),
                        //FORMULA SECTION
                        SliverPersistentHeader(
                            pinned: true,
                            delegate: SliverSubtitle(
                              title: 'formula_title_question',
                              subtitle: 'counting_formula',
                              minHeight: 70,
                              isImageLeft: true,
                              maxHeight: imgSize ,
                              imagePath: 'images/nerd_boy.png'
                            )
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate(
                              [

                            Container(
                              margin: EdgeInsets.symmetric(horizontal: edgePadding/2, ),
                              padding: EdgeInsets.symmetric(horizontal: edgePadding, vertical: edgePadding/2 ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width:MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(horizontal: edgePadding, vertical: edgePadding/2 ),
                                    decoration: BoxDecoration(
                                      color: cardBcgColor.bcgColor,
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        maxLines: 4,
                                        text: TextSpan(
                                            text:widget.data!.formulaFemale! == "" ? "" :'${AppLocalizations.of(context)!.translate('male').capitalizeFirstLetter()}:\n',
                                            style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: descriptionFontSize,height: 1.5),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: '\n${widget.data!.formulaMale!}\n',
                                              )
                                            ]
                                        )),
                                  ),
                                  Visibility(
                                    visible: widget.data!.formulaFemale! == "" ? false : true,
                                    child: Container(
                                      width:MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.symmetric(vertical: edgePadding, ),
                                      padding: EdgeInsets.symmetric(horizontal: edgePadding, vertical: edgePadding/2 ),
                                      decoration: BoxDecoration(
                                        color: cardBcgColor.bcgColor,
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                      ),
                                      child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          maxLines: 4,
                                          text: TextSpan(
                                              text: '${AppLocalizations.of(context)!.translate('female'
                                              ).capitalizeFirstLetter()}:\n',
                                              style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: descriptionFontSize,height: 1.5),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '\n${widget.data!.formulaFemale!}\n',
                                                )
                                              ]
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: edgePadding ),
                                    child: Text(AppLocalizations.of(context)!.translate(widget.data!.longDescription!),
                                        maxLines: 100,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(height: 1.8, fontSize: descriptionFontSize),),
                                  ),

                                ],
                              ),
                            ),

                            // Container(
                            //   margin: EdgeInsets.symmetric(horizontal: edgePadding/2, ),
                            //   padding: EdgeInsets.symmetric(horizontal: edgePadding,),
                            //   decoration: BoxDecoration(
                            //     color: Theme.of(context).colorScheme.background,
                            //     // borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                            //
                            //   ),
                            //   child: Text(AppLocalizations.of(context)!.translate(widget.data!.longDescription!),
                            //     maxLines: 100,
                            //     overflow: TextOverflow.ellipsis,
                            //     style: Theme.of(context).textTheme.headlineMedium!.copyWith(height: 1.8, fontSize: descriptionFontSize),),
                            // ),
                          ]),),
                        //CHART SECTION
                        SliverPersistentHeader(
                            pinned: true,
                            delegate: SliverSubtitle(
                                title: '',
                                subtitle: 'chart_data',
                                minHeight: 70,
                               // isImageLeft: true,
                                maxHeight: imgSize - 30,
                                imagePath: 'images/chart.png'
                            )
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate(
                              [

                                Container(
                                  margin: EdgeInsets.symmetric(horizontal:edgePadding/2),
                                  padding: EdgeInsets.only(top: 30, bottom: 5.0),
                                  decoration: BoxDecoration(
                                    //borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                    color: Theme.of(context).colorScheme.background,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height/3.5,

                                  child: ChartCard(
                                    category: widget.data!.category,
                                    chartData: widget.data!.chartList!,
                                  ),
                                ),

                                // Container(
                                //   margin: EdgeInsets.symmetric(horizontal: edgePadding/2, ),
                                //   padding: EdgeInsets.symmetric(horizontal: edgePadding,),
                                //   decoration: BoxDecoration(
                                //     color: Theme.of(context).colorScheme.background,
                                //     // borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                //
                                //   ),
                                //   child: Text(AppLocalizations.of(context)!.translate(widget.data!.longDescription!),
                                //     maxLines: 100,
                                //     overflow: TextOverflow.ellipsis,
                                //     style: Theme.of(context).textTheme.headlineMedium!.copyWith(height: 1.8, fontSize: descriptionFontSize),),
                                // ),
                              ]),),
                        //WARNING USAGE SECTION
                        SliverPersistentHeader(
                            pinned: true,
                            delegate: SliverSubtitle(
                                title: '',
                                subtitle: 'remember_warning',
                                minHeight: 70,
                                isImageLeft: true,
                                maxHeight: imgSize ,
                                imagePath: 'images/lawyer_girl.png'
                            )
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate(
                              [

                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: edgePadding/2, ),
                                  padding: EdgeInsets.symmetric(horizontal: edgePadding, vertical: edgePadding/2 ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.background,
                                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: edgePadding ),
                                        child: Text(AppLocalizations.of(context)!.translate('usage_warning_description'),
                                          maxLines: 100,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(height: 1.8, fontSize: descriptionFontSize),),
                                      ),

                                    ],
                                  ),
                                ),

                              ]),),

                        const SliverToBoxAdapter(
                            child:SizedBox(height: 90,)
                        ),

                      ],
                    ),
                  ),
                  //menu nav
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
                                   // print("value from model:${widget.data!.title} is: ${widget.data!.isFavorite}");
                                  }else if(index == 2){
                                    Navigator.pop(context);
                                  }
                                });

                              },
                              isChecked: index == 1 ? widget.data!.isFavorite! : false,
                              icon: widget.data!.isFavorite! && index == 1 ? Icons.favorite :  menuItem.icon ,
                              title: menuItem.title,
                              fontSize: 8.0,
                             // spaceMargin: 12,

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
