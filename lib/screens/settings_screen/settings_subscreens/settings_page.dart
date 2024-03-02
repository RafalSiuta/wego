import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../../providers/settings_provider/settings_provider.dart';
import '../../../utils/dimensions/size_info.dart';
import '../../../widgets/buttons/radio_tile.dart';
import '../../../widgets/buttons/switch_tile.dart';
import '../../../widgets/dividers/list_divider.dart';
import '../../../widgets/headers/sliver_header_medium.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var tilePadding = 5.0;
    const layoutPadding =  EdgeInsets.only(left:12.0, right: 12.0, top: 10.0, bottom: 5.0);
    var titleFontSize = SizeInfo.headerSubtitleSize;
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child){
        return Container(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: MediumSliverHeader(title: 'theme_mode', fontSize: titleFontSize)
                ,),
              SliverToBoxAdapter(
                  child: SwitchTile(
                    textValue1: "light_theme",
                    textValue2:"dark_theme",
                    switchValue: settingsProvider.currentTheme,
                    onChanged: (newVal){
                      settingsProvider.onThemeChange(newVal);
                    },
                  )
              ),
              const SliverToBoxAdapter(
                child: ListDivider(),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: MediumSliverHeader(title: 'unit_switch', fontSize: titleFontSize)
                ,),
              SliverToBoxAdapter(
                  child: SwitchTile(
                    textValue1: "metric_unit",
                    textValue2:"imperial_unit",
                    switchValue: true,
                    onChanged: (newVal){

                    },
                  )
              ),
              const SliverToBoxAdapter(
                child: ListDivider(),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: MediumSliverHeader(title: 'option_store_data', fontSize: titleFontSize)
                ,),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: settingsProvider.dataStoreOption.dataStoreCountingListCounter,
                          (context,index){
                        var storeData = settingsProvider.storeDataSettings[index];
                        return RadioTile(
                            title: storeData.firstOption,
                            description: storeData.secondOption,
                            value: index,
                            groupValue: settingsProvider.storeDataChoice,
                            padding:layoutPadding,
                            onChoice: (newVal){
                              settingsProvider.onStoreDataOption(newVal);
                            }
                        );
                      })
              ),
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


