import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oh_dog_app/common/components/app_loader.dart';
import 'package:oh_dog_app/common/components/empty_state.dart';
import 'package:oh_dog_app/common/components/general/breedlist_button.dart';
import 'package:oh_dog_app/common/components/general/spacing.dart';
import 'package:oh_dog_app/common/constant/size_constant.dart';
import 'package:oh_dog_app/common/constant/util.dart';
import 'package:oh_dog_app/common/themes/app_colors.dart';
import 'package:oh_dog_app/data/enums/view_state.dart';
import 'package:oh_dog_app/providers/dog_provider.dart';
import 'package:provider/provider.dart';

class BreedBottomSheet extends StatefulWidget {
  final Function onBreedSelected;

  BreedBottomSheet({required this.onBreedSelected});
  @override
  _BreedBottomSheetState createState() => _BreedBottomSheetState();
}

class _BreedBottomSheetState extends State<BreedBottomSheet> {
  DogProvider? _dogProvider;

  initState() {
    super.initState();
    _dogProvider = Provider.of<DogProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) => {
          fetchDogBreedsList(),
        });
  }

  fetchDogBreedsList() async {
    await _dogProvider!.fetchDogBreeds();
  }

  Widget _maincontent() {
    return Consumer<DogProvider>(builder: (context, model, _) {
      if (model.dogbreedListViewState == ViewState.busy) {
        return const Center(
            child: Loader(
          color: AppColors.primaryYellow,
          text: "Fetching dog breeds...",
        ));
      }
      if (model.dogbreedListViewState == ViewState.error) {
        return const Center(
            child: Loader(
          color: AppColors.primaryYellow,
          text: "Error fetching dog breeds...",
        ));
      }
      if (model.dogbreedListViewState == ViewState.completed &&
          model.dogbreedList!.message!.isEmpty) {
        return EmptyState(message: "No dog breeds found");
      }
      if (model.dogbreedListViewState == ViewState.completed &&
          model.dogbreedList!.message!.isNotEmpty) {
        return ListView.builder(
          itemCount: model.dogbreedList!.message!.length,
          itemBuilder: (context, index) {
            var breed = model.dogbreedList!.message![index];
            return Padding(
                padding: EdgeInsets.only(bottom: Sizes.dimen_10.r),
                child: BreedListButton(
                  title: breed,
                  onChanged: () {
                    widget.onBreedSelected(breed);
                    Navigator.pop(context);
                  },
                ));

            // Padding(
            //   padding: EdgeInsets.only(bottom: Sizes.dimen_10.r),
            //   child: GestureDetector(
            //     onTap: () {
            //       widget.onBreedSelected(breed);
            //       Navigator.pop(context);
            //     },
            //     child: Styles.medium(
            //       breed,
            //     ),
            //   ),
            // );
          },
        );
      }
      return const SizedBox.shrink();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(Sizes.dimen_10.r),
          topLeft: Radius.circular(Sizes.dimen_10.r)),
      child: Container(
        height: scaledHeight(context).h / 1.8.h,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.dimen_10.w, vertical: Sizes.dimen_20.h),
          child: Column(
            children: [
              VerticalSpacing(Sizes.dimen_10),
              Expanded(
                child: _maincontent(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
