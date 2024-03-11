import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';


class AppButton extends StatelessWidget {
  final Widget? loader;
  final String title;
  final Color color;
  final Color? loaderColor;
  final TextStyle? textStyle;
  final VoidCallback function;
  final bool? isLoading;
  final double? width;

  const AppButton(
      {Key? key,
      this.loader,
      required this.title,
      required this.color,
      required this.function,
      this.loaderColor,
      this.isLoading = false,
      this.width,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
          width: width ?? 90.w,
          height: 6.5.h,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(15.sp)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // loader ?? Container(),
              isLoading == true
                  ? Container(
                      height: 4.h,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  //     ?  SpinKitFadingCircle(
                  //   color: loaderColor ?? Colors.white,
                  //   size: 20.sp,
                  // )
                  : Center(
                      child: width == null
                          ? Text(
                              title,
                              style: textStyle ?? AppTheme.buttonText,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )
                          : Container(
                              color: Colors.transparent,
                              width: width,
                              child: Text(
                                title,
                                style: textStyle ?? AppTheme.buttonText,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                    ),
            ],
          )),
    );
  }
}
