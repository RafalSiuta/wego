import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/choice_model/choice_model.dart';
import '../../../providers/profile_provider/profile_provider.dart';
import '../../../utils/dimensions/size_info.dart';
import '../../../widgets/buttons/tile_button.dart';
import '../../../widgets/cards/slider_card.dart';
import '../../../widgets/carousel/carousel.dart';
import '../../../widgets/headers/info_text.dart';
import '../../../widgets/headers/sliver_header_medium.dart';
import '../../../widgets/headers/widget_header.dart';
import '../../../widgets/responsive/column_row_builder.dart';
import '../../../widgets/responsive/list_builder.dart';
import '../../../widgets/seekbar/seekbar.dart';

class UserActivityPage extends StatelessWidget {
  const UserActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    const tileSize = 100.0;
    const layoutPadding =  EdgeInsets.only(left:12, right: 12.0, top: 12.0, bottom: 12.0);
    const headerPadding =  EdgeInsets.only(left: 12, right: .0, top: 12.0, bottom: 12.0);
    var titleFontSize = SizeInfo.headerSubtitleSize;
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child){
          return
          CustomScrollView(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: MediumSliverHeader(title: "activity_level", fontSize: titleFontSize)
                ,),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // InfoText(
                    //   title: "activity_level",
                    //   padding: headerPadding,
                    // ),
                    ActivityCarousel(),
                    // SizedBox(height: 20,),
                    Divider(
                      indent: 70,
                      endIndent: 70,
                    ),
                  ],
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: MediumSliverHeader(title: "ask_heaviest_weight", fontSize: titleFontSize)
                ,),
              SliverPadding(
                padding: layoutPadding,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: profileProvider.activityPowerData.activityPowerListCounter,
                      (context,index){
                        var data = profileProvider.userPowerActivityList[index];
                        return SeekBar(
                          data.sliderValue.toDouble(),
                          title: data.name,
                          unit: data.unit,
                          minValue: data.minValue,
                          maxValue: data.maxValue,
                          btnPlus: () {
                            profileProvider.setPowerActivityData(index,data.maxValue, operator: "+");
                          },
                          btnMinus: () {
                            profileProvider.setPowerActivityData(index,data.maxValue, operator: "-");
                          },
                          onChange: (newVal) {
                            profileProvider.setPowerActivityData(index,data.maxValue,newValue: newVal);
                          },
                          onChangeEnd: (newValue) {},
                        );

                      }
                  )),
              ),
              SliverToBoxAdapter(
                child: Divider(
                  indent: 70,
                  endIndent: 70,
                ),
              )
            ],
          );
            // Expanded(
            //   child: Column(
            //     children: [
            //       //const SizedBox(height: 20,),
            //       // WidgetHeader(
            //       //   title: "activity",
            //       //   padding: layoutPadding,
            //       // ),
            //       Column(
            //         children: [
            //           InfoText(
            //             title: "activity_level",
            //             padding: headerPadding,
            //           ),
            //           ActivityCarousel(),
            //           // SizedBox(height: 20,),
            //           Divider(
            //             indent: 70,
            //             endIndent: 70,
            //           ),
            //         ],
            //       ),
            //       Column(
            //
            //         children: [
            //           InfoText(
            //             title: "ask_heaviest_weight",
            //             padding: headerPadding,
            //           ),
            //
            //           Padding(
            //             padding: layoutPadding,
            //             child: ListBuilder(
            //               itemCount: profileProvider.activityPowerData.activityPowerListCounter,
            //               itemBuilder: (context, index) {
            //                 var data = profileProvider.userPowerActivityList[index];
            //                 return SeekBar(
            //                   data.sliderValue.toDouble(),
            //                   title: data.name,
            //                   unit: data.unit,
            //                   minValue: data.minValue,
            //                   maxValue: data.maxValue,
            //                   btnPlus: () {
            //                     profileProvider.setPowerActivityData(index,data.maxValue, operator: "+");
            //                   },
            //                   btnMinus: () {
            //                     profileProvider.setPowerActivityData(index,data.maxValue, operator: "-");
            //                   },
            //                   onChange: (newVal) {
            //                     profileProvider.setPowerActivityData(index,data.maxValue,newValue: newVal);
            //                   },
            //                   onChangeEnd: (newValue) {},
            //                 );
            //               },
            //             ),
            //           ),
            //         ],
            //       ),
            //
            //
            //
            //      // const SizedBox(height: 10,),
            //       Divider(
            //         indent: 70,
            //         endIndent: 70,
            //       ),
            //
            //     ],
            //   ),
            // );
        });
  }
}
