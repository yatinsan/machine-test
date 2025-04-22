import 'package:flutter/cupertino.dart';
import 'package:meetings/ui/core/theme/colors.dart';

class ButtonTile extends StatelessWidget {
  const ButtonTile({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.tileBg,
        shape: BoxShape.circle
      ),
      child: child,
    );
  }
}
