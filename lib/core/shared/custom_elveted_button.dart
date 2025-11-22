import 'package:flutter/material.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_text_theme.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  const CustomElevatedButton({
    super.key,
    this.onPressed,
    required this.title,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius = 12.0,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? context.height * 0.06,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.gold,
          foregroundColor: textColor ?? Colors.black,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: textStyle ?? TextStyleHelper.font16WhiteBold.copyWith(
            color: textColor ?? Colors.black,
          ),
        ),
      ),
    );
  }
}