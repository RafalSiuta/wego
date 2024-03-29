
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wego/model/user_calendar_model/user_calendar_model.dart';
import 'package:wego/utils/extensions/string_extension.dart';

import '../../model/color/color_switch.dart';
import '../../model/menu/nav_model.dart';
import '../../utils/dimensions/size_info.dart';
import '../../utils/internationalization/app_localizations.dart';
import '../../widgets/buttons/menu_button.dart';
import '../../widgets/headers/sliver_image.dart';
import '../../widgets/headers/sliver_image_header.dart';
import '../../widgets/headers/sliver_input_header.dart';
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

  List<NavModel> _menuItems = [
    NavModel(
      icon: FontAwesomeIcons.floppyDisk,
    ),
    // NavModel(
    //   icon: FontAwesomeIcons.image,
    // ),
    // NavModel(
    //   icon: FontAwesomeIcons.pen,
    // ),
    NavModel(
      icon: FontAwesomeIcons.calendarDay,
    ),
    NavModel(
      icon: FontAwesomeIcons.trash,
    ),
    NavModel(
      icon: FontAwesomeIcons.arrowLeft,
    ),
  ];

  TextEditingController titleVal = TextEditingController();

  FocusNode titleNode = FocusNode();

  bool editTextEnable = false;

  void editText() {
    setState(() {
      editTextEnable = !editTextEnable;
      FocusScope.of(context).unfocus();
    });
  }

  ScrollDirection scrollDirection = ScrollDirection.idle;

  bool isBottomBarVisible = true;

  @override
  void initState() {
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
  }

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
    var raterIconSize = SizeInfo.switchButtonIconSize;
    var leftPadding = SizeInfo.edgePadding;
    var inputHeight = SizeInfo.searchBarHeight;
    var navIconSize = SizeInfo.leadingAndTrailingIconSize;

    int maxDescriptionLength = 4000;
    var cardBcgColor  = ColorSwitch(category: widget.userModel.category);
    cardBcgColor.getColor(context);
    var shapeDecorationSize = MediaQuery.of(context).size.width;

    double imgSize = 120;
    //print("SCREEN WIDTH IS: ${MediaQuery.of(context).size.width}");
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: cardBcgColor.bcgColor,//Theme.of(context).colorScheme.background,

      body: Stack(
        children: [

          Container(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.width,
        child: ClipPath(
          clipper: PageBcgShape(),

          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              color: cardBcgColor.bcgColor,
            ),
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width , MediaQuery.of(context).size.width  ),
              painter: PagePattern(color: cardBcgColor.patternColor),//CardSmallPattern

            ),
            )
        ),
      ),
          // Container(
          //   child: CustomPaint(
          //     size: Size(MediaQuery.of(context).size.width , MediaQuery.of(context).size.width  ),
          //     painter: PagePattern(color: cardBcgColor.patternColor),//CardSmallPattern
          //
          //   ),
          // ),
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
              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                //image
                SliverPersistentHeader(
                  pinned: true,
                  delegate:SliverImage(
                    imagePath: widget.userModel.imagePath!,
                    heroTag: widget.heroTag
                  )
                  ,),
                //input title
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverInputHeader(
                    controller: titleVal,
                    editText: editText,
                    onChange: (newText){
                              setState(() {
                                widget.userModel.title = newText;
                                titleVal.selection =
                                    TextSelection.fromPosition(
                                        TextPosition(
                                            offset: titleVal
                                                .text.length));
                              });
                    },
                    editEnable: editTextEnable,

                  )
                  ,),
                SliverAnimatedList(
                  initialItemCount: widget.userModel.items!.length,
                  itemBuilder: (context,index,animation){
                    var data = widget.userModel.items![index];
                    int exerciseNumber = index + 1;
                    return Container(
                        margin: EdgeInsets.symmetric(horizontal: edgePadding/2, ),
                        padding: EdgeInsets.all(edgePadding),
                        decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
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
                          Padding(
                            padding: EdgeInsets.only(right: edgePadding / 2),
                            child: Icon( data.isDone! ? Icons.check_box : Icons.check_box_outline_blank, size: fontSize,
                              color: data.isDone! ? Theme.of(context).indicatorColor : Theme.of(context).unselectedWidgetColor,),
                          ),
                        ],
                      ),
                    );
                },),

                // SliverList(
                //   delegate: SliverChildListDelegate(
                //     [
                //       Container(
                //         margin: EdgeInsets.symmetric(horizontal: edgePadding/2, ),
                //         padding: EdgeInsets.all(edgePadding),
                //         decoration: BoxDecoration(
                //           color: Theme.of(context).colorScheme.background,
                //           //borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                //
                //         ),
                //         // child:
                //         // GestureDetector(
                //         //   onTap: () {
                //         //     editText();
                //         //   },
                //         //   child: SizedBox(
                //         //     key: widget.key,
                //         //     height: inputHeight,
                //         //     child: TextField(
                //         //       maxLengthEnforcement:
                //         //       MaxLengthEnforcement.enforced,
                //         //       cursorWidth: 1,
                //         //       focusNode: titleNode,
                //         //       maxLines: 1,
                //         //       maxLength: maxTitleLength,
                //         //       onSubmitted: (val) {
                //         //         setState(() {
                //         //           titleNode.unfocus();
                //         //           // FocusScope.of(context)
                //         //           //     .requestFocus(
                //         //           //     descriptionNode);
                //         //         });
                //         //       },
                //         //       keyboardType: TextInputType.text,
                //         //       enabled: editTextEnable,
                //         //       onChanged: (newText) {
                //         //         setState(() {
                //         //           widget.userModel.title = newText;
                //         //           titleVal.selection =
                //         //               TextSelection.fromPosition(
                //         //                   TextPosition(
                //         //                       offset: titleVal
                //         //                           .text.length));
                //         //         });
                //         //       },
                //         //       cursorColor: Theme.of(context).indicatorColor,
                //         //       controller: titleVal,
                //         //       autofocus: true,
                //         //       style: Theme.of(context)
                //         //           .textTheme.titleSmall!.copyWith(
                //         //           fontSize: titleFontSize,
                //         //           decoration: TextDecoration.none),
                //         //       textAlign: TextAlign.start,
                //         //       decoration: InputDecoration(
                //         //         helperText: AppLocalizations.of(context)!.translate('').capitalizeFirstLetter(),//'Enter title',
                //         //         helperStyle: Theme.of(context)
                //         //             .inputDecorationTheme
                //         //             .helperStyle!
                //         //             .copyWith(
                //         //             fontSize: helpTextFontSize),
                //         //       ),
                //         //     ),
                //         //   ),
                //         // ),
                //       ),
                //     ]
                //   ),
                // )

                ]
          )

            ,),
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: AnimationLimiter(
            //       child: Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           mainAxisSize: MainAxisSize.max,
            //           children:
            //           AnimationConfiguration.toStaggeredList(
            //             duration: const Duration(milliseconds: 300),
            //             childAnimationBuilder: (widget) =>
            //                 ScaleAnimation(
            //                   scale: 0.8,
            //                   child: FadeInAnimation(
            //                     child: widget,
            //                   ),
            //                 ),
            //             children: [
            //               IntrinsicHeight(
            //                 child: Hero(
            //                   tag: widget.heroTag,
            //                   child: Image(
            //                       alignment: Alignment.topRight,
            //                       width: MediaQuery.of(context).size.width / 1.5,
            //                       fit: BoxFit.contain,
            //                       image: AssetImage(widget.userModel.imagePath!)),
            //                 ),
            //               ),
            //             ],
            //           )),
            //     ),
            //   ),
            // ),
        //     Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Expanded(
        //         child: SingleChildScrollView(
        //         child: AnimationLimiter(
        //           child: Column(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               mainAxisSize: MainAxisSize.max,
        //               children:
        //               AnimationConfiguration.toStaggeredList(
        //                 duration: const Duration(milliseconds: 300),
        //                 childAnimationBuilder: (widget) =>
        //                     ScaleAnimation(
        //                       scale: 0.8,
        //                       child: FadeInAnimation(
        //                         child: widget,
        //                       ),
        //                     ),
        //                 children: [
        //                   IntrinsicHeight(
        //                     child: Hero(
        //                       tag: widget.heroTag,
        //                       child: Image(
        //                           alignment: Alignment.topRight,
        //                           width: MediaQuery.of(context).size.width / 1.5,
        //                           fit: BoxFit.contain,
        //                           image: AssetImage(widget.userModel.imagePath!)),
        //                     ),
        //                   ),
        //                 ],
        //               )),
        //         ),
        //       ),
        //       ),
        //       //menu nav:
        //       SlideTransition(
        //         position: _menuAnimation,
        //         child: CreatorNav(
        //           backgroundColor:
        //           Theme.of(context).scaffoldBackgroundColor,
        //           navDotIndicatorSize: navIconSize,
        //           itemCount: _menuItems.length,
        //           titles: _menuItems,
        //           selectedItem: selectedIndex,
        //           onTap: (int index) {
        //             setState(() {
        //               selectedIndex = index;
        //               switch (selectedIndex) {
        //                 case 0:
        //                   //save all crated items
        //                   Navigator.pop(context, true);
        //                   break;
        //                 case 1:
        //
        //                   break;
        //                 case 2:
        //
        //                   break;
        //                 case 3:
        //                  // _pickDate(context);
        //                   break;
        //                 case 4:
        //                   //delete element
        //
        //                   break;
        //                 case 5:
        //                   //cancel
        //                   Navigator.pop(context, true);
        //                   break;
        //                 case 6:
        //
        //                   Navigator.pop(context, true);
        //                   break;
        //               }
        //             });
        //           },
        //         ),
        //       ), //nav rail menu
        //     ],
        // ),
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
                          // if(index == 1){
                          //
                          // }else if(index == 2){
                          //   Navigator.pop(context);
                          // }
                          switch (index) {
                            case 0:
                            //save all crated items

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
                     // isChecked: index == 1 ? widget.data!.isFavorite! : false,
                      icon: menuItem.icon ,
                      title: menuItem.title,
                      fontSize: 8.0,
                      spaceMargin: 12,

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
