import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wego/model/user_calendar_model/user_calendar_model.dart';

import '../../model/menu/nav_model.dart';
import '../../utils/dimensions/size_info.dart';
import '../../widgets/navigators/side_nav.dart';

class TaskCreator extends StatefulWidget {
  const TaskCreator({required this.userModel, super.key});

  final UserCalendarModel userModel;

  @override
  State<TaskCreator> createState() => _TaskCreatorState();
}

class _TaskCreatorState extends State<TaskCreator> with TickerProviderStateMixin{

  late AnimationController? _menuSlideInController;
  late Animation<Offset> _menuAnimation;
  int selectedIndex = 1;

  List<NavModel> titles = [
    NavModel(
      icon: FontAwesomeIcons.floppyDisk,
    ),
    NavModel(
      icon: FontAwesomeIcons.image,
    ),
    NavModel(
      icon: FontAwesomeIcons.pen,
    ),
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
  }

  @override
  void dispose() {
    _menuSlideInController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var topMargin = SizeInfo.topMargin;
    var titleFontSize = SizeInfo.taskCreatorTitle;
    var descriptionFontSize = SizeInfo.taskCreatorDescription;
    var helpTextFontSize = SizeInfo.helpTextSize;
    var edgePadding = SizeInfo.leftEdgePadding;
    var raterIconSize = SizeInfo.switchButtonIconSize;
    var leftPadding = SizeInfo.edgePadding;
    var inputHeight = SizeInfo.searchBarHeight;
    var navIconSize = SizeInfo.leadingAndTrailingIconSize;
    int maxTitleLength = 15;
    int maxDescriptionLength = 4000;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   shadowColor: Colors.transparent,
        //   leading: IconButton(
        //     onPressed: (){
        //       Navigator.pop(context);
        //     },
        //     icon: Icon(Icons.close),
        //   ),
        // ),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
              child: AnimationLimiter(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: topMargin, right: leftPadding),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children:
                      AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 300),
                        childAnimationBuilder: (widget) =>
                            ScaleAnimation(
                              scale: 0.8,
                              child: FadeInAnimation(
                                child: widget,
                              ),
                            ),
                        children: [
                          IntrinsicHeight(
                            child: Image(
                                alignment: Alignment.topRight,
                                width: MediaQuery.of(context).size.width / 1.5,
                                fit: BoxFit.contain,
                                image: AssetImage(widget.userModel.imagePath!)),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            ),
            SlideTransition(
              position: _menuAnimation,
              child: CreatorNav(
                backgroundColor:
                Theme.of(context).scaffoldBackgroundColor,
                navDotIndicatorSize: navIconSize,
                itemCount: titles.length,
                titles: titles,
                selectedItem: selectedIndex,
                onTap: (int index) {
                  setState(() {
                    selectedIndex = index;
                    switch (selectedIndex) {
                      case 0:
                        //save all crated items
                        Navigator.pop(context, true);
                        break;
                      case 1:

                        break;
                      case 2:

                        break;
                      case 3:
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
              ),
            ), //nav rail menu
          ],
        ),
      )
    );
  }
}
