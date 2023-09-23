import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CountBadge extends StatelessWidget {
  final int count;
  final IconData icon;
  final double size;
  final Function? onPressed;
  const CountBadge({Key? key,required this.count,this.size=24,required this.icon,this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Icon(icon),
          if(count > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Column(
                children: [

                  if(count <
                      100)...[
                    Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .errorColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "$count",
                        style: TextStyle(
                            fontSize: 8,
                            color: AppColors.whiteColor()
                        ),),
                    ),
                  ] else
                    ...[

                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .errorColor,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                      ),

                    ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}
