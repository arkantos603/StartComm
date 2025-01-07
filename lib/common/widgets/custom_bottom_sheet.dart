import 'package:flutter/material.dart';
import 'package:startcomm/common/widgets/secondary_button.dart';
import '../constants/app_colors.dart';
import '../constants/app_texts.dart';

mixin CustomModalSheetMixin<T extends StatefulWidget> on State<T> {
  Future<bool?> showCustomModalBottomSheet({
    required BuildContext context,
    required String content,
    String? buttonText,
    VoidCallback? onPressed,
    List<Widget>? actions,
    bool isDismissible = true,
  }) {
    assert(buttonText != null || actions != null);

    return showModalBottomSheet(
      isDismissible: isDismissible,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(38.0),
          topRight: Radius.circular(38.0),
        ),
      ),
      builder: (BuildContext context) {
        return PopScope(
          canPop: isDismissible,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(38.0),
                topRight: Radius.circular(38.0),
              ),
            ),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 32.0,
                  ),
                  child: Text(
                    content,
                    style: AppTextsStyles.mediumText20.copyWith(
                      color: AppColors.luzverde1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 32.0,
                  ),
                  child: actions != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: actions,
                        )
                      : SecondaryButton(
                          text: buttonText!,
                          onPressed: onPressed ?? () => Navigator.pop(context),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}