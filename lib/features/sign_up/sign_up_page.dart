import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/app_colors.dart';
import 'package:startcomm/common/constants/app_texts.dart';
import 'package:startcomm/common/constants/routs.dart';
import 'package:startcomm/common/utils/uppercase_text_formatter.dart';
import 'package:startcomm/common/widgets/custom_bottom_sheet.dart';
import 'package:startcomm/common/widgets/custom_circular_progress_indicator.dart';
import 'package:startcomm/common/widgets/custom_text_form_field.dart';
import 'package:startcomm/common/widgets/multi_text_button.dart';
import 'package:startcomm/common/widgets/password_form_field.dart';
import 'package:startcomm/common/utils/validator.dart';
import 'package:startcomm/common/widgets/primary_button.dart';
import 'package:startcomm/features/sign_up/sign_up_controller.dart';
import 'package:startcomm/features/sign_up/sign_up_state.dart';
import 'package:startcomm/locator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _controller = locator.get<SignUpController>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () {
        if (_controller.state is SignUpStateLoading) {
          showDialog(
            context: context,
            builder: (context) => const CustomCircularProgressIndicator(),
          );
        }
        if (_controller.state is SignUpStateSuccess) {
          Navigator.pop(context);

          Navigator.pushReplacementNamed(
            context,
            NamedRoute.home,
          );
        }

        if (_controller.state is SignUpStateError) {
          final error = _controller.state as SignUpStateError;
          Navigator.pop(context);
          customModalBottomSheet(
            context,
            content: error.message,
            buttonText: "Tentar novamente",
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 16.0),
          Text(
            'Comece a Salvar',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText36.copyWith(
              color: AppColors.greenOne,
            ),
          ),
          Text(
            'O Seu Negócio',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText36.copyWith(
              color: AppColors.greenOne,
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Image.asset(
              'assets/images/sign_up.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16.0),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _nameController,
                  labelText: "Nome da Empresa",
                  hintText: "Coxinhas Dahora...",
                  inputFormatters: [
                    UpperCaseTextInputFormatter(),
                  ],
                  validator: Validator.validateName,
                ),
                CustomTextFormField(
                  controller: _emailController,
                  labelText: "Seu Email",
                  hintText: "user@gmail.com",
                  validator: Validator.validateEmail,
                ),
                PasswordFormField(
                  controller: _passwordController,
                  labelText: "Digite sua senha",
                  hintText: "*********",
                  validator: Validator.validatePassword,
                  helperText:
                      "Sua senha deve ter pelo menos 8 digitos.",
                ),
                PasswordFormField(
                  labelText: "Confirme sua senha",
                  hintText: "*********",
                  validator: (value) => Validator.validateConfirmPassword(
                    _passwordController.text,
                    value,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 16.0,
            ),
            child: PrimaryButton(
              text: 'Cadastrar',
              onPressed: () {
                final valid = _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  _controller.signUp(
                    name: _nameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                } else {
                  log("erro ao logar");
                }
              },
            ),
          ),
          MultiTextButton(
            onPressed: () => Navigator.popAndPushNamed(
              context,
              NamedRoute.signIn,
            ),
            children: [
              Text(
                'Já possui uma conta? ',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.grey,
                ),
              ),
              Text(
                'Entrar ',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.greenOne,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
