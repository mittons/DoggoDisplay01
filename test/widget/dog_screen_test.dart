import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solid_doggo_display_01/models/dog_service/dog_breed.dart';
import 'package:solid_doggo_display_01/screens/dog_screen.dart';
import 'package:solid_doggo_display_01/services/service_result.dart';

import '../mock/mock_dog_service.dart';

void main() {
  group("Dog Screen Widget", () {
    //
    testWidgets('contains all expected elements on initialization',
        (widgetTester) async {
      MockDogService mockDogService = MockDogService();

      await widgetTester
          .pumpWidget(MaterialApp(home: DogScreen(dogService: mockDogService)));
      await widgetTester.pumpAndSettle();

      expect(find.widgetWithText(ElevatedButton, "Get dog breeds"),
          findsOneWidget);
    });

    testWidgets('displays dog breed list on successful service request',
        (widgetTester) async {
      // ------------------------------------------
      // | Set up initial state
      // ------------------------------------------

      // Set up mock service
      MockDogService mockDogService = MockDogService();

      // Init screen
      await widgetTester
          .pumpWidget(MaterialApp(home: DogScreen(dogService: mockDogService)));
      await widgetTester.pumpAndSettle();

      // ------------------------------------------
      // | Set up and perform state change test
      // ------------------------------------------

      // Get a copy of the data that should be added to state
      List<DogBreed> dogBreeds = (await mockDogService.getDogBreeds()).data!;

      // Verify data that should be displayed AFTER button click is not on screen
      for (DogBreed dogBreed in dogBreeds) {
        expect(find.widgetWithText(ListTile, dogBreed.name), findsNothing);
      }

      // Click button to fetch list of dog breeds
      await widgetTester
          .tap(find.widgetWithText(ElevatedButton, "Get dog breeds"));
      await widgetTester.pumpAndSettle();

      // Verify data that should be displayed AFTER button click is on screen
      for (DogBreed dogBreed in dogBreeds) {
        expect(find.widgetWithText(ListTile, dogBreed.name), findsOneWidget);
      }
    });

    testWidgets('displays snackbar on unsuccessful service request',
        (widgetTester) async {
      // Set up mock service
      MockDogService mockDogService = MockDogService();

      // Hijack mock service to return unsuccessful result no matter
      mockDogService.onGetDogBreeds = (res) {
        return ServiceResult<List<DogBreed>?>(data: null, success: false);
      };

      // Init screen
      await widgetTester
          .pumpWidget(MaterialApp(home: DogScreen(dogService: mockDogService)));
      await widgetTester.pumpAndSettle();

      // Verify snack bar is not being displayed
      expect(find.byType(SnackBar), findsNothing);

      // Click button to fetch list of dog breeds
      await widgetTester
          .tap(find.widgetWithText(ElevatedButton, "Get dog breeds"));
      await widgetTester.pumpAndSettle();

      // Verify snackbar is being displayed (as a result of unsuccessful service call
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
