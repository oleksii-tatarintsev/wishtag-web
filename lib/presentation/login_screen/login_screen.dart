import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wishtag_web/shared/styles.dart';
import 'package:wishtag_web/shared/ui_kit.dart';
import 'package:wishtag_web/utils/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier<bool> _isButtonActive = ValueNotifier(false);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateForm);
    _passwordController.removeListener(_validateForm);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    Future.delayed(Duration.zero, () => _isButtonActive.value = _formKey.currentState?.validate() ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBg,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(28.sp),
          width: 500.sp,
          height: 410.sp,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.containerBorder),
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 20.sp,
              children: [
                Text('Admin Panel Login', style: AppFonts.bold23),
                AppTextField(
                  title: 'Email:',
                  placeHolder: 'Enter email...',
                  validator: (String? val) => Validator.validateEmail(val),
                  autofillHints: [AutofillHints.email],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _emailController,
                ),
                AppTextField(
                  title: 'Password:',
                  placeHolder: 'Enter password...',
                  validator: (String? val) => Validator.validatePassword(val),
                  autofillHints: [AutofillHints.password],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  controller: _passwordController,
                ),
                ValueListenableBuilder<bool>(
                    valueListenable: _isButtonActive,
                    builder: (context, isActive, _) {
                      return SizedBox(
                        width: double.infinity,
                        child: AppFilledTextButton(
                          title: 'Login',
                          buttonStyle: FilledTextButtonType.green,
                          onPressed: isActive ? () {} : null,
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
