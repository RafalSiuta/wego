import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wego/widgets/headers/sliver_container.dart';

import 'model/user_calendar_model/user_calendar_model.dart';


class UserCalendarModel {

  UserCalendarModel({this.id, this.title,this.subtitle, this.category, this.imagePath, this.progressValue, this.date, });
  int? id;
  String? title;
  String? subtitle;
  String? category;
  String? imagePath;
  double? progressValue;
  DateTime? date;




}

class Test extends StatefulWidget {
  const Test({required this.userModel,super.key});

  final UserCalendarModel userModel;

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  TextEditingController titleVal = TextEditingController();

  FocusNode titleNode = FocusNode();

  bool editTextEnable = true;

  void editText() {
    setState(() {
      print("EDIT WAS PRESSED");
      //editTextEnable = !editTextEnable;
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void initState() {
    titleVal.text = widget.userModel.title!;
    super.initState();
  }

  @override
  void dispose() {
    titleNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverContainer(
            color: Theme.of(context).indicatorColor,
            child: GestureDetector(
              onTap: () {
                editText();
              },
              child: SizedBox(
                key: widget.key,
                height: 50,
                child: TextField(
                  maxLengthEnforcement:
                  MaxLengthEnforcement.enforced,
                  cursorWidth: 1,
                  focusNode: titleNode,
                  maxLines: 1,
                  maxLength: 20,
                  onSubmitted: (val) {
                    setState(() {
                      titleNode.unfocus();
                    });
                  },
                  keyboardType: TextInputType.text,
                  enabled: editTextEnable,
                  onChanged: (newText) {
                    setState(() {
                      widget.userModel.title = newText;
                      titleVal.selection =
                          TextSelection.fromPosition(
                              TextPosition(
                                  offset: titleVal
                                      .text.length));
                    });
                  },
                  cursorColor: Theme.of(context).indicatorColor,
                  controller: titleVal,
                  autofocus: true,
                  style: Theme.of(context)
                      .textTheme.titleSmall!.copyWith(
                      fontSize: 15,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    helperText: 'title',
                    helperStyle: Theme.of(context)
                        .inputDecorationTheme
                        .helperStyle!
                        .copyWith(
                        color: Theme.of(context).textTheme.titleSmall!.color,
                        fontSize: 10),
                  ),
                ),
              ),
            ),
          ),

        ),
      ],
    );
  }
}
