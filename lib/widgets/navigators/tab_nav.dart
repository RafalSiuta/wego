import 'package:flutter/material.dart';
import 'package:wego/utils/extensions/string_extension.dart';
import '../../model/menu/subscreen_model.dart';
import '../../utils/internationalization/app_localizations.dart';

class TabNav extends StatefulWidget {
  const TabNav( {required this.pages, super.key});
  final List<SubScreenModel>? pages;

  @override
  State<TabNav> createState() => _TabNavState();
}

class _TabNavState extends State<TabNav> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  final int _tabCounter = 0;

  @override
  void initState() {
    //tabs = widget.pages!.map((e) => Tab(text:AppLocalizations.of(context)!.translate(e.title!.title).capitalizeFirstLetter() , height: 40,)).toList();
    _tabController = TabController(initialIndex: _tabCounter, length: widget.pages!.length, vsync: this);
    super.initState();

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        TabBar(
            indicatorWeight: .5,
            dividerColor: Theme.of(context).tabBarTheme.dividerColor,
            controller: _tabController,
            tabs: widget.pages!.map((e) => Tab(text:AppLocalizations.of(context)!.translate(e.title!.title).capitalizeFirstLetter() , height: 40,)).toList()

        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: widget.pages!.map((e) => e.page!).toList(),
              // const BouncingScrollPhysics(
              // parent: BouncingScrollPhysics()),
          ),
        ),

      ],
    );
  }
}
