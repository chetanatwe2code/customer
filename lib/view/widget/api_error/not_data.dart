import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class NoData extends StatelessWidget {
  final IconData? iconData;
  const NoData({Key? key,this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(iconData??Icons.notifications_off,
        size: 100,color: AppColors.textColor().withOpacity(0.2),),
    );
  }
}
