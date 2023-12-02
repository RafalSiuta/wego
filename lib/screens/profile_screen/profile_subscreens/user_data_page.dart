import 'package:wego/widgets/seekbar/seekbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wego/providers/profile_provider/profile_provider.dart';
import '../../../model/choice_model/choice_model.dart';
import '../../../widgets/buttons/tile_button.dart';
import '../../../widgets/headers/widget_header.dart';
import '../../../widgets/responsive/list_builder.dart';


class UserDataPage extends StatelessWidget {
  const UserDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    const tileSize = 100.0;
    const fontSize  = 12.0;

    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child){


      return
        Column(
          children: [
            SizedBox(height: 20,),
            WidgetHeader(
              title: "gender",
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TileButton(
                  choiceModel: ChoiceModel(
                    icon: FontAwesomeIcons.mars,
                    title: "male",
                    groupValue: profileProvider.isGenderSelected,
                    selectedValue: true,
                  ),
                  tileSize: tileSize,
                  onGenderSelect: (){
                    profileProvider.onGenderSelect(true);
                  },
                ),
                TileButton(
                  choiceModel: ChoiceModel(
                      icon: FontAwesomeIcons.venus,
                      title: "female",
                      groupValue: profileProvider.isGenderSelected,
                      selectedValue: false
                  ),
                  tileSize: tileSize,
                  onGenderSelect: (){
                    profileProvider.onGenderSelect(false);
                  },
                )
              ],
            ),
            SizedBox(height: 20,),
            Divider(
              indent: 70,
            endIndent: 70,
            ),
            ListBuilder(
              itemCount: profileProvider.usrData.userDataListCounter,
              itemBuilder:  (context, index){
                final data = profileProvider.userDataList[index];
                return SeekBar(
                  data.sliderValue.toDouble(),
                  btnPlus: (){
                    profileProvider.setUserData(index, operator: "+");
                  }, btnMinus: (){
                  profileProvider.setUserData(index, operator: "-");
                }, onChange: (newVal){
                  profileProvider.setUserData(index, newValue: newVal,);
                }, title: data.name,unit: data.unit,minValue: data.minValue, maxValue: data.maxValue,);
              }, separatorBuilder: (context, item){
              return  const SizedBox(height: 10,);
            },
            ),
            // Expanded(
            //   child: ListView.separated(
            //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            //      itemCount: profileProvider.usrData.userDataListCounter,
            //       itemBuilder: (context, index){
            //         final data = profileProvider.userDataList[index];
            //     return SeekBar(
            //       data.sliderValue.toDouble(),
            //       btnPlus: (){
            //         profileProvider.setUserData(index, operator: "+");
            //       }, btnMinus: (){
            //       profileProvider.setUserData(index, operator: "-");
            //     }, onChange: (newVal){
            //       profileProvider.setUserData(index, newValue: newVal,);
            //     }, title: data.name,unit: data.unit,minValue: data.minValue, maxValue: data.maxValue,);
            //   }, separatorBuilder: (context, item){
            //     return  const SizedBox(height: 10,);
            //   },
            //   ),
            // ),
            const SizedBox(height: 20,),
            Divider(
              indent: 70,
              endIndent: 70,
            ),

          ],
        );
    });
  }
}
