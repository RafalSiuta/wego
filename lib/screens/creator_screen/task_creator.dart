
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wego/model/user_calendar_model/user_calendar_model.dart';
import 'package:wego/utils/extensions/string_extension.dart';
import 'package:wego/utils/constans/prefs_keys.dart';
import '../../model/color/color_switch.dart';
import '../../model/menu/nav_model.dart';
import '../../utils/dimensions/size_info.dart';
import '../../utils/extensions/wego_sys_icons.dart';
import '../../utils/internationalization/app_localizations.dart';
import '../../widgets/buttons/menu_button.dart';
import '../../widgets/headers/sliver_image.dart';
import '../../widgets/headers/sliver_image_header.dart';
import '../../widgets/headers/sliver_container.dart';
import '../../widgets/navigators/side_nav.dart';
import '../../widgets/responsive/column_row_builder.dart';
import '../../widgets/shapes/page_bcg_shape.dart';
import '../../widgets/shapes/page_pattern.dart';

class TaskCreator extends StatefulWidget {
  const TaskCreator({required this.userModel, required this.heroTag, super.key});

  final UserCalendarModel userModel;
  final String heroTag;

  @override
  State<TaskCreator> createState() => _TaskCreatorState();
}

class _TaskCreatorState extends State<TaskCreator> with TickerProviderStateMixin{

  late AnimationController? _menuSlideInController;
  late Animation<Offset> _menuAnimation;
  int selectedIndex = 1;

  String addBtnText = "";
  String tileSubtitle = "";
  String unitName = "";
  String creatorCategory = "";

  double tileElementsResult = 0;

  double? taskPercent;


  List<NavModel> _menuItems = [
    NavModel(
      icon:SysIcons.save,
      title: 'option_save'
    ),
    // NavModel(
    //   icon: FontAwesomeIcons.image,
    // ),
    // NavModel(
    //   icon: FontAwesomeIcons.pen,
    // ),
    NavModel(
      icon: SysIcons.calendar,
      title: 'option_date'
    ),
    NavModel(
      icon: SysIcons.trash,
      title: 'option_trash'
    ),
    NavModel(
      icon: SysIcons.close,
      title: 'page_close'
    ),
  ];

  TextEditingController titleVal = TextEditingController();

  FocusNode titleNode = FocusNode();

  TextEditingController exerciseNameVal = TextEditingController();

  FocusNode exerciseNameNode = FocusNode();

  bool editTextEnable = true;

  void editText() {
    setState(() {
      //print("EDIT WAS PRESSED $editTextEnable");
      editTextEnable = !editTextEnable;
      if (editTextEnable) {
        titleNode.requestFocus();
      } else {
        FocusScope.of(context).unfocus();
      }
    });
  }

  double tileElementSummary(int index){
    double total = 0;
    total = widget.userModel.items![index].itemsValueSummery(creatorCategory);
    // for(var item in widget.userModel.items![index].elems!){
    //
    //   if(widget.userModel.category == workoutCategory){
    //     total += (item.qty! * item.value!);
    //   }else{
    //     total += item.value!;
    //   }
    //
    // }
    return total;
  }

  void categoryCheck(String? category){

    if(category == workoutCategory){
      addBtnText = "default_exercise_name";
      tileSubtitle = "tile_exercise_summary";
      unitName = "unit_kg";
    }else if(category == mealCategory){
      addBtnText = "default_meal_name";
      tileSubtitle = "tile_meal_summary";
      unitName = "unit_kcal";
    }else if(category == drinkCategory){
      addBtnText = "default_drink_name";
      tileSubtitle = "tile_drink_summary";
      unitName = "unit_litter";
    }else if(category == supplementCategory){
      addBtnText = "default_supl_name";
      tileSubtitle = "tile_supl_summary";
      unitName = "unit_mg";

    }else {
      addBtnText = "";
      tileSubtitle = "";
    }
    setState(() {

    });

  }

  ScrollDirection scrollDirection = ScrollDirection.idle;

  bool isBottomBarVisible = true;

  void debugData(){
    print(
      'ID:${widget.userModel.id}\nCAT:${widget.userModel.category}\nIMG${widget.userModel.imagePath}\nTITLE${widget.userModel.title}\nSUBTITLE:${widget.userModel.subtitle}\nITEMS${widget.userModel.items}'
    );


  }


