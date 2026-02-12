import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String? content;
  final Widget? leftButton;
  final Widget rightButton;

  const CustomAlertDialog({
    super.key,
    required this.title,
    this.content,
    this.leftButton,
    required this.rightButton,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (content != null) ...[
              SizedBox(height: 12.h),
              Text(
                content!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ],
            SizedBox(height: 24.h),
            if (leftButton != null)
              Row(
                children: [
                  Expanded(child: leftButton!),
                  SizedBox(width: 8.w),
                  Expanded(child: rightButton),
                ],
              )
            else
              rightButton,
          ],
        ),
      ),
    );
  }
}
