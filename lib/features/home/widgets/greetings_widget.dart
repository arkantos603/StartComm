import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/app_texts.dart';
import '../../../common/constants/app_colors.dart';

class GreetingsWidget extends StatelessWidget {
  const GreetingsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bem Vindo de Volta,',
          style: AppTextStyles.smallText.apply(color: AppColors.white),
        ),
        Text(
          'Empresa',
          style: AppTextStyles.mediumText20.apply(color: AppColors.white),
        ),
      ],
    );
  }
}