import 'package:flutter/material.dart';

class CustomSearchInputText extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final bool? enabled;
  final EdgeInsetsGeometry? padding;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged; // Added onChanged callback

  CustomSearchInputText({
    Key? key, // Use the correct key parameter
    this.hintText,
    this.obscureText = false,
    this.padding,
    this.keyboardType,
    this.maxLines,
    this.controller,
    this.enabled,
    this.onChanged, // Added onChanged callback
  }) : super(key: key);

  InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        width: 1,
        color: Color(0xffD0D5DD),
      ));

  TextStyle textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    var child = TextFormField(
      controller: controller,
      obscureText: obscureText,
      enabled: enabled,
      onChanged: onChanged, // Pass the onChanged callback
      decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: textStyle.copyWith(color: Color(0xff667085)),
          border: inputBorder,
          enabledBorder: inputBorder,
          errorBorder: inputBorder,
          focusedBorder: inputBorder,
          filled: true,
          fillColor: const Color(0xffF9FAFB),
          contentPadding: const EdgeInsets.symmetric(vertical: 11, horizontal: 15)),
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType,
      style: textStyle.copyWith(color: Color(0xff1f2427)),
      cursorColor: Color(0xff1f2427),
      cursorWidth: 4,
    );
    return padding != null
        ? Padding(
      padding: padding!,
      child: child,
    )
        : child;
  }
}
