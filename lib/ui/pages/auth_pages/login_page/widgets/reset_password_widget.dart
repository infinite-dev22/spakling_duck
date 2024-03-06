import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_rent/ui/pages/auth_pages/login_page/bloc/login_bloc.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/auth_textfield.dart';

class ResetPasswordWidget extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  ResetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          FocusManager.instance.primaryFocus?.unfocus();
          Fluttertoast.showToast(
              msg: "Reset password link sent on your email",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: AppTheme.green,
              textColor: AppTheme.whiteColor,
              fontSize: 16.0);
          context.read<LoginBloc>().add(LoginUser());
        }
        if (state.status.isError) {
          FocusManager.instance.primaryFocus?.unfocus();
          Fluttertoast.showToast(
              msg: "An error occurred",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: AppTheme.red,
              textColor: AppTheme.whiteColor,
              fontSize: 16.0);
        }
        if (state.status.isSuccess) {}
      },
      builder: (context, state) {
        return _buildBody(context, state);
      },
    );
  }

  Widget _buildBody(BuildContext context, LoginState state) {
    return Column(
      children: [
        const Text(
          'A Password reset link will be sent to the email entered below, '
          'click Proceed to continue',
          style: TextStyle(color: AppTheme.whiteColor, fontSize: 18),
        ),
        const SizedBox(height: 20),
        AuthTextField(
          controller: emailController,
          hintText: 'email',
          enabled: !state.status.isLoading,
          obscureText: false,
          isEmail: true,
          style: const TextStyle(color: AppTheme.whiteColor),
          borderSide: const BorderSide(color: AppTheme.whiteColor),
          fillColor: AppTheme.primary,
        ),
        const SizedBox(height: 10),
        _buildButtons(context, state),
      ],
    );
  }

  Widget _buildButtons(context, LoginState state) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => AppTheme.gray45),
            ),
            onPressed: () {
              context.read<LoginBloc>().add(LoginUser());
            },
            alignment: Alignment.center,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppTheme.primary,
              size: 30,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.gray45),
              ),
              onPressed: () => _onResetPressed(context),
              child: state.status.isLoading
                  ? const SizedBox(
                      height: 25,
                      width: 25,
                      child: CupertinoActivityIndicator(
                        color: AppTheme.gray45,
                      ),
                    )
                  : const Text(
                      'Proceed',
                      style: TextStyle(color: AppTheme.gray45, fontSize: 20),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  _onResetPressed(context) {
    if (EmailValidator.validate(emailController.text.trim())) {
      context.read<LoginBloc>().add(ResetPassword(emailController.text));
    } else {
      Fluttertoast.showToast(
          msg: "Email not valid",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: AppTheme.red,
          textColor: AppTheme.whiteColor,
          fontSize: 16.0);
    }
  }
}
