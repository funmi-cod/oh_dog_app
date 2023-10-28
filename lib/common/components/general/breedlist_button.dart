import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:iconsax/iconsax.dart';
import 'package:oh_dog_app/common/components/general/spacing.dart';
import 'package:oh_dog_app/common/constant/size_constant.dart';
import 'package:oh_dog_app/common/themes/app_colors.dart';
import 'package:oh_dog_app/helpers/styles.dart';

class BreedListButton extends StatelessWidget {
  final String title;
  final String? selectedTitle;
  final Function onChanged;
  const BreedListButton(
      {required this.title,
      required this.onChanged,
      this.selectedTitle,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.dimen_20.w, vertical: Sizes.dimen_10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.dimen_10.r),
          color: AppColors.lightGray,
        ),
        child: Row(
          children: [
            Icon(
              Iconsax.tick_square4,
              color: selectedTitle == title
                  ? AppColors.primaryYellow
                  : AppColors.mediumGray,
            ),
            HorizontalSpacing(Sizes.dimen_10.w),
            Styles.medium(title,
                color: selectedTitle == title
                    ? AppColors.black
                    : AppColors.mediumGray),
          ],
        ),
      ),
    );
  }
}
