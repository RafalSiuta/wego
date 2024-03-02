import 'package:flutter/material.dart';
import '../../model/menu/nav_model.dart';
import '../../utils/internationalization/app_localizations.dart';
import '../responsive/screen_type_layout.dart';
import '../../utils/extensions/string_extension.dart';

class SideNav extends StatelessWidget {
  final int itemCount;
  final List<NavModel> titles;
  final Function(int index) onTap;
  final int selectedItem;
  final Widget? leading;
  final Widget? trailing;
  final int quarterTurns;
  final Color backgroundColor;
  final double iconSize;
  final bool isCreator;

  const SideNav(
      {Key? key,
      required this.itemCount,
      required this.titles,
      required this.onTap,
      required this.selectedItem,
      this.isCreator = false,
      this.leading,
      this.trailing,
      this.quarterTurns = -1,
      this.backgroundColor = Colors.transparent,
      this.iconSize = 18.0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,

      key: key,
      margin: isCreator
          ? const EdgeInsets.symmetric(vertical: 8.0, horizontal: .0)
          :  const EdgeInsets.only(left: .0,right: 10.0),//EdgeInsets.zero,
      decoration: BoxDecoration(
          color: isCreator
              ? Theme.of(context).colorScheme.background
              : Colors.transparent,
          borderRadius: isCreator
              ? const BorderRadius.all(Radius.circular(15))
              : BorderRadius.zero,
          boxShadow: [
            isCreator
                ? const BoxShadow(
                color: Colors.black54,
                blurRadius: 3.0,
                offset: Offset(.0, .0),
                spreadRadius: 2.0)
                : const BoxShadow(
                color: Colors.transparent,
                blurRadius: 0.0,
                offset: Offset(.0, .0),
                spreadRadius: 0.0),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.zero,
        child: NavigationRail(
            minWidth: 38,
            leading: leading,
            trailing: trailing,
            backgroundColor: backgroundColor,
            destinations: List.generate(
                itemCount,
                    (index) => NavigationRailDestination(
                  icon: Icon(
                    titles[index].icon,
                    size: iconSize,
                  ),
                  label: RotatedBox(
                    quarterTurns: -1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                          AppLocalizations.of(context)!.translate(titles[index].title).capitalizeFirstLetter()
                        //'${titles[index].title}  ',
                      ),
                    ),
                  ),
                )).toList(),

            selectedIndex: selectedItem,
            onDestinationSelected: onTap),
      ),
    );

    //   ScreenTypeLayout(
    //   mobile: Container(
    //     width: 45,
    //
    //     key: key,
    //     margin: isCreator
    //         ? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0)
    //         :  const EdgeInsets.only(left: .0,right: 10.0),//EdgeInsets.zero,
    //     decoration: BoxDecoration(
    //         color: isCreator
    //             ? Theme.of(context).colorScheme.background
    //             : Colors.transparent,
    //         borderRadius: isCreator
    //             ? const BorderRadius.all(Radius.circular(15))
    //             : BorderRadius.zero,
    //         boxShadow: [
    //           isCreator
    //               ? const BoxShadow(
    //                   color: Colors.black54,
    //                   blurRadius: 3.0,
    //                   offset: Offset(.0, .0),
    //                   spreadRadius: 2.0)
    //               : const BoxShadow(
    //                   color: Colors.transparent,
    //                   blurRadius: 0.0,
    //                   offset: Offset(.0, .0),
    //                   spreadRadius: 0.0),
    //         ]),
    //     child: ClipRRect(
    //       borderRadius: BorderRadius.zero,
    //       child: NavigationRail(
    //           minWidth: 40,
    //           leading: leading,
    //           trailing: trailing,
    //           backgroundColor: backgroundColor,
    //           destinations: List.generate(
    //               itemCount,
    //               (index) => NavigationRailDestination(
    //                     icon: Icon(
    //                       titles[index].icon, //FontAwesomeIcons.solidCircle,
    //                       size: iconSize,
    //                     ),
    //                     label: Text(
    //                       '${titles[index].title.capitalizeFirstLetter()}  ',
    //                     ),
    //                   )).toList(),
    //           selectedIndex: selectedItem,
    //           onDestinationSelected: onTap),
    //     ),
    //   ),
    //   tablet: Container(
    //     key: key,
    //     margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16.0),
    //     decoration: BoxDecoration(
    //         color: Theme.of(context).colorScheme.background,
    //         borderRadius: const BorderRadius.all(Radius.circular(15)),
    //         boxShadow: const [
    //           BoxShadow(
    //               color: Colors.black54,
    //               blurRadius: 3.0,
    //               offset: Offset(.0, .0),
    //               spreadRadius: 2.0),
    //         ]),
    //     child: ClipRRect(
    //       borderRadius: const BorderRadius.all(Radius.circular(15)),
    //       child: NavigationRail(
    //           minWidth: 50,
    //           leading: leading,
    //           trailing: trailing,
    //           backgroundColor: backgroundColor,
    //           groupAlignment: -0.2,
    //           destinations: List.generate(
    //               itemCount,
    //               (index) => NavigationRailDestination(
    //                     icon: Icon(
    //                       titles[index].icon,
    //                       size: iconSize,
    //                     ),
    //                     label: RotatedBox(
    //                       quarterTurns: -1,
    //                       child: Padding(
    //                         padding: const EdgeInsets.symmetric(horizontal: 15),
    //                         child: Text(
    //                           '${titles[index].title}  ',
    //                         ),
    //                       ),
    //                     ),
    //                   )).toList(),
    //           selectedIndex: selectedItem,
    //           selectedLabelTextStyle: Theme.of(context)
    //               .navigationRailTheme
    //               .selectedLabelTextStyle!
    //               .copyWith(fontSize: 32),
    //           unselectedLabelTextStyle: Theme.of(context)
    //               .navigationRailTheme
    //               .unselectedLabelTextStyle!
    //               .copyWith(fontSize: 32),
    //           onDestinationSelected: onTap),
    //     ),
    //   ),
    // );
  }
}



class CreatorNav extends StatelessWidget {
  const CreatorNav({required this.itemCount,
    required this.titles,
    required this.onTap,
    required this.selectedItem,
    this.backgroundColor = Colors.transparent,
    this.navDotIndicatorSize = 8.0, super.key});
  final int itemCount;
  final List<NavModel> titles;
  final Function(int index) onTap;
  final int selectedItem;
  final Color backgroundColor;
  final double navDotIndicatorSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      margin: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
          boxShadow:  [
            BoxShadow(
                color: Theme.of(context).unselectedWidgetColor.withOpacity(0.3),
                blurRadius: 1.5,
                offset: const Offset(.0, .0),
                spreadRadius: 1.5)
          ]
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 12,
            children: List.generate(
              itemCount,
                  (index) =>
              //       SwitchBtn(
              //     value: isButtonPressed,
              //     icon: titles[index].icon,
              //     align: Alignment.center,
              //     onChanged: (val) {
              //       onTap(index);
              //     },
              //   ),
              // ).toList(),

              IconButton(
                onPressed: () {
                  onTap(index);
                },
                disabledColor: Theme.of(context).unselectedWidgetColor,
                icon: Icon(
                  titles[index].icon,
                  size: navDotIndicatorSize,
                  color: selectedItem == index
                      ? Theme.of(context).indicatorColor
                      : Theme.of(context).unselectedWidgetColor,
                ),
              ),
            ).toList(),
            direction: Axis.vertical,
          ),
        ),
      ),
    );
  }
}

