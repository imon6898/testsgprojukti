import 'package:flutter/material.dart';

import '../config/app_colors.dart';
class DatePickerButton extends StatelessWidget {

  final Function(DateTime?)? onDatePicked;
  final String? text;
  final double? height, width;
  final Color? backgroundColor, textColor;
  final EdgeInsetsGeometry? margin;
  final IconData? icon;
  final CustomButtonStyle style;
  final bool loading;
  const DatePickerButton({
    super.key,
    this.style = CustomButtonStyle.noOutlinedOnlyText,
    this.icon,
    this.margin,
    this.height,
    this.width,
    this.onDatePicked,
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

    BorderRadiusGeometry radius = BorderRadius.circular(16);

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

    OutlinedButton button =  OutlinedButton(
        onPressed: loading || onDatePicked == null ? null : () async => onDatePicked!(
            await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2023),
                lastDate: DateTime(2050)
            )
        ),
        style: OutlinedButton.styleFrom(
            elevation: 0,
            backgroundColor: backgroundColor ?? const Color(0xffF9FAFB),
            shape: RoundedRectangleBorder(
                borderRadius: radius
            ),
          padding:const EdgeInsets.symmetric(horizontal: 15),
          side: const BorderSide(
            color: Color(0xffD0D5DD)
          ),
        ),

        child: loading ? loadingWidget :  Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              text ?? 'Select date',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? Colors.black54
              ),
            ),
            const Icon(Icons.date_range, size:  16, color: Colors.black54,)
          ],
        )
    );

    return Container(
      margin: margin,
      width: width ?? double.infinity,
      height: height ?? 45,
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