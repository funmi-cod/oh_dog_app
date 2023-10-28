# oh_dog_app

A Flutter project that displays dog images based on a filter (Breed, Sub breed).

## Getting Started

[This project uses Dog APis from] (https://dog.ceo/dog-api/documentation).
The following are the app features:
 - Displaying Image List by breed: This app allows you to select a breed from a list of breeds and returns an image list of the selected breed.
 - Displaying Image List by breed and subbreed: This app allows you to select a breed from a list of breeds, a subbreed of the selected breed, and then returns an image list of the selected subbreed.
 - Displaying Random image by breed: This app allows you to select a breed from a list of breeds and returns a random image of the selected breed.
 - Displaying Random image by breed and subbreed: This app allows you to select a breed from a list of breeds, a subbreed of the selected breed, and returns a random image of the selected subbreed.
   
## Note: Some Breed do not have subbreeds

## Dependencies used:
 - dio: ^4.0.4  A powerful HTTP client for Dart and Flutter applications. It's used for making HTTP requests and handling responses. 
 - google_fonts: ^2.1.0  It's a library for using custom fonts in Flutter applications.
 - provider: ^6.0.2  It's used to manage state in Flutter applications.
 - flutter_screenutil: ^5.7.0 It's a Flutter package that helps adapt apps to different screen sizes and resolutions. It allows one to define dimensions and positions in a screen-independent manner
 - internet_connection_checker: ^1.0.0+1 It's a Dart package that provides a simple and easy way to check internet connectivity in a Flutter application.
 - iconsax: ^0.0.8 It is a collection of icons for Flutter applications. It provides a set of beautifully crafted icons that one can use in Flutter projects.

## App Preview

# Intro Screen

![IMG_6944](https://github.com/funmi-cod/oh_dog_app/assets/62282706/8ca8c5e5-b789-479c-8041-8338887f58dd)

# Dashboard Screen
- Use the tab button to get a list of dog images or a random dog image
- This screenshot shows a list of *airedale* dog breed
  
  ![IMG_6950](https://github.com/funmi-cod/oh_dog_app/assets/62282706/17f45cf4-c6cf-4b0d-b89d-3ae7d099f751)


- This screenshot shows a list of *english* subbreed of *hound* dog breed
  
  ![IMG_6951](https://github.com/funmi-cod/oh_dog_app/assets/62282706/5270d5a2-0f14-49b2-874e-e718339b9bfd)

- This screenshot shows a random image of *basset* subbreed of *hound* dog breed
  
  ![IMG_6948](https://github.com/funmi-cod/oh_dog_app/assets/62282706/e1683a4d-cdc0-4eb3-9953-7edf3087efa5)

- This screenshot shows that *african* dog breed does not have a subbreed from the Dog API
  
  ![IMG_6946](https://github.com/funmi-cod/oh_dog_app/assets/62282706/ab5fb2b5-468f-42ad-b7e6-6652e3905321)





A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
