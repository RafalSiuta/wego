import 'package:wego/widgets/seekbar/seekbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wego/providers/profile_provider/profile_provider.dart';
import '../../../model/choice_model/choice_model.dart';
import '../../../widgets/buttons/tile_button.dart';
import '../../../widgets/headers/info_text.dart';
import '../../../widgets/responsive/list_builder.dart';


class UserDataPage extends StatelessWidget {
  const UserDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    const tileSize = 100.0;
    const fontSize  = 12.0;
    const layoutPadding =  EdgeInsets.only(left: 12, right: 12.0, top: 12.0, bottom: 12.0);
    const headerPadding =  EdgeInsets.only(left: 12, right: .0, top: 12.0, bottom: 12.0);
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child){


      return
        Column(
          children: [
            InfoText(
              title: "gender",
              padding: headerPadding,
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
            InfoText(
              title: "personal_details_description",
              padding: headerPadding,
            ),
            ListSeparated(
              padding: layoutPadding,
              itemCount: profileProvider.usrData.userDataListCounter,
              itemBuilder:  (context, index){
                final data = profileProvider.userDataList[index];
                return SeekBar(
                  data.sliderValue.toDouble(),
                  btnPlus: (){
                    //todo fix max values:
                    profileProvider.setUserData(index,data.maxValue!, operator: "+");
                  }, btnMinus: (){
                  profileProvider.setUserData(index,data.maxValue!, operator: "-");
                }, onChange: (newVal){
                  profileProvider.setUserData(index,data.maxValue!, newValue: newVal,);
                }, title: data.name,unit: data.unit,minValue: data.minValue!, maxValue: data.maxValue!,);
              }, separatorBuilder: (context, item){
              return  const SizedBox(height: 10,);
            },
            ),
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
