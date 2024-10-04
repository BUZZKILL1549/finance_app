import 'package:flutter/material.dart';

class GradientAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool leading;

  const GradientAppbar({
    super.key,
    required this.leading,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: leading,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: <Color>[Colors.blueGrey.shade900, Colors.blueGrey.shade500],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
