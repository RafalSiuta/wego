import 'package:wego/screens/stats_screen/stats_screen.dart';
import 'package:wego/screens/stats_screen/stats_subscreens/calculation_screen.dart';
import 'package:wego/screens/profile_screen/profile_screen.dart';
import 'package:wego/screens/settings_screen/settings_screen.dart';
import 'package:wego/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../model/menu/nav_model.dart';
import '../model/menu/screen_model.dart';
import '../widgets/navigators/side_nav.dart';
import 'creator_screen/creator_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;
  late Animation _degOneTranslationAnimation, _degTwoTranslationAnimation;
  late Animation _animationRotation;
  late Animation<Offset> _menuAnimation;
  late PageController _pageController;
  int _currentPage = 0;

  _onPageChange(int page) {
    setState(() {
      _pageController.animateToPage(page,
          duration: const Duration(microseconds: 500), curve: Curves.easeIn);

      _currentPage = page;
    });
  }

  final List<ScreenModel> _pages = [
    ScreenModel(
      page:  WelcomeScreen(),
      navItem: GButton(
      icon: Icons.dashboard,
      text: "Dash"
      ),
    ),
    ScreenModel(
      page:  StatsScreen(),
      navItem: GButton(
        icon: Icons.calendar_month,
        text: "Cal"
        ),
    ),
    ScreenModel(
      page: ProfileScreen(),
      navItem: GButton(
          icon: Icons.person,
          text: "Profile"
      ),),
    ScreenModel(
        page: CreatorScreen(),
        navItem: GButton(
          icon: Icons.create,
          text: "Create"
          ),),

    ScreenModel(
        page: SettingsScreen(),
        navItem:  GButton(
          icon: Icons.settings,
          text: "Sets"
        )
        // BottomNavigationBarItem(
        //     icon: Icon(Icons.settings),
        //     label: "Sets"
        // ),
    ),
  ];

  hideTrigger() {
    if (_animationController.isCompleted) {
      setState(() {
        _animationController.reverse();
      });
    }
  }

  trigger() {
    setState(() {
      if (_animationController.isCompleted) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0)
    ]).animate(_animationController);
    _degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0)
    ]).animate(_animationController);

    _animationRotation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _menuAnimation = Tween<Offset>(
        begin: const Offset(0.0, 0.0), end: const Offset(-0.5, 0.0))
        .animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutBack));

    super.initState();

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var leadingIconSize = 18.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Expanded(
              child: Center(
                  key: widget.key,
                  child: PageView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: NeverScrollableScrollPhysics()),
                      itemCount: _pages.length,
                      controller: _pageController,
                      onPageChanged: _onPageChange,
                      itemBuilder: (context, index) {
                        return _pages
                            .map((e) => e.page!)
                            .toList()
                            .elementAt(index);
                      })),
            ),
            // SideNav(
            //   leading: IconButton(
            //     splashColor: Colors.transparent,
            //     icon: Icon(
            //       Icons.settings
            //       ,
            //       size: leadingIconSize,
            //     ),
            //     onPressed: () async {
            //       //await Navigator.pushNamed(context, '/settings');
            //     },
            //   ),
            //
            //   itemCount: _pages.length,
            //   titles: _pages.map((e) => e.title!).toList(),
            //   selectedItem: _currentPage,
            //   onTap: (int sel) {
            //     _onPageChange(sel);
            //     hideTrigger();
            //   },
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        //height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
       // padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 2.5,
              spreadRadius: 1.0,
              offset: const Offset(1.5, 1.5),
              color: Theme.of(context).unselectedWidgetColor.withOpacity(0.3)
            )
          ]
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
          child: GNav(
                backgroundColor: Colors.transparent,
                rippleColor: Theme.of(context).primaryColor.withOpacity(0.2),
                hoverColor: Theme.of(context).primaryColorLight.withOpacity(0.2),
                gap: 3,
                tabBorderRadius: 0,
               // tabActiveBorder: Border.all(color:Theme.of(context).textTheme.headlineLarge!.color!, width:0.5),
                curve: Curves.easeInOut,
                activeColor: Theme.of(context).colorScheme.background,
                iconSize: 18,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Theme.of(context).colorScheme.onSecondary,
                color: Theme.of(context).unselectedWidgetColor,
                tabs: _pages.map((e) => e.navItem!).toList(),
                onTabChange:(int sel) {
                            _onPageChange(sel);
                            hideTrigger();
                          },
          ),

          // BottomNavigationBar(
          //   currentIndex: _currentPage,
          //
          //   onTap: (int sel) {
          //     _onPageChange(sel);
          //     hideTrigger();
          //   },
          //   items: _pages.map((e) => e.navItem!).toList()
          // ),
        ),
      ),
    );
  }
}
