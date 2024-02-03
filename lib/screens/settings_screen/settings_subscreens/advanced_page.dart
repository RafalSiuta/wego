import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/settings_provider/settings_provider.dart';
import '../../../widgets/buttons/radio_tile.dart';
import '../../../widgets/buttons/switch_tile.dart';
import '../../../widgets/dividers/list_divider.dart';
import '../../../widgets/headers/sliver_header.dart';

class AdvancedPage extends StatelessWidget {
  const AdvancedPage({super.key});

  @override
  Widget build(BuildContext context) {
    var tilePadding = 5.0;
    const layoutPadding =  EdgeInsets.only(left:12.0, right: 12.0, top: 5.0, bottom: 5.0);
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child){
        return Container(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              // SliverPersistentHeader(
              //   pinned: true,
              //   delegate:  LargeSliverHeader(
              //     title: "theme mode",
              //     //padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              //   ),),
              // SliverToBoxAdapter(
              //     child: SwitchTile(
              //       textValue1: "light theme",
              //       textValue2:"dark theme",
              //       switchValue: settingsProvider.currentTheme,
              //       onChanged: (newVal){
              //         settingsProvider.onThemeChange(newVal);
              //       },
              //     )
              // ),
              // const SliverToBoxAdapter(
              //   child: ListDivider(),
              // ),
              // SliverPersistentHeader(
              //   pinned: true,
              //   delegate:  LargeSliverHeader(
              //     title: "units",
              //     // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              //   ),),
              // SliverToBoxAdapter(
              //     child: SwitchTile(
              //       textValue1: "metric units",
              //       textValue2:"imperial units",
              //       switchValue: true,
              //       onChanged: (newVal){
              //
              //       },
              //     )
              // ),
              // const SliverToBoxAdapter(
              //   child: ListDivider(),
              // ),
              SliverPersistentHeader(
                pinned: true,
                delegate:  LargeSliverHeader(
                  title: "nutrition",
                  //padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),),

              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: settingsProvider.nutritionSettingsList.nutritionListCounter,
                          (context,index){
                        var data = settingsProvider.nutritionSettings[index];
                        return
                          SwitchTile(
                            textValue1: data.firstOption,
                            textValue2: data.secondOption,
                            switchValue: data.value,
                            onChanged: (newVal){
                              settingsProvider.onNutritionOption(newVal, index);
                            },
                          );
                        //   RadioTile(
                        //     title: "test ${index}",
                        //     description: "description ${index}",
                        //     value: index,
                        //     groupValue: 2,
                        //     paddingVertical: tilePadding,
                        //     onChoice: (newVal){
                        //     }
                        // );
                      })
              ),
              const SliverToBoxAdapter(
                child: ListDivider(),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: LargeSliverHeader(
                  title: "Body weight",
                  // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),),

              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: settingsProvider.weightOptionList.weightCountingListCounter,
                          (context,index){
                        var data = settingsProvider.weightSettings[index];
                        return RadioTile(
                            title: data.firstOption,
                            description: data.secondOption,
                            value: index,
                            groupValue: settingsProvider.weightChoice,
                            padding: layoutPadding,
                            onChoice: (newVal){
                              settingsProvider.onBodyWeightOption(newVal);
                            }
                        );
                      })
              ),
              // const SliverToBoxAdapter(
              //   child: ListDivider(),
              // ),
              // SliverPersistentHeader(
              //   pinned: true,
              //   delegate:  LargeSliverHeader(
              //     title: "Store data",
              //     // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              //   ),),
              //
              // SliverList(
              //     delegate: SliverChildBuilderDelegate(
              //         childCount: 4,
              //             (context,index){
              //           return RadioTile(
              //               title: "test ${index}",
              //               description: "description ${index}",
              //               value: index,
              //               groupValue: 2,
              //               padding:layoutPadding,
              //               onChoice: (newVal){
              //               }
              //           );
              //         })
              // ),
              const SliverToBoxAdapter(
                child: ListDivider(),
              ),
              const SliverToBoxAdapter(
                  child: SizedBox(height: 50,)
              ),
            ],
          ),
        );
      },
    );
  }
}
