import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final Widget? leading;
  final Color backgroundColor;
  final TextStyle titleTextStyle;
  final IconThemeData? iconTheme;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final double? toolbarHeight;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions = const [],
    this.leading,
    required this.backgroundColor,
    required this.titleTextStyle,
    this.toolbarHeight,
    this.iconTheme,
    this.centerTitle = false,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
      leading: leading,
      backgroundColor: backgroundColor,
      titleTextStyle: titleTextStyle,
      toolbarHeight: toolbarHeight,
      iconTheme: iconTheme,
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
