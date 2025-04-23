import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meetings/data/model/meeting_date_model.dart';
import 'package:meetings/ui/core/theme/colors.dart';
import 'package:meetings/ui/landing_screen/view_model/meeting_list_controller.dart';
import 'package:meetings/ui/landing_screen/widgets/meeting_list.dart';
import 'package:provider/provider.dart';

class SelectedDayMeetings extends StatelessWidget {
  const SelectedDayMeetings({super.key});

  @override
  Widget build(BuildContext context) {
    var meetingListController = context.watch<MeetingListController>();
    final selectedDayMeetings = meetingListController.meetingDateList
        ?.firstWhere(
          (element) =>
              DateTime.tryParse(element.date ?? '') ==
              meetingListController.calenderSelectedDate,
          orElse: () => MeetingDateModel(),
        );

    return ListView.builder(
      itemCount: selectedDayMeetings?.items?.length ?? 0,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        final meeting = selectedDayMeetings!.items![index];

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: AppColor.tileBg,
            borderRadius: BorderRadius.circular(7),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              Row(
                children: [
                  Expanded(child: Text(meeting.title ?? '')),
                  Text(meeting.time ?? ''),
                ],
              ),
              Divider(thickness: 0.7, color: Colors.grey.withAlpha(50)),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      DateFormat(
                        "EEEE, MMMM, d",
                      ).format(meetingListController.calenderSelectedDate),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                      ),
                    ),
                  ),
                 if(meeting.conflicted == true) Row(
                    children: [
                      Icon(Icons.person, color: Colors.red),
                      Icon(Icons.person, color: Colors.red),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
