import 'package:oh_dog_app/providers/dog_provider.dart';
import 'package:provider/provider.dart';

final allProviders = [
  ChangeNotifierProvider<DogProvider>(
    create: (_) => DogProvider(),
  ),
];
