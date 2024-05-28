import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../model/user_calendar_model/user_calendar_model.dart';
import '../../screens/creator_screen/task_creator.dart';
import '../../utils/dimensions/size_info.dart';
import '../cards/small_calendar_card.dart';
import '../headers/info_text.dart';

class CreatorList extends StatelessWidget {
  const CreatorList({this.titleKey, required this.list, super.key});
  final String? titleKey;
  final List<UserCalendarModel>? list;

  @override
  Widget build(BuildContext context) {
    var edgePadding = SizeInfo.edgePadding;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.0,),
        InfoText(
          title: titleKey,
          padding: EdgeInsets.only(left: edgePadding, ),
          isInfoIcon: false,
        ),
        SizedBox(height: 8.0,),
        Expanded(
          child:
          GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 18),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              scrollDirection:Axis.vertical,
              crossAxisSpacing: 5.0,
              shrinkWrap: true,
              mainAxisSpacing: 8.0,
              crossAxisCount: 2,
              childAspectRatio: 2.3 / 3,
              children:
              List.generate(list!.length, (index){
                final data = list![index];
                return AnimationConfiguration.staggeredGrid(
                  columnCount: 2,
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: ScaleAnimation(
                    scale: 0.9,
                    child: FadeInAnimation(
                      child: SmallCalendarCard(
                          title: '${data.title}',
                          subtitle: data.subtitle,
                          itemsList: data.items,
                          value: data.percentProgress(),
                          imagePath: data.imagePath,
                          category: data.category,
                          heroTag: '${data.imagePath}$index${data.title}',
                          onTap: (){
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => TaskCreator(userModel: data,heroTag: '${data.imagePath}$index${data.title}',),
                                transitionDuration: Duration(milliseconds: 300),
                                transitionsBuilder:
                                    (context, animation, secondaryAnimation, child) {
                                  var scale = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                                      parent: animation, curve: Curves.easeIn));
                                  return ScaleTransition(
                                      alignment: Alignment.center, scale: scale, child: child);
                                },
                              ),);
                          }

                      ),
                    ),
                  ),
                );
              }
              )),
        ),
      ],
    );
  }
}
