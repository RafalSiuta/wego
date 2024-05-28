
import 'package:flutter/material.dart';
import 'package:wego/widgets/list/task_list.dart';
import '../../../utils/constans/prefs_keys.dart';
import '../../../utils/dimensions/size_info.dart';
import '../../../widgets/calendar/calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return CustomScrollView(
      physics:
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Calendar(key: key),
          ]),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: .0, vertical: 10),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const TaskList()
            ]),
          ),
        ),
      ],
    );

  }
}


