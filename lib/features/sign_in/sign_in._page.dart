import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/app_colors.dart';
import 'package:startcomm/common/constants/app_texts.dart';
import 'package:startcomm/common/constants/routs.dart';
// import 'package:startcomm/common/widgets/custom_bottom_sheet.dart';
import 'package:startcomm/common/widgets/custom_circular_progress_indicator.dart';
import 'package:startcomm/common/widgets/custom_text_form_field.dart';
import 'package:startcomm/common/widgets/multi_text_button.dart';
import 'package:startcomm/common/widgets/password_form_field.dart';
import 'package:startcomm/common/widgets/secondary_button.dart';
import 'package:startcomm/common/utils/validator.dart';
import 'package:startcomm/features/sign_in/sign_in_controller.dart';
import 'package:startcomm/features/sign_in/sign_in_state.dart';
import 'package:startcomm/locator.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _controller = locator.get<SignInController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.state is SignInStateLoading) {
        showDialog(
          context: context,
          builder: (context) => const Center(
            child: CustomCircularProgressIndicator(),
          ),
        );
      }
      if (_controller.state is SignInStateSuccess) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text('Nova tela'),
              ),
            ),
          ),
        );
      }
      if (_controller.state is SignInStateError) {
        // final error = (_controller.state as SignInStateError).message;
        Navigator.pop(context);
        // CustomModalSheetMixin(
        //   context,
        //   content: error.message,
        //   buttonText: "asd",
        // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bem Vindo de Volta!',
                  textAlign: TextAlign.center,
                  style: AppTextsStyles.mediumText36.copyWith(
                    color: AppColors.luzverde2,
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Image.asset(
                    'assets/images/sign_in.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 16.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _emailController,
                        labelText: 'Seu Email',
                        hintText: 'exemplo@gmail.com',
                        validator: Validator.validateEmail,
                      ),
                      PasswordFormField(
                        controller: _passwordController,
                        labelText: "Digite sua senha",
                        hintText: '********',
                        validator: Validator.validatePassword,
                        helperText: 'Mínimo de 8 caracteres',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                  child: SecondaryButton(
                    text: 'Entrar',
                    onPressed: () {
                      final valid = _formKey.currentState != null &&
                          _formKey.currentState!.validate();
                      if (valid) {
                        _controller.signIn(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                      } else {
                        log('erro ao logar');
                      }
                    },
                  ),
                ),
                MultiTextButton(
                  onPressed: () => Navigator.popAndPushNamed(context, NamedRoute.signUp),
                  children: [
                    Text(
                      'Não possui uma conta?',
                      style: AppTextsStyles.smallText.copyWith(
                        color: AppColors.blackGrey,
                      ),
                    ),
                    Text(
                      ' Cadastre-se',
                      style: AppTextsStyles.smallText.copyWith(
                        color: AppColors.luzverde2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}