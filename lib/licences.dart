import 'package:flutter/material.dart';
import 'package:solid_doggo_display_01/config/app_config.dart';
import 'package:solid_doggo_display_01/screens/dog_screen.dart';
import 'package:solid_doggo_display_01/services/dog_service/dog_service.dart';
import 'package:solid_doggo_display_01/utils/service_locator.dart';

void main() {
  runApp(const MyAppLicences());
}

class MyAppLicences extends StatelessWidget {
  const MyAppLicences({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Licences',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const LicensePage(),
    );
  }
}
