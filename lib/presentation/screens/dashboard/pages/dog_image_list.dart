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

class DogImageList extends StatefulWidget {
  const DogImageList({super.key});

  @override
  State<DogImageList> createState() => _DogImageListState();
}

class _DogImageListState extends State<DogImageList> {
  String _selectedBreed = '';
//gets the value for the breed
  _onBreedSelected(breed) async {
    setState(() {
      _selectedBreed = breed;
    });
    await fetchDogBreedImages(breed);
  }

  String _selectedSubBreed = '';
//gets the value for the subB
//reed
  _onSubBreedSelected(subBreed) async {
    setState(() {
      _selectedSubBreed = subBreed;
    });
    await fetchDogBreedBySubBreedImages(_selectedBreed, subBreed);
  }

  ScrollController _scrollController = ScrollController();

  DogProvider? _dogProvider;

  initState() {
    super.initState();
    _dogProvider = Provider.of<DogProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) => {
          Future.delayed(Duration.zero, () {
            fetchDogBreedImages('');
          }),
        });
  }

  fetchDogBreedImages(String breed) async {
    await _dogProvider!.fetchDogBreedImage(breed);
    // Scroll to the bottom after updating data
    // _scrollController.animateTo(
    //   _scrollController.position.maxScrollExtent,
    //   duration: Duration(milliseconds: 100),
    //   curve: Curves.easeOut,
    // );
  }

  fetchDogBreedBySubBreedImages(String breed, String subBreed) async {
    if (subBreed != '') {
      await _dogProvider!.fetchDogBreedbySubBreedImages(breed, subBreed);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _maincontent() {
    return Consumer<DogProvider>(builder: (context, model, _) {
      if (model.dogBreedImagesViewState == ViewState.busy) {
        return const Center(
            child: Loader(
          color: AppColors.primaryYellow,
          text: "Fetching dog breed images...",
        ));
      }
      if (model.dogBreedImagesViewState == ViewState.error) {
        return const Center(
            child: Loader(
          color: AppColors.primaryYellow,
          text: "Error fetching dog breeds...",
        ));
      }
      if (model.dogBreedImagesViewState == ViewState.completed &&
          model.dogBreedImages!.message!.isEmpty) {
        return EmptyState(message: "No dog breeds found");
      }
      if (model.dogBreedImagesViewState == ViewState.completed &&
          model.dogBreedImages!.message!.isNotEmpty) {
        return GridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          //controller: _scrollController,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.2,
          ),
          itemCount: model.dogBreedImages!.message!.length,
          itemBuilder: (BuildContext context, int index) {
            var breedImg = model.dogBreedImages!.message![index];
            return Column(
              children: [
                Container(
                  height: 160.h,
                  // width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      //color: AppColors.grey95,
                      image: DecorationImage(
                        image: NetworkImage(
                          breedImg,
                        ),
                        fit: BoxFit.cover,
                      )),
                )
              ],
            );
          },
        );
      }
      return const SizedBox.shrink();
    });
  }

  Widget _mainSubcontent() {
    return Consumer<DogProvider>(builder: (context, model, _) {
      if (model.dogBreedBySubBreedImagesViewState == ViewState.busy) {
        return const Center(
            child: Loader(
          color: AppColors.primaryYellow,
          text: "Fetching dog breed by subBreed images...",
        ));
      }
      if (model.dogBreedBySubBreedImagesViewState == ViewState.error) {
        return const Center(
            child: Loader(
          color: AppColors.primaryYellow,
          text: "Error fetching dog breeds by subBreed images...",
        ));
      }
      if (model.dogBreedBySubBreedImagesViewState == ViewState.completed &&
          model.dogBreedImages!.message!.isEmpty) {
        return EmptyState(message: "No dog breed by subBreed found");
      }
      if (model.dogBreedBySubBreedImagesViewState == ViewState.completed &&
          model.dogBreedBySubBreedImages!.message!.isNotEmpty) {
        return GridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          //controller: _scrollController,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.2,
          ),
          itemCount: model.dogBreedBySubBreedImages!.message!.length,
          itemBuilder: (BuildContext context, int index) {
            var breedBySubBreedImg =
                model.dogBreedBySubBreedImages!.message![index];
            return Column(
              children: [
                Container(
                  height: 160.h,
                  // width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      //color: AppColors.grey95,
                      image: DecorationImage(
                        image: NetworkImage(
                          breedBySubBreedImg,
                        ),
                        fit: BoxFit.cover,
                      )),
                )
              ],
            );
          },
        );
      }
      return const SizedBox.shrink();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
      ),
    );
  }
}
