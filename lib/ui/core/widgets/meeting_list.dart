import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:meetings/ui/core/theme/colors.dart';
import 'package:meetings/ui/landing_screen/view_model/meeting_list_controller.dart';
import 'package:provider/provider.dart';

class MeetingList extends StatelessWidget {
  const MeetingList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MeetingListController>();

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text("Meeting List")),
              FloatingActionButton(
                onPressed: () {},
                mini: true,
                shape: StadiumBorder(),
                foregroundColor: Colors.white,
                child: Icon(Icons.add),
              ),
            ],
          ),
          Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                value: controller.selectedMonth,
                items: List.generate(12, (index) {
                  final date = DateTime.now().copyWith(month: index + 1);
                  return DropdownMenuItem(
                    value: index + 1,
                    child: Text(DateFormat("MMM").format(date).toString()),
                  );
                }),
                onChanged: (value) {
                  controller.selectedMonth = value;
                },
              ),
              DropdownButton(
                value: controller.selectedYear,

                items: List.generate(10, (index) {
                  final date = (DateTime.now().year - 5 + index);
                  return DropdownMenuItem(
                    value: date,
                    child: Text(date.toString()),
                  );
                }),
                onChanged: (value) {
                  controller.selectedYear = value;
                },
              ),
            ],
          ),
          Gap(8),
          CalenderBox(),
        ],
      ),
    );
  }
}

class CalenderBox extends StatelessWidget {
  const CalenderBox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MeetingListController>();

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: AppColor.tileBg,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(children: [titleRow(), dateContent(controller)]),
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
    final startOfWeek = endDayOfMonth.add(Duration(days: weekday % 7 + 1));
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
        log(buildDate.toString());
        final isToday = today == buildDate;
        var isThisMonth = now.month == buildDate.month;
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isToday ? Colors.lightGreen : null,
            // border: Border.all(color: Colors.yellow)
          ),
          child: Center(
            child: Text(
              buildDate.day.toString(),
              style: TextStyle(
                color:
                    isThisMonth
                        ? isToday
                            ? AppColor.tileBg
                            : Colors.white
                        : Colors.grey,
              ),
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
