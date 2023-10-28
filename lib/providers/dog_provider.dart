import 'package:flutter/material.dart';
import 'package:oh_dog_app/data/enums/view_state.dart';
import 'package:oh_dog_app/data/models/dog_breed.dart';
import 'package:oh_dog_app/data/models/dog_random_img.dart';
import 'package:oh_dog_app/service/dog_service.dart';

class DogProvider with ChangeNotifier {
  DogService _dogService = DogService();
  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  DogBreed? _dogbreedList;
  DogBreed? get dogbreedList => _dogbreedList;

  ViewState _dogbreedListViewState = ViewState.idle;
  ViewState get dogbreedListViewState => _dogbreedListViewState;
  setDogbreedListViewState(ViewState viewState) {
    _dogbreedListViewState = viewState;
    notifyListeners();
  }

  DogBreed? _dogBreedImages;
  DogBreed? get dogBreedImages => _dogBreedImages;

  ViewState _dogBreedImagesViewState = ViewState.idle;
  ViewState get dogBreedImagesViewState => _dogBreedImagesViewState;
  setdogBreedImagesViewState(ViewState viewState) {
    _dogBreedImagesViewState = viewState;
    notifyListeners();
  }

  DogBreed? _dogSubBreedsList;
  DogBreed? get dogSubBreedsList => _dogSubBreedsList;

  ViewState _dogSubBreedsListViewState = ViewState.idle;
  ViewState get dogSubBreedsListViewState => _dogSubBreedsListViewState;
  setDogSubBreedsListViewState(ViewState viewState) {
    _dogSubBreedsListViewState = viewState;
    notifyListeners();
  }

  DogBreed? _dogBreedBySubBreedImages;
  DogBreed? get dogBreedBySubBreedImages => _dogBreedBySubBreedImages;

  ViewState _dogBreedBySubBreedImagesViewState = ViewState.idle;
  ViewState get dogBreedBySubBreedImagesViewState =>
      _dogBreedBySubBreedImagesViewState;
  setdogBreedBySubBreedImagesViewState(ViewState viewState) {
    _dogBreedBySubBreedImagesViewState = viewState;
    notifyListeners();
  }

  DogRandomImg? _dogRandomBreedImage;
  DogRandomImg? get dogRandomBreedImage => _dogRandomBreedImage;

  ViewState _dogRandomBreedImageViewState = ViewState.idle;
  ViewState get dogRandomBreedImageViewState => _dogRandomBreedImageViewState;
  setDogRandomBreedImageViewState(ViewState viewState) {
    _dogRandomBreedImageViewState = viewState;
    notifyListeners();
  }

  DogRandomImg? _dogRandomBreedBySubBreedImage;
  DogRandomImg? get dogRandomBreedBySubBreedImage =>
      _dogRandomBreedBySubBreedImage;

  ViewState _dogRandomBreedBySubBreedImageViewState = ViewState.idle;
  ViewState get dogRandomBreedBySubBreedImageViewState =>
      _dogRandomBreedBySubBreedImageViewState;
  setDogRandomBreedBySubBreedImageViewState(ViewState viewState) {
    _dogRandomBreedBySubBreedImageViewState = viewState;
    notifyListeners();
  }

  Future<Null> fetchDogBreeds() async {
    setDogbreedListViewState(ViewState.busy);
    debugPrint("breeedss=====");
    try {
      _dogbreedList = await _dogService.fetchDogBreeds();
      debugPrint("breeedss====complete=");
      setDogbreedListViewState(ViewState.completed);
    } catch (e) {
      setDogbreedListViewState(ViewState.error);
      debugPrint('Error: provider doggggg $e');
    }
  }

  Future<Null> fetchDogBreedImage(String breed) async {
    setdogBreedImagesViewState(ViewState.busy);
    debugPrint("breeed Imageeee=====");
    try {
      _dogBreedImages = await _dogService.fetchDogImagesByBreed(breed);
      debugPrint("breeedss=Immmmmm");
      setdogBreedImagesViewState(ViewState.completed);
    } catch (e) {
      setdogBreedImagesViewState(ViewState.error);
      debugPrint('Error: provider imggg doggggg $e');
    }
  }

  Future<Null> fetchDogSubBreeds(String breed) async {
    setDogSubBreedsListViewState(ViewState.busy);
    debugPrint("SubBreeedss=====");
    try {
      _dogSubBreedsList = await _dogService.fetchDogSubBreeds(breed);
      debugPrint("SubBreeedss====complete=");
      setDogSubBreedsListViewState(ViewState.completed);
    } catch (e) {
      setDogSubBreedsListViewState(ViewState.error);
      debugPrint('Error: provider doggggg $e');
    }
  }

  Future<Null> fetchDogBreedbySubBreedImages(
      String breed, String subBreed) async {
    setdogBreedBySubBreedImagesViewState(ViewState.busy);
    debugPrint("breedbySubBreed Imagess=====");
    try {
      _dogBreedBySubBreedImages =
          await _dogService.fetchDogBreedBySubBreedImages(breed, subBreed);
      debugPrint("breeedss=Immmmmm");
      setdogBreedBySubBreedImagesViewState(ViewState.completed);
    } catch (e) {
      setdogBreedBySubBreedImagesViewState(ViewState.error);
      debugPrint('Error: breedbySubBreed doggggg $e');
    }
  }

  Future<Null> fetchDogRandomImageByBreed(String breed) async {
    setDogRandomBreedImageViewState(ViewState.busy);
    debugPrint("Random breeed Image=====");
    try {
      _dogRandomBreedImage =
          await _dogService.fetchDogRandomImageByBreed(breed);
      debugPrint("Random breeed =Imgggg");
      setDogRandomBreedImageViewState(ViewState.completed);
    } catch (e) {
      setDogRandomBreedImageViewState(ViewState.error);
      debugPrint('Error: Random breed imggg doggggg $e');
    }
  }

  Future<Null> fetchDogRandomBreedImageBySubBreed(
      String breed, String subBreed) async {
    setDogRandomBreedBySubBreedImageViewState(ViewState.busy);
    debugPrint("Random breeed by subBreed Image=====");
    try {
      _dogRandomBreedBySubBreedImage =
          await _dogService.fetchDogRandomBreedImageBySubBreed(breed, subBreed);
      debugPrint("Random breeed by subBreed  =Imgggg");
      setDogRandomBreedBySubBreedImageViewState(ViewState.completed);
    } catch (e) {
      setDogRandomBreedBySubBreedImageViewState(ViewState.error);
      debugPrint('Error: Random breed by subBreed  imggg doggggg $e');
    }
  }
}
