import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
class OwnTitleAppBar extends StatelessWidget implements PreferredSizeWidget {

  final SystemUiOverlayStyle? systemOverlayStyle;

  final String title;
  const OwnTitleAppBar({super.key, required this.title, this.systemOverlayStyle});

  @override
  Widget build(BuildContext context) {

    SystemUiOverlayStyle value =  systemOverlayStyle ?? const SystemUiOverlayStyle(
        statusBarColor: Color(0xff003656),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: value,
      child: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          color: const Color(0xff003656),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BackButton(color: Colors.white,),
                const Gap(10),
                Text(title, style: TextStyle(color: Colors.white,),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(
      double.infinity,
      90
  );
}
