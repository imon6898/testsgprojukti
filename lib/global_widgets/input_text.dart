import 'package:flutter/material.dart';

class CustomInputText extends StatelessWidget {
  final String? hintText, initialValue;
  final bool obscureText;
  final bool? enabled;
  final EdgeInsetsGeometry? padding;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final Function()? onTap;

  CustomInputText({
    super.key,
    this.onTap,
    this.hintText,
    this.initialValue,
    this.obscureText = false,
    this.padding,
    this.keyboardType,
    this.maxLines,
    this.controller,
    this.enabled,
    this.onChange
  });


  InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        width: 1,
        color: Color(0xffD0D5DD)
      )
  );


  TextStyle textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400
  );

  @override
  Widget build(BuildContext context) {
    var child = TextFormField(
      controller: controller,
      initialValue: initialValue,
      obscureText: obscureText,
      enabled: enabled,
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
        contentPadding: const EdgeInsets.symmetric(vertical: 11, horizontal: 15)
      ),
      onChanged: onChange,
      onTap: onTap,
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType,
      style: textStyle.copyWith(color: const Color(0xff1f2427)),
      cursorColor: const Color(0xff1f2427),
      cursorWidth: 4,
    );
    return padding != null ? Padding(
        padding: padding!,
        child:  child,
    ) : child;
  }
}
