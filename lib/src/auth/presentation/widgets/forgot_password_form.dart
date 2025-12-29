import 'package:ecommerce_shop_app/core/extensions/string_extensions.dart';
import 'package:ecommerce_shop_app/core/extensions/widget_extension.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/core/widgets/rounded_button.dart';
import 'package:ecommerce_shop_app/core/widgets/vertical_label_field.dart';
import 'package:ecommerce_shop_app/src/auth/presentation/app/adapter/auth_cubit.dart';
import 'package:ecommerce_shop_app/src/auth/presentation/views/verify_o_t_p_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state case AuthError(:final message)) {
          CoreUtils.showSnackBar(context, message: message);
        } else if (state is OTPSent) {
          context.push(
            VerifyOTPScreen.path,
            extra: emailController.text.trim(),
          );
        }
      },
      builder: (context, state) => Form(
        key: formKey,
        child: Column(
          children: [
            VerticalLabelField(
              'Email',
              controller: emailController,
              hintText: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
              defaultValidation: false,
              validator: (value) {
                if (value == null || value == '' || value.isEmpty) {
                  return "Required Field.";
                }
                if (!value.isValidateEmail) {
                  return "Invalid Email";
                }
                return null;
              },
            ),
            const Gap(40),
            RoundedButton(
              text: 'Continue',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final email = emailController.text.trim();
                  context.read<AuthCubit>().forgotPassword(email: email);
                }
              },
            ).loading(state is AuthLoading),
          ],
        ),
      ),
    );
  }
}
