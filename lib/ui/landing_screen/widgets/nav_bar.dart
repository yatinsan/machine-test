import 'package:flutter/material.dart';
import 'package:meetings/ui/core/theme/colors.dart';
import 'package:meetings/ui/landing_screen/view_model/nav_controller.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavController>();

    final navItemsIcons = [
      Icons.home,
      Icons.upcoming,
      Icons.calendar_month,
      Icons.headphones,
      Icons.person_2_outlined,
    ];

    return Material(
      borderRadius: BorderRadius.circular(12),
      color: AppColor.tileBg,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            5,
            (index) => InkWell(
              onTap: () {
                nav.setNav = index;
              },
              radius: 8,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  navItemsIcons[index],
                  color: nav.selectedNav == index ? AppColor.p1 : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
