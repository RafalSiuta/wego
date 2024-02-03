import 'package:flutter/material.dart';
import '../model/menu/subscreen_model.dart';
import '../widgets/navigators/side_nav.dart';

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

  @override
  void initState() {
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
             // await Navigator.pushNamed(context, '/settings');
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
