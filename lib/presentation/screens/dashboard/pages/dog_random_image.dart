import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oh_dog_app/common/components/app_loader.dart';
import 'package:oh_dog_app/common/components/empty_state.dart';
import 'package:oh_dog_app/common/components/general/app_dropdown.dart';
import 'package:oh_dog_app/common/components/general/breeed_bottomsheet.dart';
import 'package:oh_dog_app/common/components/general/spacing.dart';
import 'package:oh_dog_app/common/components/general/sub_breed_bottomsheet.dart';
import 'package:oh_dog_app/common/constant/size_constant.dart';
import 'package:oh_dog_app/common/constant/text_constant.dart';
import 'package:oh_dog_app/common/constant/util.dart';
import 'package:oh_dog_app/common/themes/app_colors.dart';
import 'package:oh_dog_app/data/enums/view_state.dart';
import 'package:oh_dog_app/helpers/styles.dart';
import 'package:oh_dog_app/providers/dog_provider.dart';
import 'package:provider/provider.dart';

class DogRandomImage extends StatefulWidget {
  const DogRandomImage({super.key});

  @override
  State<DogRandomImage> createState() => _DogRandomImageState();
}

class _DogRandomImageState extends State<DogRandomImage> {
  String _selectedBreed = '';
//gets the value for the breed
  _onBreedSelected(breed) async {
    setState(() {
      _selectedBreed = breed;
    });
    await fetchDogRandomImageByBreed(breed);
  }

  String _selectedSubBreed = '';
//gets the value for the subB
//reed
  _onSubBreedSelected(subBreed) async {
    setState(() {
      _selectedSubBreed = subBreed;
    });
    await fetchDogRandomBreedImageBySubBreed(_selectedBreed, subBreed);
  }

  ScrollController _scrollController = ScrollController();

  DogProvider? _dogProvider;

  initState() {
    super.initState();
    _dogProvider = Provider.of<DogProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) => {
          fetchDogRandomImageByBreed(''),
        });
  }

  fetchDogRandomImageByBreed(String breed) async {
    await _dogProvider!.fetchDogRandomImageByBreed(breed);
    // Scroll to the bottom after updating data
    // _scrollController.animateTo(
    //   _scrollController.position.maxScrollExtent,
    //   duration: Duration(milliseconds: 100),
    //   curve: Curves.easeOut,
    // );
  }

  fetchDogRandomBreedImageBySubBreed(String breed, String subBreed) async {
    if (subBreed != '') {
      await _dogProvider!.fetchDogRandomBreedImageBySubBreed(breed, subBreed);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _maincontent() {
    return Consumer<DogProvider>(builder: (context, model, _) {
      if (model.dogRandomBreedImageViewState == ViewState.busy) {
        return const Center(
            child: Loader(
          color: AppColors.primaryYellow,
          text: "Fetching dog random breed image...",
        ));
      }
      if (model.dogRandomBreedImageViewState == ViewState.error) {
        return const Center(
            child: Loader(
          color: AppColors.primaryYellow,
          text: "Error fetching dog random breed image...",
        ));
      }
      if (model.dogRandomBreedImageViewState == ViewState.completed &&
          model.dogRandomBreedImage!.message == '') {
        return EmptyState(message: "No dog random breed image found");
      }
      if (model.dogRandomBreedImageViewState == ViewState.completed &&
          model.dogRandomBreedImage!.message != '') {
        return Container(
          height: 200.h,
          // width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              //color: AppColors.grey95,
              image: DecorationImage(
                image: NetworkImage(
                  model.dogRandomBreedImage!.message ?? '',
                ),
                fit: BoxFit.cover,
              )),
        );
      }
      return const SizedBox.shrink();
    });
  }

  Widget _mainSubcontent() {
    return Consumer<DogProvider>(builder: (context, model, _) {
      if (model.dogRandomBreedBySubBreedImageViewState == ViewState.busy) {
        return const Center(
            child: Loader(
          color: AppColors.primaryYellow,
          text: "Fetching dog random breed by subBreed image...",
        ));
      }
      if (model.dogRandomBreedBySubBreedImageViewState == ViewState.error) {
        return const Center(
            child: Loader(
          color: AppColors.primaryYellow,
          text: "Error fetching dog random breed by subBreed image...",
        ));
      }
      if (model.dogRandomBreedBySubBreedImageViewState == ViewState.completed &&
          model.dogRandomBreedBySubBreedImage!.message == '') {
        return EmptyState(message: "No dog random breed by subBreed found");
      }
      if (model.dogRandomBreedBySubBreedImageViewState == ViewState.completed &&
          model.dogRandomBreedBySubBreedImage!.message != '') {
        return Container(
          height: 200.h,
          // width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              //color: AppColors.grey95,
              image: DecorationImage(
                image: NetworkImage(
                  model.dogRandomBreedBySubBreedImage!.message ?? '',
                ),
                fit: BoxFit.cover,
              )),
        );
      }
      return const SizedBox.shrink();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          VerticalSpacing(20.h),

          Styles.medium(TextLiterals.breed,
              fontSize: scaledFontSize(12.sp, context),
              fontWeight: FWt.semiBold),
          VerticalSpacing(8.h),
          CustomDropdownButton(
              title: _selectedBreed == '' ? "select a breed" : _selectedBreed,
              selectedText:
                  _selectedBreed == '' ? "select a breed" : _selectedBreed,
              onChanged: () {
                showModalBottomSheet(
                    context: context,
                    elevation: 2.0,
                    isDismissible: false,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Sizes.dimen_10.r),
                          topLeft: Radius.circular(Sizes.dimen_10.r)),
                    ),
                    builder: (context) => BreedBottomSheet(
                          onBreedSelected: _onBreedSelected,
                        ));
              }),
          VerticalSpacing(20.h),
          Styles.medium(TextLiterals.subBreed,
              fontSize: scaledFontSize(12.sp, context),
              fontWeight: FWt.semiBold),
          VerticalSpacing(8.h),
          CustomDropdownButton(
              title: _selectedSubBreed == ''
                  ? "select a sub breed"
                  : _selectedSubBreed,
              selectedText: _selectedSubBreed == ''
                  ? "select a sub breed"
                  : _selectedSubBreed,
              onChanged: () {
                showModalBottomSheet(
                    context: context,
                    elevation: 2.0,
                    isDismissible: false,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Sizes.dimen_10.r),
                          topLeft: Radius.circular(Sizes.dimen_10.r)),
                    ),
                    builder: (context) => SubBreedBottomSheet(
                          breed: _selectedBreed,
                          onSubBreedSelected: _onSubBreedSelected,
                        ));
              }),

          VerticalSpacing(20.h),
          _selectedSubBreed == '' ? _maincontent() : _mainSubcontent()

          // )
        ],
      ),
    );
  }
}
