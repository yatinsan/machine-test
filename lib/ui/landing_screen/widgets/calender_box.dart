import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meetings/ui/core/theme/colors.dart';
import 'package:meetings/ui/landing_screen/view_model/meeting_list_controller.dart';
import 'package:provider/provider.dart';

class CalenderBox extends StatelessWidget {
  const CalenderBox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MeetingListController>();

    return Dismissible(
      key: GlobalKey(),
      behavior: HitTestBehavior.deferToChild,
      confirmDismiss: (direction) async {
        controller.selectedMonth =
            controller.selectedMonth + (direction.index == 2 ? 1 : -1);

        return false;
      },
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: AppColor.tileBg,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Column(children: [titleRow(), dateContent(controller)]),
      ),
    );
  }

  DateTime getFirstWeekStartDate(int month, int year) {
    final firstDayOfMonth = DateTime(year, month, 1);
    final weekday = firstDayOfMonth.weekday;
    final startOfWeek = firstDayOfMonth.subtract(Duration(days: weekday % 7));
    return startOfWeek;
  }

  DateTime getFirstWeekEndDate(int month, int year) {
    final endDayOfMonth = DateTime(year, month + 1, 0);
    final weekday = endDayOfMonth.weekday;
    final startOfWeek = endDayOfMonth.add(Duration(days: 7 - weekday % 7));
    return startOfWeek;
  }

  dateContent(MeetingListController controller) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final firstWeekStartDate = getFirstWeekStartDate(
      controller.selectedMonth,
      controller.selectedYear,
    );
    final lastWeekendDate = getFirstWeekEndDate(
      controller.selectedMonth,
      controller.selectedYear,
    );
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemCount: lastWeekendDate.difference(firstWeekStartDate).inDays,
      itemBuilder: (context, index) {
        var buildDate = firstWeekStartDate.add(Duration(days: index));
        final isToday = today == buildDate;
        var isThisMonth = controller.selectedMonth == buildDate.month;
        final isSelectedDate = controller.calenderSelectedDate == buildDate;
        final hasMeeting =
            controller.meetingDateList
                ?.where(
                  (element) =>
                      DateTime.tryParse(element.date ?? '') == buildDate,
                )
                .firstOrNull;

        return InkWell(
          onTap: () {
            controller.calenderSelectedDate = buildDate;
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelectedDate ? Colors.lightGreen : null,
              border: Border.all(
                color: isToday ? Colors.lightGreen : Colors.transparent,
              ),
              // border: Border.all(color: Colors.yellow)
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    buildDate.day.toString(),
                    style: TextStyle(
                      color:
                          isThisMonth
                              ? isSelectedDate
                                  ? AppColor.tileBg
                                  : Colors.white
                              : Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (hasMeeting != null)
                  Align(
                    alignment: Alignment(0.9, -0.9),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            (hasMeeting.items?.any(
                                      (element) => element.conflicted == true,
                                    ) ??
                                    false)
                                ? Colors.red
                                : buildDate.isAfter(now)
                                ? Colors.lightGreen
                                : Colors.grey,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  titleRow() {
    return SizedBox(
      child: Row(
        children: List.generate(
          7,
          (index) => Expanded(
            child: AspectRatio(
              aspectRatio: 1.3,
              child: Center(
                child: Text(
                  DateFormat(
                    "EE",
                  ).format(DateTime.now().copyWith(day: index - 1)),
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
