import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_texts.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const PrimaryButton({
    super.key,
    this.onPressed,
    required this.text,
  });

  final BorderRadius _borderRadius =
      const BorderRadius.all(Radius.circular(24.0));

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        height: 48.0,
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: onPressed != null
                ? [AppColors.iceWhite, AppColors.iceWhite]
                : [AppColors.iceWhite, AppColors.iceWhite],
          ),
        ),
        child: InkWell(
          borderRadius: _borderRadius,
          onTap: onPressed,
          child: Align(
            child: Text(
              text,
              style: AppTextsStyles.mediumText18.copyWith(
                color: AppColors.luzverde2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}