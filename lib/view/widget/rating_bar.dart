import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final String? ratingCount;
  final double starNum;
  final double size;
  final GestureTapCallback? onTap;
  const RatingBar({Key? key,required this.rating,this.ratingCount,this.size=18,this.onTap,this.starNum=5}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> starList = [];

    int realNumber = rating.floor();
    int partNumber = ((rating - realNumber) * 10).ceil();

    for (int i = 0; i < starNum; i++) {
      if (i < realNumber) {
        starList.add(Icon(Icons.star, color: AppColors.ratingColor, size: size));
      } else if (i == realNumber) {
        starList.add(SizedBox(
          height: size,
          width: size,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Icon(Icons.star, color: AppColors.ratingColor, size: size),
              ClipRect(
                clipper: _Clipper(part: partNumber),
                child: Icon(Icons.star, color: Colors.grey, size: size),
              )
            ],
          ),
        ));
      } else {
        starList.add(Icon(Icons.star, color: Colors.grey, size: size));
      }
    }

   if(ratingCount != null) {
     starList.add(Text("($ratingCount)",
    style: TextStyle(
      color: AppColors.textColor().withOpacity(0.8),
    ),));
   }

    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: starList,
      ),
    );
  }
}


class _Clipper extends CustomClipper<Rect> {
  final int part;

  _Clipper({required this.part});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
      (size.width / 10) * part,
      0.0,
      size.width,
      size.height,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}

