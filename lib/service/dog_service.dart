import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oh_dog_app/common/core/api_constant.dart';
import 'package:oh_dog_app/common/core/req_client.dart';
import 'package:oh_dog_app/data/models/dog_breed.dart';
import 'package:oh_dog_app/data/models/dog_random_img.dart';
import 'package:oh_dog_app/env/environment.dart';
import 'package:oh_dog_app/helpers/utilities.dart';

class DogService {
  var dio = Dio();
  ReqClient requestClient = ReqClient();
  DogBreed? breeds;
  DogBreed? breedImages;
  DogBreed? subBreedList;
  DogBreed? breedBySubBreedImages;

  // Randm image By Breed
  DogRandomImg? dogRandomBreedImg;
  // Randm image By Breed and SubBreed
  DogRandomImg? dogRandomBreedBySubBreedImg;

  Future<DogBreed?> fetchDogBreeds() async {
    Response response;
    try {
      response = await requestClient.getWithoutHeaderClient(
          '${Environment().config.BASE_URL}/${APIConstants.DOGBREED}/list');
      debugPrint("Breed data===");
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Breed data......");
        debugPrint("Breed data..${json.encode(response.data)}");

        DogBreed dogBreed = DogBreed.fromJson(response.data);
        breeds = DogBreed(message: []);
        debugPrint("Breed datatype: ${dogBreed.message}");
        if (dogBreed.message != null && dogBreed.message!.isNotEmpty) {
          for (var item in dogBreed.message!) {
            breeds?.message?.add(item);
          }
        }

        return breeds;
      } else {
        throw Exception('Failed to load dog breeds');
      }
    } on DioError catch (e) {
      debugPrint("Error: $e");
      Utilities.handleDioError(e);
      throw Exception('Network error occurred: $e');
    }
  }

  Future<DogBreed?> fetchDogImagesByBreed(String? breed) async {
    try {
      Response response;

      if (breed != null && breed != '') {
        response = await requestClient.getWithoutHeaderClient(
            '${Environment().config.BASE_URL}/${APIConstants.BREEDIMAGES}/$breed/images');
      } else {
        response = await requestClient.getWithoutHeaderClient(
            '${Environment().config.BASE_URL}/${APIConstants.BREEDIMAGES}/hound/images');
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Dog data: ${response.data}");

        DogBreed dogBreed = DogBreed.fromJson(response.data);
        breedImages = DogBreed(message: []);
        debugPrint("Breed datatype: ${dogBreed.message}");
        if (dogBreed.message != null && dogBreed.message!.isNotEmpty) {
          for (var item in dogBreed.message!) {
            breedImages?.message?.add(item);
          }
        }

        return breedImages;
      } else {
        throw Exception('Failed to load dog breed images');
      }
    } on DioError catch (e) {
      debugPrint("Error: $e");
      Utilities.handleDioError(e);
      throw Exception('Network error occurred: $e');
    }
  }

  Future<DogBreed?> fetchDogSubBreeds(String? breed) async {
    Response response;
    try {
      if (breed != null && breed != '') {
        response = await requestClient.getWithoutHeaderClient(
            '${Environment().config.BASE_URL}/${APIConstants.BREEDIMAGES}/$breed/list');
        debugPrint("Breed data===");
      } else {
        response = await requestClient.getWithoutHeaderClient(
            '${Environment().config.BASE_URL}/${APIConstants.BREEDIMAGES}/hound/list');
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("subBreed data......");

        var data = json.encode(response.data);

        debugPrint("subBreed data: $data");

        DogBreed dogBreed = DogBreed.fromJson(response.data);
        subBreedList = DogBreed(message: []);
        debugPrint("subBreed datatype: ${dogBreed.message}");
        if (dogBreed.message != null && dogBreed.message!.isNotEmpty) {
          for (var item in dogBreed.message!) {
            subBreedList?.message?.add(item);
          }
        }

        return subBreedList;
      } else {
        throw Exception('Failed to load dog subbreeds');
      }
    } on DioError catch (e) {
      debugPrint("Error: $e");
      Utilities.handleDioError(e);
      throw Exception('Network error occurred: $e');
    }
  }

  Future<DogBreed?> fetchDogBreedBySubBreedImages(
      String? breed, String? subBreed) async {
    try {
      Response response;
      debugPrint("Dog Breed $breed And SubBreed: $subBreed");
      if (breed != null && breed != '') {
        if (subBreed != null && subBreed != '') {
          debugPrint(
              "[[]]${Environment().config.BASE_URL}/${APIConstants.BREEDIMAGES}/$breed/$subBreed/images");
          response = await requestClient.getWithoutHeaderClient(
              '${Environment().config.BASE_URL}/${APIConstants.BREEDIMAGES}/$breed/$subBreed/images');

          if (response.statusCode == 200 || response.statusCode == 201) {
            debugPrint("Dog data By Breed And SubBreed: ${response.data}");

            DogBreed dogBreed = DogBreed.fromJson(response.data);
            breedBySubBreedImages = DogBreed(message: []);
            debugPrint(
                "Breed datatype By Breed And SubBreed: ${dogBreed.message}");
            if (dogBreed.message != null && dogBreed.message!.isNotEmpty) {
              for (var item in dogBreed.message!) {
                breedBySubBreedImages?.message?.add(item);
              }
            }
          }
        }
        return breedBySubBreedImages;
      } else {
        throw Exception('Failed to load dog Images By Breed And SubBreed');
      }
    } on DioError catch (e) {
      debugPrint("Error: $e");
      Utilities.handleDioError(e);
      throw Exception('Network error occurred: $e');
    }
  }

  Future<DogRandomImg?> fetchDogRandomImageByBreed(String? breed) async {
    try {
      Response response;
      debugPrint("Random Dog Breed $breed");

      if (breed != null && breed != '') {
        response = await requestClient.getWithoutHeaderClient(
            '${Environment().config.BASE_URL}/${APIConstants.BREEDIMAGES}/$breed/images/random');
        debugPrint("Random Breed data===");
      } else {
        response = await requestClient.getWithoutHeaderClient(
            '${Environment().config.BASE_URL}/${APIConstants.BREEDIMAGES}/hound/images/random');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Dog Random data By Breed : ${response.data}");

        DogRandomImg dogRandomBreed = DogRandomImg.fromJson(response.data);
        dogRandomBreedImg = DogRandomImg(message: '');

        if (dogRandomBreed.message != null &&
            dogRandomBreed.message!.isNotEmpty) {
          dogRandomBreedImg = DogRandomImg(message: dogRandomBreed.message);
        }
        return dogRandomBreedImg;
      } else {
        throw Exception('Failed to load dog random Image by breed');
      }
    } on DioError catch (e) {
      debugPrint("Error: $e");
      Utilities.handleDioError(e);
      throw Exception('Network error occurred: $e');
    }
  }

  Future<DogRandomImg?> fetchDogRandomBreedImageBySubBreed(
      String? breed, String? subBreed) async {
    try {
      Response response;
      debugPrint("Random Dog Breed $breed and subBreed $subBreed");

      if (breed != null && breed != '') {
        if (subBreed != null && subBreed != '') {
          response = await requestClient.getWithoutHeaderClient(
              '${Environment().config.BASE_URL}/${APIConstants.BREEDIMAGES}/$breed/$subBreed/images/random');
          debugPrint("Random Breed data===");
          if (response.statusCode == 200 || response.statusCode == 201) {
            debugPrint(
                "Dog Random data By Breed and subBreed : ${response.data}");

            DogRandomImg dogRandomBreedBySubBreedImage =
                DogRandomImg.fromJson(response.data);
            dogRandomBreedBySubBreedImg = DogRandomImg(message: '');

            if (dogRandomBreedBySubBreedImage.message != null &&
                dogRandomBreedBySubBreedImage.message!.isNotEmpty) {
              dogRandomBreedBySubBreedImg =
                  DogRandomImg(message: dogRandomBreedBySubBreedImage.message);
            }
          }
        }
        return dogRandomBreedBySubBreedImg;
      } else {
        throw Exception(
            'Failed to load dog random Image by breed and subBreed');
      }
    } on DioError catch (e) {
      debugPrint("Error: $e");
      Utilities.handleDioError(e);
      throw Exception('Network error occurred: $e');
    }
  }
}
