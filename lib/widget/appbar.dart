import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sence_sence/shared/theme.dart';

Column buildAppBar(BuildContext context, String title) {
  return Column(
    children: [
      SizedBox(height: 36.h,),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                "asset/images/arrow-left-ic.png",
                width: 35.w,
                height: 35.h,
              ),
            ),
            Text(title, style: appBarTitle,),
            SizedBox(
              width: 35.w,
              height: 35.h,
            ),
          ],
        ),
      ),
    ],
  );
}