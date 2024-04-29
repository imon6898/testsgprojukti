import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class OwnAppBar extends StatelessWidget implements PreferredSizeWidget {

  final SystemUiOverlayStyle? systemOverlayStyle;
  final Widget child;
  final EdgeInsets? padding;
  final double? height;
  final Color? backgroundColor;
  const OwnAppBar({super.key, this.backgroundColor, this.height, this.padding, required this.child, this.systemOverlayStyle});

  @override
  Widget build(BuildContext context) {

    SystemUiOverlayStyle value =  systemOverlayStyle ?? SystemUiOverlayStyle(
        statusBarColor: backgroundColor ?? const Color(0xff007AC2),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: value,
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xff007AC2),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16))
        ),
        child: SafeArea(
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(
      double.infinity,
      height ?? 90
  );
}
