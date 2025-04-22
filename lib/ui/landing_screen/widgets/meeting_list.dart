import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:meetings/ui/core/theme/colors.dart';
import 'package:meetings/ui/landing_screen/view_model/meeting_list_controller.dart';
import 'package:meetings/ui/landing_screen/widgets/selected_day_meetings.dart';
import 'package:provider/provider.dart';

import 'calender_box.dart';

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
              DropdownButtonHideUnderline(
                child: DropdownButton(
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
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton(
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
              ),
            ],
          ),
          Gap(8),
          CalenderBox(),
          Gap(16),
          Row(
            children: [
              Text(
                "Meetings",
                style: TextStyle(color: Colors.grey.withAlpha(70)),
              ),
              Gap(20),
              Expanded(child: Divider(color: Colors.grey.withAlpha(70))),
            ],
          ),
          Gap(16),
          SelectedDayMeetings(),
        ],
      ),
    );
  }
}

