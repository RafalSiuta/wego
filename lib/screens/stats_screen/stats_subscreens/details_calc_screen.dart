import 'package:flutter/material.dart';

import '../../../model/calculation_model/calculation_model.dart';
import '../../../model/color/color_switch.dart';
import '../../../utils/dimensions/size_info.dart';
import '../../../utils/internationalization/app_localizations.dart';
import '../../../widgets/headers/date_header.dart';
import '../../../widgets/headers/sliver_date_header.dart';
import '../../../widgets/headers/sliver_header.dart';
import '../../../widgets/headers/sliver_image_header.dart';
import '../../../widgets/shapes/card_small_pattern.dart';

class DetailCalcScreen extends StatefulWidget {
  const DetailCalcScreen({required this.data,required this.heroTag, super.key});
  final CalculationModel? data;
  final String heroTag;


  @override
  State<DetailCalcScreen> createState() => _DetailCalcScreenState();
}

class _DetailCalcScreenState extends State<DetailCalcScreen> {
  @override
  Widget build(BuildContext context) {
    var titleFontSize = SizeInfo.headerSubtitleSize;
    var descriptionFontSize = SizeInfo.taskCreatorDescription;
    var edgePadding = SizeInfo.leftEdgePadding;
    var cardBcgColor  = ColorSwitch(category: widget.data!.category);
    cardBcgColor.getColor(context);

    var shapeDecorationSize = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: cardBcgColor.bcgColor,
      body: SafeArea(
        child: Stack(
        children: [
          Transform.translate(
            offset: Offset(70, -70),
            child: CustomPaint(
              size: Size(shapeDecorationSize , shapeDecorationSize ),
              painter: CardSmallPattern(color: cardBcgColor.patternColor),
            ),
          ),
        CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverDateHeader(),),
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverImageHeader(
              maxHeight: shapeDecorationSize,
              data: widget.data!,
              heroTag: widget.heroTag
          ),),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.symmetric(horizontal: edgePadding/2, ),
              padding: EdgeInsets.symmetric(horizontal: edgePadding,),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                // borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),

              ),
              child: Text(AppLocalizations.of(context)!.translate(widget.data!.description!),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(height: 1.8, fontSize: descriptionFontSize),),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: edgePadding/2, ),
              padding: EdgeInsets.symmetric(horizontal: edgePadding,),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                // borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),

              ),
              child: Text(AppLocalizations.of(context)!.translate(widget.data!.longDescription!),
                maxLines: 100,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(height: 1.8, fontSize: descriptionFontSize),),
            ),
          ]),),


        // SliverPersistentHeader(
        //   pinned: true,
        //   delegate: LargeSliverHeader(title: "detail_title", isInfoVisible: false, isBcgTransparent: false,margin: EdgeInsets.symmetric(horizontal: edgePadding/2),padding: EdgeInsets.symmetric(horizontal: edgePadding) ),),

        SliverToBoxAdapter(
            child:SizedBox(height: 50,)
        ),
      ],
    )
        ],
    )));
  }
}
