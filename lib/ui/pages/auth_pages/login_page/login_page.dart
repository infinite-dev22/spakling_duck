import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/ui/pages/auth_pages/login_page/bloc/login_bloc.dart';
import 'package:smart_rent/ui/pages/auth_pages/login_page/widgets/login_footer_widget.dart';
import 'package:smart_rent/ui/pages/auth_pages/login_page/widgets/login_widget.dart';
import 'package:smart_rent/ui/pages/auth_pages/login_page/widgets/reset_password_widget.dart';
import 'package:smart_rent/ui/pages/auth_pages/login_page/widgets/sign_in_widget.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/custom_image.dart';
import 'package:smart_rent/ui/widgets/profile_pic_widget/bloc/profile_pic_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: BlocBuilder<ProfilePicBloc, ProfilePicState>(
        builder: (context, state) {
          return _buildBody(context);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(0, 0, 0, 1)
                                .withOpacity(0.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomImage(
                                "assets/images/title_bar_white.png",
                                trBackground: false,
                                isNetwork: false,
                                isElevated: false,
                                width: MediaQuery.of(context).size.width * .6,
                                imageFit: BoxFit.contain,
                                radius: 0,
                              ),
                              BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  if (state.status.isInitial) {
                                    context
                                        .read<LoginBloc>()
                                        .add(LoginInitial());
                                  }
                                  if (state.status.isLoginUser) {
                                    return LoginWidget();
                                  }
                                  if (state.status.isForgotPassword) {
                                    return ResetPasswordWidget();
                                  }
                                  if (state.status.isSignInUser) {
                                    return SignInWidget();
                                  }
                                  return LoginWidget();
                                },
                              ),
                              const SizedBox(height: 10),
                              const LoginFooterWidget(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