  @override
  void initState() {

    creatorCategory = widget.userModel.category!;


    if(widget.userModel.items != null){
      tileElementsResult = widget.userModel.totalValSummary();
      taskPercent = widget.userModel.percentProgress();
    }else{
      tileElementsResult = 0;
      taskPercent = 0;
    }




    debugData();

    categoryCheck(widget.userModel.category);
    _menuSlideInController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _menuAnimation =
        Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _menuSlideInController!, curve: Curves.ease));
    super.initState();
    Future.delayed(const Duration(milliseconds: 300))
        .then((value) => _menuSlideInController!.forward());

    titleVal.text = widget.userModel.title!;
    exerciseNameVal.text = "";

  }

  bool _customTileExpanded = false;

  @override
  void dispose() {
    _menuSlideInController!.dispose();
    titleNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var topMargin = SizeInfo.topMargin;
    var titleFontSize = SizeInfo.taskCreatorTitle;
    var fontSize = SizeInfo.taskCreatorDescription;
    var helpTextFontSize = SizeInfo.helpTextSize;
    var edgePadding = SizeInfo.leftEdgePadding;
    var raterIconSize = SizeInfo.iconSize;
    var leftPadding = SizeInfo.edgePadding;
    var inputHeight = SizeInfo.searchBarHeight;
    var navIconSize = SizeInfo.leadingAndTrailingIconSize;
    int maxTitleLength = 20;
    int maxDescriptionLength = 4000;

    var cardBcgColor  = ColorSwitch(category: widget.userModel.category);
    cardBcgColor.getColor(context);
    var shapeDecorationSize = MediaQuery.of(context).size.width;
    double imgSize = 120;
    //print("CHECK SCREEN HEIGHT ${MediaQuery.of(context).size.height}");
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: cardBcgColor.bcgColor,
      body: Stack(
        children: [
          //page pattern bcg
          Container(
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height / 1.35,
            decoration: BoxDecoration(
              color: cardBcgColor.bcgColor,
            ),
            child: CustomPaint(
              painter: PagePattern(color: cardBcgColor.patternColor),
            ),
          ),
          SafeArea(
            child:
          NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
          setState(() {
          scrollDirection = notification.direction;
          isBottomBarVisible = notification.direction != ScrollDirection.reverse;
          });
          if (scrollDirection == ScrollDirection.forward) {
          } else if (scrollDirection == ScrollDirection.reverse) {

          } else {
          }
          return true;
          },
          child: CustomScrollView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              shrinkWrap: true,
              slivers: [
                //image
                SliverPersistentHeader(
                  pinned: true,
                  delegate:SliverImage(
                    imagePath: widget.userModel.imagePath!,
                    heroTag: widget.heroTag,
                    category: widget.userModel.category,
                    minHeight: taskPercent! >= 0 ? 180 : 90,
                    maxHeight: taskPercent! >= 0 ? 250 : 95

                  )
                  ,),
                //input title
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverContainer(
                    color: Theme.of(context).indicatorColor,
                    child: GestureDetector(
                              onTap: () {
                                editText();
                              },
                              child: SizedBox(
                                key: widget.key,
                                height: inputHeight,
                                child: TextField(
                                  maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                                  cursorWidth: 1,
                                  focusNode: titleNode,
                                  maxLines: 1,
                                  maxLength: maxTitleLength,
                                  onSubmitted: (val) {
                                    setState(() {
                                      titleNode.unfocus();
                                      // FocusScope.of(context)
                                      //     .requestFocus(
                                      //     descriptionNode);
                                    });
                                  },
                                  keyboardType: TextInputType.text,
                                  enabled: editTextEnable,
                                  onChanged: (newText) {

                                    setState(() {
                                      widget.userModel.title = newText;
                                      titleVal.selection =
                                          TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: titleVal
                                                      .text.length));
                                    });
                                  },
                                  cursorColor: Theme.of(context).textTheme.titleSmall!.color,
                                  controller: titleVal,
                                  autofocus: false,
                                  style: Theme.of(context)
                                      .textTheme.titleSmall!.copyWith(
                                      fontSize: titleFontSize,
                                      decoration: TextDecoration.none),
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    helperText: AppLocalizations.of(context)!.translate('input_title').capitalizeFirstLetter(),
                                    helperStyle: Theme.of(context)
                                        .inputDecorationTheme
                                        .helperStyle!
                                        .copyWith(
                                        color: Theme.of(context).textTheme.titleSmall!.color,
                                        fontSize: helpTextFontSize),
                                  ),
                                  ),
                                ),
                              ),
                            ),

                  ),
                //create button
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverContainer(
                    minHeight: 80,
                    maxHeight: 83,
                    color: Theme.of(context).colorScheme.background,
                    isRoundedCorners: false,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap:(){
                            setState(() {
                              print("Add element was pressed");
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: edgePadding),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppLocalizations.of(context)!.translate(addBtnText).capitalizeFirstLetter(), style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: fontSize),),
                                Icon(Icons.add, color: Theme.of(context).unselectedWidgetColor,),

                              ],
                            ),
                          ),
                        ),
                        const Divider()
                      ],
                    ),
                  ),
                ),
                // widget.userModel.items == [] ? SliverToBoxAdapter(
                //   child: SizedBox(width: 20,height: 20,),
                // ):
                SliverAnimatedList(
                  initialItemCount: widget.userModel.items!.length,
                  itemBuilder: (context,index,animation){
                    var data = widget.userModel.items![index];
                    int exerciseNumber = index + 1;

                    return  Container(
                        margin: EdgeInsets.symmetric(horizontal: edgePadding/2, ),
                        child: ExpansionTile(
                          backgroundColor: index.isEven ?
                          Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).colorScheme.background,
                          collapsedBackgroundColor: index.isEven ?
                          Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).colorScheme.background,
                          childrenPadding: EdgeInsets.only(bottom: edgePadding),
                          title: RichText(
                            maxLines:1,
                            text: TextSpan(
                                text: '${exerciseNumber}. ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(fontSize: fontSize),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '${data.name} '.capitalizeFirstLetter(),
                                  ),
                                  // TextSpan(
                                  //   text: '${data.qty} '.capitalizeFirstLetter(),
                                  //   style: Theme.of(context)
                                  //       .textTheme
                                  //       .headlineMedium!
                                  //       .copyWith(fontSize: fontSize),
                                  // )
                                ]),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: edgePadding, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      maxLines:1,
                                      text: TextSpan(
                                          text: AppLocalizations.of(context)!.translate(tileSubtitle).capitalizeFirstLetter(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(fontSize: fontSize),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ' ${tileElementSummary(index)} '.capitalizeFirstLetter(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium!
                                                  .copyWith(fontSize: fontSize),
                                            ),
                                            TextSpan(
                                              text: AppLocalizations.of(context)!.translate(unitName).capitalizeFirstLetter(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium!
                                                  .copyWith(fontSize: fontSize),
                                            )
                                          ]),
                                    ),
                                    SizedBox(width: 10,)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: edgePadding),
                                child: Icon(
                                  _customTileExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                ),
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                side: BorderSide(
                                    color: data.isDone! ? Theme.of(context).indicatorColor : Theme.of(context).unselectedWidgetColor,
                                    width: 0.5
                                ),
                                activeColor: Theme.of(context).indicatorColor,
                                value: data.isDone!,
                                onChanged: (bool? value) {
                                  setState(() {
                                    data.isDone = value!;
                                    taskPercent = widget.userModel.percentProgress();
                                  });
                                },
                                splashRadius: 2.0,
                              ),
                              Icon(Icons.edit)
                            ],
                          ),
                          children: List.generate(widget.userModel.items![index].elems!.length, (idx){
                            var itemData = widget.userModel.items![index].elems![idx];
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: edgePadding * 2, vertical: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('${itemData.name} ${itemData.qty} ${itemData.unit} ${itemData.value} ${itemData.totalUnit}',
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(fontSize: fontSize),
                                  ),
                                ],
                              ),
                            );
                          }

                          ),
                          onExpansionChanged: (bool expanded) {
                            setState(() {
                              _customTileExpanded = expanded;
                            });
                          },
                        ),
                      );
                },),
                taskPercent! >= 0 ?
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: edgePadding / 2, ),
                    padding: EdgeInsets.symmetric(horizontal: edgePadding, vertical: edgePadding ),
                    color: Theme.of(context).colorScheme.background,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Divider(),
                        RichText(
                          maxLines:1,
                          text: TextSpan(
                              text: AppLocalizations.of(context)!.translate('progress_bar').capitalizeFirstLetter(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(fontSize: fontSize),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' $tileElementsResult '.capitalizeFirstLetter(),
                                ),
                                TextSpan(
                                  text: AppLocalizations.of(context)!.translate(unitName),
                                )
                              ]),
                        ),

                      ],
                    ),
                  ),
                ) : SliverToBoxAdapter(
                  child: SizedBox(width: 20,),
                ),
                taskPercent! >= 0 ? SliverToBoxAdapter(
                  child:
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: edgePadding / 2),
                    padding: EdgeInsets.symmetric(horizontal: edgePadding, vertical: edgePadding),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
                    ),

                    child:  Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(AppLocalizations.of(context)!.translate("progress_bar").capitalizeFirstLetter(), style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                            Text(
                                '${(taskPercent!*100).toStringAsFixed(2)}%',style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0, bottom: edgePadding),
                          child: LinearProgressIndicator(
                            value: taskPercent,
                            semanticsLabel: 'Progress',
                            backgroundColor: Theme.of(context).unselectedWidgetColor.withOpacity(0.5),
                            valueColor: AlwaysStoppedAnimation<Color>(
                                cardBcgColor.bcgColor!
                            ),
                          ),
                        ) ,
                      ],
                    ),
                  ),
                ) : SliverToBoxAdapter(
                  child: SizedBox(width: 20,),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 120,),
                )
                ]
          )
            ,),
          ),
          //bottom nav
          Visibility(
            visible: isBottomBarVisible ,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 50,
                // width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15.0),
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
                          switch (index) {
                            case 0:

                              break;
                            case 1:

                              break;
                            case 2:

                              break;
                            case 3:
                              Navigator.pop(context, true);
                            // _pickDate(context);
                              break;
                            case 4:
                            //delete element

                              break;
                            case 5:
                            //cancel
                              Navigator.pop(context, true);
                              break;
                            case 6:

                              Navigator.pop(context, true);
                              break;
                          }
                        });

                      },
                      icon: menuItem.icon ,
                      title: menuItem.title,
                      fontSize: 8.0,
                     // spaceMargin: 12,

                    );
                  },
                ),
              ),
            ),
          ),
      ]
      )
    );
  }
}
