import 'package:flutter/material.dart';
import 'package:solid_doggo_display_01/config/app_config.dart';
import 'package:solid_doggo_display_01/screens/dog_screen.dart';
import 'package:solid_doggo_display_01/services/dog_service/dog_service.dart';
import 'package:solid_doggo_display_01/utils/service_locator.dart';

void main() {
  setupServiceLocatior();

  const ciRun = bool.fromEnvironment('CI', defaultValue: false);

  AppConfig appCfg = ciRun ? IntegrationTestConfig() : DefaultConfig();

  runApp(MyApp(appCfg: appCfg));
}

//todo should we rename this class?
class MyApp extends StatelessWidget {
  final AppConfig appCfg;

  const MyApp({super.key, required this.appCfg});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog App',
      theme: ThemeData(
        //todo learn about themedata class, colorscheme class and usematerial3.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: DogScreen(dogService: DogService(baseApiUrl: appCfg.baseDogApiUrl)),
    );
  }
}
