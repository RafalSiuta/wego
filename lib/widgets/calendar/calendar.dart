import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wego/model/user_calendar_model/user_calendar_model.dart';
import 'package:wego/providers/settings_provider/settings_provider.dart';
import 'package:wego/utils/extensions/string_extension.dart';
import 'package:wego/widgets/responsive/column_row_builder.dart';
import '../../../providers/calendar_provider/calendar_provider.dart';
import '../../../utils/custom_page_route/custom_page_route.dart';
import '../../utils/constans/prefs_keys.dart';
import '../../utils/dimensions/size_info.dart';
import '../../utils/internationalization/app_localizations.dart';


class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    var rowHeight = 50.0;//SizeInfo.rowHeight;
    var calendarFontSize = 10.0;//SizeInfo.calendarDaySize;
    var headerFontSize = SizeInfo.headerSubtitleSize;//15.0;//SizeInfo.headerSubtitleSize;
    var calendarButtonFontSize = 10.0;//SizeInfo.taskCardTitle;
    var chevronIconSize = 18.0;//SizeInfo.switchButtonIconSize;
    var markerRadius = 12.0;//SizeInfo.calendarMarkerSize;
    var markerFontSize = 6.0;//SizeInfo.calendarMarkerFontSize;
    var cellMargin = 10.0;//SizeInfo.calendarCellMargin;
    return Consumer2<CalendarProvider, SettingsProvider>(builder: (context, calendarProvider, settingsProvider, child){
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: AnimationLimiter(
          child: TableCalendar<UserCalendarModel>(
            focusedDay: calendarProvider.currentDay,
            availableGestures: AvailableGestures.all,
            firstDay: DateTime(2000),
            lastDay: DateTime(DateTime.now().year + 2),
            calendarFormat:calendarProvider.format,
            onFormatChanged: (CalendarFormat format) {
              calendarProvider.changeDateFormat(format);
            },
            onDayLongPressed: (DateTime date, list) async {
              //todo: add onpress tooltip choice popout that redirect to pickm creator page
              // await Navigator.push(
              //     context,
              //     CustomPageRoute(
              //         child: CreatorScreen(),
              //         direction: AxisDirection.right));
            },
            rowHeight: rowHeight,
            daysOfWeekHeight: rowHeight,
            headerVisible: true,
            startingDayOfWeek:
            settingsProvider.isCalStartsMonday
                ? StartingDayOfWeek.monday
                : StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,
            onPageChanged: (day) => calendarProvider.onMonthChange(day),
            onDaySelected: calendarProvider.onDaySelected,
            selectedDayPredicate: (day) =>
                isSameDay(calendarProvider.selDay, day),
            eventLoader: calendarProvider.getCalendarValues,
            calendarBuilders: CalendarBuilders(
              headerTitleBuilder: (context, date) {
                return Center(
                  child: PlayAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.8, end: 1.0),
                      duration: const Duration(milliseconds: 300),
                      delay: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Text(

                            '${AppLocalizations.of(context)!.dateFormat(date, context).monthYear!.capitalizeFirstLetter()} ',
                            //'${DateFormat('MMMM yy').format(date)} ',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(fontSize: headerFontSize),
                          ),
                        );
                      }),
                );
              },
              dowBuilder: (context, date) {
                return AnimationConfiguration.staggeredGrid(
                  columnCount: 7,
                  position: date.day,
                  duration: const Duration(milliseconds: 200),
                  child: ScaleAnimation(
                    scale: 0.5,
                    child: FadeInAnimation(
                        child: Center(
                            child: Text(
                              '${AppLocalizations.of(context)!.dateFormat(date, context).shortWeekday!.capitalizeFirstLetter()}',
                              //'${DateFormat('E').format(date)} ',
                              style: (date.weekday != 6 && date.weekday != 7)
                                  ? Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                  fontSize: calendarFontSize,
                                  fontWeight: FontWeight.w300)
                                  : Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                  fontSize: calendarFontSize,
                                  fontWeight: FontWeight.w300),
                            ))),
                  ),
                );
              },
              defaultBuilder: (context, date, notes) {
                return AnimationConfiguration.staggeredGrid(
                  columnCount: 7,
                  position: date.day,
                  duration: const Duration(milliseconds: 200),
                  child: ScaleAnimation(
                    scale: 0.5,
                    child: FadeInAnimation(
                        child: Center(
                            child: Text(
                              '${date.day}',
                              style: (date.weekday != 6 && date.weekday != 7)
                                  ? Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                  fontSize: calendarFontSize,
                                  fontWeight: FontWeight.w500)
                                  : Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                  fontSize: calendarFontSize,
                                  fontWeight: FontWeight.w500),
                            ))),
                  ),
                );
              },
              markerBuilder: (context, date, notes) {
                return notes.isNotEmpty
                    ? Positioned(
                    right: 1.5,
                    bottom: 0.8,
                    child: ColumnBuilder(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      itemCount: calendarProvider.categoryOrder.length,
                      itemBuilder: (context, index) {
                        var bcgColor;
                        String category = calendarProvider.categoryOrder[index];
                        int counter = calendarProvider.countItemsInCategory(notes, category);

                        if (category == workoutCategory) {
                          bcgColor = Color(0xFFF1BCD5);
                        } else if (category == mealCategory) {
                          bcgColor = Color(0xFFEDF0A5);
                        } else if (category == drinkCategory) {
                          bcgColor = Color(0xFFA0DCF1);
                        } else if (category == supplementCategory) {
                          bcgColor = Color(0xFF85DA96);
                        } else {
                          bcgColor = Theme.of(context).colorScheme.surface;
                        }

                        return Container(
                          decoration: BoxDecoration(
                            color: counter != 0 ? bcgColor: Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(index == 0 ? 5 : 0),
                              bottomRight: Radius.circular(index == calendarProvider.categoryOrder.length - 1 ? 5 : 0),
                            ),
                          ),
                          width: markerRadius,
                          height: markerRadius,
                          child: Center(
                            child: Text(
                              counter != 0 ? '$counter' : "",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(fontSize: markerFontSize),
                            ),
                          ),
                        );
                      },
                    )

                )
                    : const Positioned(
                  right: 1,
                  bottom: 1,
                  child: SizedBox(
                    width: 5,
                    height: 5,
                  ),
                );
              },
            ),
            calendarStyle: CalendarStyle(
              cellMargin: EdgeInsets.symmetric(
                  horizontal: cellMargin, vertical: cellMargin / 5),
              isTodayHighlighted: true,
              defaultTextStyle: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(
                  fontSize: calendarFontSize,
                  fontWeight: FontWeight.w500),
              weekendTextStyle: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(
                  fontSize: calendarFontSize,
                  fontWeight: FontWeight.w500),
              selectedTextStyle: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(
                  fontSize: calendarFontSize,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0),
              todayTextStyle: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(
                  fontSize: calendarFontSize,
                  fontWeight: FontWeight.w500),
              outsideTextStyle: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .color!
                      .withOpacity(0.5),
                  fontSize: calendarFontSize,
                  fontWeight: FontWeight.w100,
                  fontFamily:
                  Theme.of(context).textTheme.headlineMedium!.fontFamily),
              todayDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              outsideDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            headerStyle: HeaderStyle(
              headerPadding: EdgeInsets.all(cellMargin),
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Theme.of(context).indicatorColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              rightChevronIcon: Icon(
                Icons.arrow_right,
                color: Theme.of(context).indicatorColor,
                size: chevronIconSize,
              ),
              leftChevronIcon: Icon(
                Icons.arrow_left,
                color: Theme.of(context).indicatorColor,
                size: chevronIconSize,
              ),
              titleTextStyle: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontSize: headerFontSize),
              formatButtonTextStyle: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: calendarButtonFontSize),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(
                  fontSize: calendarFontSize,
                  fontWeight: FontWeight.w300),
              weekendStyle: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(
                  fontSize: calendarFontSize,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
      );
    });

  }
}
