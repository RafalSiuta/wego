import 'package:flutter/material.dart';
import 'package:wego/model/user_calendar_model/user_calendar_model.dart';
import '../model/menu/subscreen_model.dart';
import '../utils/constans/prefs_keys.dart';
import '../widgets/navigators/side_nav.dart';
import 'creator_screen/task_creator.dart';

class SubScreenContainer extends StatefulWidget {
  const SubScreenContainer({required this.pages, super.key});
  final List<SubScreenModel>? pages;

  @override
  State<SubScreenContainer> createState() => _SubScreenContainerState();
}

class _SubScreenContainerState extends State<SubScreenContainer> {

  late PageController _pageController;

  int _currentPage = 0;

  _onPageChange(int page) {
    setState(() {
      _pageController.animateToPage(page,
          duration: const Duration(microseconds: 500), curve: Curves.easeIn);

      _currentPage = page;
    });
  }

  UserCalendarModel? data;

  UserCalendarModel cardSwitch (){
    UserCalendarModel card = UserCalendarModel();
    if(_currentPage == 0){
      card = UserCalendarModel(category: workoutCategory, title: "",subtitle: "",date: DateTime.now(),items: [],id: 1,imagePath: "");
    }else if(_currentPage == 1){
      card = UserCalendarModel(category: mealCategory, title: "",subtitle: "",date: DateTime.now(),items: [],id: 1,imagePath: "");
    }else if(_currentPage == 2){
      card = UserCalendarModel(category: drinkCategory, title: "",subtitle: "",date: DateTime.now(),items: [],id: 1,imagePath: "");
    }else{
      card = UserCalendarModel(category: supplementCategory, title: "",subtitle: "",date: DateTime.now(),items: [],id: 1,imagePath: "");
    }

    return card;
  }

  @override
  void initState() {
    data = cardSwitch();
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var iconSize = 5.0;
    return Row(
      children: [

        Expanded(
          child: Center(
              key: widget.key,
              child: PageView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: widget.pages!.length,
                  controller: _pageController,
                  onPageChanged: _onPageChange,
                  itemBuilder: (context, index) {
                    return widget.pages!
                        .map((e) => e.page!)
                        .toList()
                        .elementAt(index);
                  })),
        ),
        SideNav(
          leading: IconButton(
            splashColor: Colors.transparent,
            icon: Icon(
              Icons.add,
             // size: 20,
            ),
            onPressed: () async {
              // if(_currentPage == 0){
              //
              // }else if(){
              //
              // }
             // await Navigator.pushNamed(context, '/settings');
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => TaskCreator(userModel: data!, heroTag: 'def',),
                  transitionDuration: Duration(milliseconds: 400),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var scale = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: animation, curve: Curves.easeIn));
                    return ScaleTransition(
                        alignment: Alignment.center, scale: scale, child: child);
                  },
                ),);
            },
          ),
          iconSize: iconSize,
          itemCount: widget.pages!.length,
          titles: widget.pages!.map((e) => e.title!).toList(),
          selectedItem: _currentPage,
          onTap: (int sel) {
            _onPageChange(sel);
          },
        ),

      ],
    );
  }
}
