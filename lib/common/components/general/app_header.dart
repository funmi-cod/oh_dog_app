import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oh_dog_app/common/components/general/spacing.dart';

import 'package:oh_dog_app/common/constant/util.dart';
import 'package:oh_dog_app/common/themes/app_colors.dart';
import 'package:oh_dog_app/helpers/styles.dart';

class AppHeader extends StatelessWidget {
  final Function()? onClick;
  final String title;
  const AppHeader({super.key, this.onClick, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.black,
            )),
        const Spacer(),
        Styles.medium(
          title,
          fontSize: scaledFontSize(16.sp, context),
        ),
        HorizontalSpacing(20.w),
        const Spacer(),
      ],
    );
  }
}
