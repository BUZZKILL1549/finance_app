import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Size? fixedSize;

  const GradientButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.fixedSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Colors.blueGrey, Colors.blueGrey.shade400],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          fixedSize: fixedSize,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
        ),
      ),
    );
  }
}