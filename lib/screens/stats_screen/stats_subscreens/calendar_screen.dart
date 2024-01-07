import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wego/model/user_calendar_model/user_calendar_model.dart';
import 'package:wego/providers/settings_provider/settings_provider.dart';
import 'package:wego/widgets/list/task_list.dart';
import '../../../providers/calendar_provider/calendar_provider.dart';
import '../../../utils/custom_page_route/custom_page_route.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: .0, vertical: 20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              TaskList()
            ]),
          ),
        ),
      ],
    );

  }
}


