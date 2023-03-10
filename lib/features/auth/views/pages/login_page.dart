import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/common/constants/colors.dart';
import 'package:nappy_mobile/common/constants/ui.dart';
import 'package:nappy_mobile/common/value/value.dart';
import 'package:nappy_mobile/common/widgets/primary_button.dart';
import 'package:nappy_mobile/common/widgets/visibility_textfield.dart';
import 'package:nappy_mobile/features/auth/controllers/login_controller.dart';
import 'package:nappy_mobile/features/auth/views/auth_view.dart';
import 'package:nappy_mobile/features/auth/views/pages/auth_page_builder.dart';
import 'package:nappy_mobile/features/auth/views/widgets/auth_providers_list.dart';
import 'package:nappy_mobile/router.dart';

class LoginPage extends ConsumerWidget {
  // Public access keys
  static const emailTextFieldKey = Key("email");
  static const passwordTextFieldKey = Key("password");
  static const forgotPasswordButtonKey = Key("forgotPassword");
  static const submitButtonKey = Key("submit");
  static const externalAuthProvidersKey = Key("externalAuthProviders");
  static const registerAccountButtonKey = Key("registerAccount");

  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loginControllerProvider.select((form) => form.loading));
    return AuthPageBuilder(
      title: "Log in",
      subtitle: "Please fill in the credentials",
      builder: (context, theme) {
        final textTheme = theme.textTheme;
        return [
          TextFormField(
            key: emailTextFieldKey,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email_outlined,
                color: theme.iconTheme.color,
              ),
              hintText: "Enter your email address",
            ),
            onChanged: (String? e) {
              ref.read(loginControllerProvider.notifier).onEmailUpdate(e);
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
          ),
          kTextFieldGap,
          VisibilityTextField(
            key: passwordTextFieldKey,
            textInputAction: TextInputAction.done,
            hintText: "Enter your password",
            prefixIcon: Icon(
              Icons.lock_outline,
              color: theme.iconTheme.color,
            ),
            onChanged: (String? pw) {
              ref.read(loginControllerProvider.notifier).onPasswordUpdate(pw);
            },
            onFieldSubmitted: (value) async {
              await ref.read(loginControllerProvider.notifier).signIn(context);
            },
          ),
          kTextFieldGap,
          Align(
            alignment: Alignment.topRight,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                key: forgotPasswordButtonKey,
                onTap: () {
                  Routes.navigate(context, Routes.recoveryRoute);
                },
                child: Text(
                  "Forgot password?",
                  style: textTheme.bodyText1,
                ),
              ),
            ),
          ),
          kDefaultMargin,
          PrimaryButton(
            key: submitButtonKey,
            onPressed: () async {
              await ref.read(loginControllerProvider.notifier).signIn(context);
            },
            text: "Sign in",
            loading: isLoading,
          ),
          kDefaultMargin,
          kDefaultMargin,
          const AuthProvidersList(
            key: externalAuthProvidersKey,
          ),
          Row(
            children: [
              const Spacer(),
              Text(
                "Don't have an account? ",
                style: textTheme.subtitle1,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  key: registerAccountButtonKey,
                  onTap: () {
                    Routes.navigate(context, Routes.signupRoute);
                  },
                  child: Text(
                    "Sign Up",
                    style: textTheme.subtitle1!.copyWith(color: NappyColors.primary),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ];
      },
    ).animate().fade(duration: AuthView.fadeDuration);
  }
}
