import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wishtag_web/core/router/router.gr.dart';
import 'package:wishtag_web/presentation/login_screen/login_notifier.dart';
import 'package:wishtag_web/shared/styles.dart';
import 'package:wishtag_web/shared/ui_kit.dart';
import 'package:wishtag_web/utils/toast_messenger/toast_controller.dart';
import 'package:wishtag_web/utils/validator.dart';

@RoutePage(name: 'LoginRoute')
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
          padding: EdgeInsets.all(28.r),
          width: 500.r,
          height: 400.r,
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
              spacing: 20.r,
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
                SizedBox(
                  width: double.infinity,
                  child: AppFilledTextButton(
                    title: 'Login',
                    buttonStyle: FilledTextButtonType.green,
                    onPressed: () async {
                      if (_isButtonActive.value) {
                        final loginNotifier = ref.read(loginNotifierProvider.notifier);
                        await loginNotifier.singIn(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                        if (loginNotifier.state.hasValue) {
                          await AutoRouter.of(context).push(DashboardRoute());
                        }
                      } else {
                        Toast.add(message: 'loc_check_errors', containerColor: Colors.amber);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
