import 'package:flutter/material.dart';

import '../config/app_colors.dart';
class CustomButton extends StatelessWidget {

  final VoidCallback? onPressed;
  final String? text;
  final double? height, width;
  final Color? backgroundColor, textColor;
  final EdgeInsetsGeometry? margin;
  final IconData? icon;
  final CustomButtonStyle style;
  final bool loading;
  const CustomButton({
    super.key,
    this.style = CustomButtonStyle.noOutlinedOnlyText,
    this.icon,
    this.margin,
    this.height,
    this.width,
    this.onPressed,
    this.text,
    this.backgroundColor,
    this.textColor,
    this.loading = false
  });

  @override
  Widget build(BuildContext context) {

    bool isNoOutlinedIcon = false, isOutlinedIcon = false, isNoOutlinedOnlyText = false, isOutlinedOnlyText = false;

    isNoOutlinedIcon = style == CustomButtonStyle.noOutlinedIcon;
    isOutlinedIcon = style == CustomButtonStyle.outlinedIcon;
    isNoOutlinedOnlyText = style == CustomButtonStyle.noOutlinedOnlyText;
    isOutlinedOnlyText = style == CustomButtonStyle.outlinedOnlyText;

    BorderRadiusGeometry radius = BorderRadius.circular(8);
    OutlinedBorder shape = isOutlinedIcon || isOutlinedOnlyText
    ? const StadiumBorder(
        side: BorderSide(
            width: 1,
            color: Color(0xffD0D5DD)
        )
    )
    : RoundedRectangleBorder(
      borderRadius: radius
    );

    Widget loadingWidget = const Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
          strokeCap: StrokeCap.round,
        ),
      ),

    );

    ElevatedButton button =  ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: backgroundColor ?? const Color(0xff007AC2),
            shape: shape
        ),
        child: loading ? loadingWidget :  Text(
          text ?? '',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor ?? Colors.white
          ),
        )
    );

    return Container(
      margin: margin,
      width: width ?? double.infinity,
      height: height ?? 44,
      child: button,
    );
  }
}

enum CustomButtonStyle {
  noOutlinedIcon,
  outlinedIcon,
  noOutlinedOnlyText,
  outlinedOnlyText,
}