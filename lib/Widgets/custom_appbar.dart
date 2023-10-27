import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final Color backgroundColor;
  final TextStyle titleTextStyle;
  final IconThemeData iconTheme;
  final bool centerTitle;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions = const [],
    required this.backgroundColor,
    required this.titleTextStyle,
    required this.iconTheme,
    this.centerTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
      backgroundColor: backgroundColor,
      titleTextStyle: titleTextStyle,
      iconTheme: iconTheme,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
