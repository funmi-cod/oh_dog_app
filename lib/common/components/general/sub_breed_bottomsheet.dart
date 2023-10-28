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

class SubBreedBottomSheet extends StatefulWidget {
  final Function onSubBreedSelected;
  final String breed;

  SubBreedBottomSheet({required this.onSubBreedSelected, required this.breed});
  @override
  _SubBreedBottomSheetState createState() => _SubBreedBottomSheetState();
}

class _SubBreedBottomSheetState extends State<SubBreedBottomSheet> {
  DogProvider? _dogProvider;

  initState() {
    super.initState();
    _dogProvider = Provider.of<DogProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) => {
          fetchDogSubBreedsList(widget.breed),
        });
  }

  fetchDogSubBreedsList(String breed) async {
    await _dogProvider!.fetchDogSubBreeds(breed);
  }

  Widget _maincontent() {
    return Consumer<DogProvider>(builder: (context, model, _) {
      if (model.dogSubBreedsListViewState == ViewState.busy) {
        return const Center(
            child: Loader(
          color: AppColors.primaryYellow,
          text: "Fetching Subdog subBreeds...",
        ));
      }
      if (model.dogSubBreedsListViewState == ViewState.error) {
        return const Center(
            child: Loader(
          color: AppColors.primaryYellow,
          text: "Error fetching dog subBreeds...",
        ));
      }
      if (model.dogSubBreedsListViewState == ViewState.completed &&
          model.dogSubBreedsList!.message!.isEmpty) {
        return EmptyState(message: "No dog subBreeds found");
      }
      if (model.dogSubBreedsListViewState == ViewState.completed &&
          model.dogSubBreedsList!.message!.isNotEmpty) {
        return ListView.builder(
          itemCount: model.dogSubBreedsList!.message!.length,
          itemBuilder: (context, index) {
            var subBreed = model.dogSubBreedsList!.message![index];
            return Padding(
                padding: EdgeInsets.only(bottom: Sizes.dimen_10.r),
                child: BreedListButton(
                  title: subBreed,
                  onChanged: () {
                    widget.onSubBreedSelected(subBreed);
                    Navigator.pop(context);
                  },
                ));
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
