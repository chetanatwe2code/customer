import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../login/view.dart';

class CommonInputField extends StatelessWidget {
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? textController;
  final String? hintText;
  final String? labelText;
  final int? maxLength;
  final bool obscureText;
  final bool enabled;
  final int maxLine;
  final TextInputType? keyboardType;
  final Function(String string)? onTextChanged;

  const CommonInputField({
    Key? key,
    this.suffixIcon,
    this.prefixIcon,
    this.textController,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.enabled = true,
    this.maxLine = 1,
    this.maxLength,
    this.keyboardType,
    this.onTextChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size media = Get.size;
    bool isLarge = isLargeScreen(media);
    return TextField(
      maxLines: maxLine,
      maxLength: maxLength,
      keyboardType: keyboardType,
      controller: textController,
      autofocus: false,
      onChanged: onTextChanged,
      obscureText: obscureText,
      enabled: enabled,
      style: TextStyle(
        fontSize: isLarge ? 17 : 14
      ),
      decoration: InputDecoration(
          filled: true,
          suffixIcon: isLarge ? null : suffixIcon,
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: isLarge ? 17 : 14
          ),
          labelStyle: TextStyle(
              fontSize: isLarge ? 17 : 14
          ),
          labelText: labelText,
          counterText: "",
          contentPadding: EdgeInsets.symmetric(vertical: (isLarge ? 15 : 10),horizontal: 15),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: Colors.green)),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: Colors.grey)),
      ),
    );
  }
}
