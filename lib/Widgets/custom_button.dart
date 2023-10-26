import 'package:flutter/material.dart';

BorderSide customBorderSide(Color color) {
  return BorderSide(
    width: 1.0,
    color: color,
  );
}

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final BorderSide? borderSide;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;
  final bool? loading;
  final double? width;

  const CustomButton({
    Key? key,
    required this.label,
    this.borderSide,
    required this.onPressed,
    this.color = Colors.blue,
    this.borderRadius = 8.0,
    this.loading,
    this.width,
    this.padding = EdgeInsets
        .zero, // const EdgeInsets.symmetric(horizontal: 70.0, vertical: 8.0),
    // const EdgeInsets.symmetric(horizontal: 70.0, vertical: 8.0),
    this.textStyle = const TextStyle(
      fontSize: 16.0,
      color: Colors.white,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: padding,
          child: loading == true
              ? const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  label,
                  style: textStyle,
                ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderSide ?? BorderSide.none,
          ),
        ),
      ),
    );
  }
}
