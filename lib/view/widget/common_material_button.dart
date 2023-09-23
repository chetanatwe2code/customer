import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class CommonMaterialButton extends StatelessWidget {
  final Color? color;
  final String? text;
  final Widget? label;
  final IconData? iconData;
  final double? horizontalPadding;
  final bool isLoading;
  final bool isEnable;
  final Function()? onTap;
  final double? fontSize;
  final double? borderRadius;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final double height;

  const CommonMaterialButton({
    Key? key,
    this.height = 50,
    this.color,
    this.text,
    this.label,
    this.iconData,
    this.horizontalPadding,
    this.isEnable = true,
    this.isLoading = false,
    this.onTap,
    this.fontSize,
    this.borderRadius,
    this.fontColor,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular((borderRadius ?? 45)),
      color: !(isLoading || !isEnable) ? (color ?? Colors.blueGrey.withOpacity(0.3)) : (color ?? Colors.blueGrey.withOpacity(0.3)).withOpacity(0.5),
      child: InkWell(
        borderRadius: BorderRadius.circular((borderRadius ?? 45)),
        onTap: (isLoading || !isEnable) ? null : onTap,
        child: Container(
          height: (height),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular((borderRadius ?? 45)),
          ),
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 44),
          child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  if(isLoading)...[
                    SizedBox(
                      height: (height) / 2,
                      width: (height) / 2,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                  ]else...[
                    if(label != null)...[
                       label!
                    ]else...[
                      if(iconData != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Icon(iconData!,size: 20,color: fontColor ?? AppColors.iconColor()),
                        ),
                      const SizedBox(width: 5,),
                      Text(text ?? "Click Now",
                        style: TextStyle(
                          color: fontColor ?? Colors.black,
                          fontSize: (fontSize ?? 14),
                          letterSpacing: -0.4,
                          fontWeight: fontWeight ?? FontWeight.w400,
                        ),
                      ),
                    ],
                  ],
                ],
              ),
        ),
      ),
    );
  }
}
