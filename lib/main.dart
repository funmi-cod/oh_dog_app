import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:oh_dog_app/common/constant/page_route.dart';
import 'package:oh_dog_app/common/constant/text_constant.dart';
import 'package:oh_dog_app/common/constant/util.dart';
import 'package:oh_dog_app/env/environment.dart';
import 'package:oh_dog_app/presentation/screens/into_screen.dart';
import 'package:oh_dog_app/providers/multi_provider.dart';
import 'package:provider/provider.dart';

import 'presentation/screens/base_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const String environment =
      String.fromEnvironment("ENVIRONMENT", defaultValue: Environment.PROD);

  Environment().initConfig(environment);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(logicalWidth(), logicalHeight()),
      builder: (context, Widget? child) =>
          StreamProvider<InternetConnectionStatus>(
        initialData: InternetConnectionStatus.connected,
        create: (_) {
          return InternetConnectionChecker().onStatusChange;
        },
        child: MaterialApp(
          builder: (context, child) {
            final MediaQueryData data = MediaQuery.of(context);
            return MultiProvider(
              providers: allProviders,
              child: MediaQuery(
                data: data.copyWith(
                  textScaleFactor: 1,
                ),
                child: BaseWidget(
                  child: child!,
                ),
              ),
            );
          },
          title: TextLiterals.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.yellow,
            fontFamily: 'SofiaSans',
          ),
          onGenerateRoute: AppRouter.generateRoute,
          home: const IntroScreen(),
          //HomeView(),
        ),
      ),
    );
  }
}
