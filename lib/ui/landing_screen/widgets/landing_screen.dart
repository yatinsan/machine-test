import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:meetings/ui/core/theme/colors.dart';
import 'package:meetings/ui/core/widgets/button_tile.dart';
import 'package:meetings/ui/landing_screen/widgets/meeting_list.dart';
import 'package:meetings/ui/landing_screen/view_model/meeting_list_controller.dart';
import 'package:meetings/ui/landing_screen/view_model/nav_controller.dart';
import 'package:meetings/ui/landing_screen/widgets/nav_bar.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavController(),
      child: Scaffold(
        appBar: buildAppBar(),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Consumer<NavController>(
                  builder: (context, value, child) {
                    return [
                      Container(),
                      Container(),
                      ChangeNotifierProvider(
                        create: (context) => MeetingListController(),
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          children: [MeetingList()],
                        ),
                      ),
                      Container(),
                      Container(),
                    ][value.selectedNav];
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: NavBar(),
              ),
              Gap(16),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      actions: [
        Row(
          spacing: 12,
          children: [
            ButtonTile(child: Icon(Icons.factory, color: AppColor.p1)),
            ButtonTile(child: Icon(Icons.mail, color: AppColor.p1)),
            ButtonTile(
              child: Badge(
                backgroundColor: Colors.red,
                textColor: Colors.white,
                label: Text("3"),

                child: Icon(Icons.notifications, color: AppColor.p1),
              ),
            ),
            ButtonTile(child: Icon(Icons.more_horiz, color: AppColor.p1)),
          ],
        ),
        Gap(16),
      ],
    );
  }
}
