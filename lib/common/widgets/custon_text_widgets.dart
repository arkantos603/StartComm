import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/app_colors.dart';
import 'package:startcomm/common/constants/app_texts.dart';

class CustonTextFormField extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextInputAction? textInputAction;
  const CustonTextFormField({
    super.key,
    this.padding,
    this.hintText,
    this.labelText,
    this.controller,
    this.textCapitalization,
    this.keyboardType,
    this.maxLength,
    this.textInputAction,
  });

  @override
  State<CustonTextFormField> createState() => _CustonTextFormField();
}

class _CustonTextFormField extends State<CustonTextFormField> {
  final defaultBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.luzverde2,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 12.0,
      ),
      child: TextFormField(
        textInputAction: widget.textInputAction,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        textCapitalization: 
          widget.textCapitalization ?? TextCapitalization.none,
        decoration: InputDecoration(
          hintText: widget.hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.labelText?.toUpperCase(), 
          labelStyle: AppTextsStyles.smallText.copyWith(
            color: AppColors.grey,
          ),
          focusedBorder: defaultBorder,
          errorBorder: defaultBorder.copyWith(
            borderSide: const BorderSide(
              color: Colors.red),
          ),
          focusedErrorBorder: defaultBorder.copyWith(
            borderSide: const BorderSide(
              color: Colors.red),
          ),
          enabledBorder: defaultBorder,
          disabledBorder: defaultBorder,                   
        ),
      ),
    );
  }
}