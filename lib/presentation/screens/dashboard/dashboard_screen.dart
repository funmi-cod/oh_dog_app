import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oh_dog_app/common/components/general/app_header.dart';
import 'package:oh_dog_app/common/components/general/spacing.dart';
import 'package:oh_dog_app/common/constant/size_constant.dart';
import 'package:oh_dog_app/common/constant/text_constant.dart';
import 'package:oh_dog_app/common/constant/util.dart';
import 'package:oh_dog_app/common/themes/app_colors.dart';
import 'package:oh_dog_app/helpers/styles.dart';
import 'package:oh_dog_app/presentation/screens/dashboard/pages/dog_image_list.dart';
import 'package:oh_dog_app/presentation/screens/dashboard/pages/dog_random_image.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  int selectedIndex = 0;

  initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      Tab(
        child: Styles.regular(TextLiterals.imageLIst),
      ),
      Tab(
        child: Styles.regular(TextLiterals.randomImage,
            color: selectedIndex == 1 ? AppColors.white : AppColors.black),
      ),
    ];
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(
              left: Sizes.dimen_15.w,
              right: Sizes.dimen_15.w,
              top: Sizes.dimen_20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              VerticalSpacing(20.h),
              AppHeader(
                title: TextLiterals.appName,
                onClick: () {},
              ),
              VerticalSpacing(20.h),
              Styles.medium(TextLiterals.searchBreed,
                  fontSize: scaledFontSize(18.sp, context)),
              VerticalSpacing(10.h),
              Styles.medium(TextLiterals.filterByBreed,
                  fontSize: scaledFontSize(14.sp, context)),
              VerticalSpacing(20.h),
              Container(
                height: 40.h,
                width: scaledWidth(context).w,
                decoration: BoxDecoration(
                  color: AppColors.grey95.withOpacity(.13),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TabBar(
                  splashBorderRadius: BorderRadius.circular(10.r),
                  onTap: (int value) {
                    setState(() {
                      selectedIndex = value;
                    });

                    return;
                  },
                  unselectedLabelColor: AppColors.transparentBlack,
                  labelStyle: TextStyle(
                      fontSize: scaledFontSize(14.sp, context),
                      color: AppColors.transparentBlack,
                      fontWeight: FontWeight.w400),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: selectedIndex == 1
                          ? AppColors.black
                          : AppColors.primaryYellow),
                  labelColor:
                      selectedIndex == 1 ? AppColors.white : AppColors.black,
                  automaticIndicatorColorAdjustment: true,
                  controller: _controller,
                  tabs: list,
                ),
              ),
              VerticalSpacing(20.h),
              Expanded(child: buildTripTabs(context))

              // )
            ],
          )),
    );
  }

  Widget buildTripTabs(BuildContext context) {
    return TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: const [
          DogImageList(),
          DogRandomImage()
          // Container(
          //   height: 100,
          //   color: AppColors.black,
          // ),
          // Container(
          //   height: 100,
          //   color: AppColors.blue,
          // ),
        ]);
  }
}
