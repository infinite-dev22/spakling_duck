import 'package:flutter/material.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';

class UserCardWidget extends StatelessWidget {
  const UserCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      // width: width,
      // height: height,
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: .1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        tileColor: AppTheme.itemBgColor,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://img.freepik.com/free-photo/close-up-handsome-cheerful-tan-skinned-man-with-afro-hairstyle-casual-checkered-shirt-smiling-brightly-pointing-aside-with-index-finger-o-white-wall-copy-space_176420-11125.jpg?w=996&t=st=1709647284~exp=1709647884~hmac=c0bec24a033123bf9c03c27b97f91b714095142259274aadb69846984e719277'),
        ),
        title: Text('User Name'),
        subtitle: Text('description'),
      ),
    );
  }
}
