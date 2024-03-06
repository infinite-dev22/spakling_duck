import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_secure_storage/get_secure_storage.dart';
import 'package:smart_rent/ui/pages/auth_pages/login_page/bloc/login_bloc.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/auth_textfield.dart';
import 'package:smart_rent/ui/widgets/profile_pic_widget/bloc/profile_pic_bloc.dart';
import 'package:smart_rent/ui/widgets/wide_button.dart';
import 'package:smart_rent/utilities/app_init.dart';

class LoginWidget extends StatelessWidget {
  var _height = 40.0;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          _signUserIn(context);
        }
        if (state.status.isError) {
          Fluttertoast.showToast(
              msg: "An error occurred",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: AppTheme.red,
              textColor: AppTheme.whiteColor,
              fontSize: 16.0);
        }
        if (state.message != null &&
            state.message!.toUpperCase().contains("USER_NOT_FOUND")) {
          Fluttertoast.showToast(
              msg: "User not found",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: AppTheme.red,
              textColor: AppTheme.whiteColor,
              fontSize: 16.0);
        }
        if (state.message != null &&
            state.message!.toUpperCase().contains("WRONG_PASSWORD_PROVIDED")) {
          Fluttertoast.showToast(
              msg: "Incorrect password",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: AppTheme.red,
              textColor: AppTheme.whiteColor,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        if (state.status.isInitial) {
          context.read<LoginBloc>().add(LoginInitial());
        }
        return _buildBody(context, state);
      },
    );
  }

  Widget _buildBody(BuildContext context, LoginState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            'Welcome',
            softWrap: true,
            style: TextStyle(
                color: AppTheme.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w300),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Focus(
              child: AuthTextField(
                hintText: 'email',
                enabled: !state.status.isLoading,
                controller: emailController,
                obscureText: false,
                isEmail: true,
                style: const TextStyle(color: AppTheme.gray45),
                borderSide: const BorderSide(color: AppTheme.gray45),
                fillColor: Colors.transparent,
              ),
              onFocusChange: (hasFocus) {
                // if (context.read<LoginBloc>().state.isPasswordFocus) {
                //   context.read<LoginBloc>().add(FocusEmail());
                // }
                // (context.read<LoginBloc>().state.isEmailFocused)
                //     ? _height = 0
                //     : _height = 40;

                // context.read<LoginBloc>().add(RefreshScreen());
              },
            ),
            const SizedBox(height: 10),
            Focus(
              child: AuthPasswordTextField(
                controller: passwordController,
                hintText: 'password',
                enabled: !state.status.isLoading,
                borderSide: const BorderSide(color: AppTheme.gray45),
                style: const TextStyle(color: AppTheme.gray45),
                fillColor: Colors.transparent,
                iconColor: AppTheme.gray45,
              ),
              onFocusChange: (hasFocus) {
                if (context.read<LoginBloc>().state.isEmailFocused) {
                  context.read<LoginBloc>().add(FocusPassword());
                }
                (context.read<LoginBloc>().state.isPasswordFocus)
                    ? _height = 0
                    : _height = 40;
                // context.read<LoginBloc>().add(RefreshScreen());
              },
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        (state.status.isLoading)
            ? const CupertinoActivityIndicator(
                color: AppTheme.gray45,
                radius: 20,
              )
            : WideButton(
                name: 'Login',
                onPressed: () => _onPressed(context),
                bgColor: AppTheme.gray45,
                textStyle: const TextStyle(color: Colors.black54, fontSize: 18),
              ),
        const SizedBox(
          height: 10,
        ),
        if (state.email != null &&
            state.email!.isNotEmpty &&
            state.status.isChangeUser)
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppTheme.gray45),
            ),
            onPressed: () {
              context.read<LoginBloc>().add(SignInUser());
            },
            child: Text(
              'Back to ${currentUsername ?? "user"}',
              style: const TextStyle(color: AppTheme.gray45, fontSize: 18),
            ),
          ),
        const SizedBox(
          height: 10,
        ),
        if (kDebugMode)
          TextButton(
            onPressed: () {
              context.read<LoginBloc>().add(ForgotPassword());
            },
            child: const Text(
              'Forgot password?',
              style: TextStyle(
                color: AppTheme.whiteColor,
              ),
            ),
          ),
      ],
    );
  }

  _onPressed(BuildContext context) {
    if (emailController.text.isNotEmpty) {
      if (EmailValidator.validate(emailController.text.trim())) {
        if (passwordController.text.isNotEmpty) {
          context.read<LoginBloc>().add(
                AuthenticateUser(
                  emailController.text,
                  passwordController.text,
                ),
              );
        } else {
          Fluttertoast.showToast(
              msg: "No Password provided",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: AppTheme.red,
              textColor: AppTheme.whiteColor,
              fontSize: 16.0);
          context.read<LoginBloc>().add(FocusPassword());
        }
      } else {
        Fluttertoast.showToast(
            msg: "Email not valid",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: AppTheme.red,
            textColor: AppTheme.whiteColor,
            fontSize: 16.0);
        // context.read<LoginBloc>().add(FocusEmail());
      }
    } else {
      Fluttertoast.showToast(
          msg: "No email provided",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: AppTheme.red,
          textColor: AppTheme.whiteColor,
          fontSize: 16.0);
      // context.read<LoginBloc>().add(FocusEmail());
    }
  }

  _signUserIn(BuildContext context) async {
    final box = GetSecureStorage(
        password: 'infosec_technologies_ug_smart_rent_relator_manager');

    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.popUntil(context, (route) => false);
    Navigator.pushNamed(context, '/root');

    box.write('email', emailController.text.trim());
    box.write('name', currentUser.firstName);
    box.write('image', currentUser.avatar);

    context.read<ProfilePicBloc>().add(GetProfilePic());
  }
}
