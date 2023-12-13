import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:solid_doggo_display_01/main.dart' as app;

// ---------------------------------------------------------------------------
// | For integration testing flutter should be run with --dart-define=CI=true
// | - Otherwise we are integration testing against the production web api
// |   - (Atleast if we are using main() from main.dart)
// ---------------------------------------------------------------------------

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const ciRun = bool.fromEnvironment('CI', defaultValue: false);

  group("Run app", () {
    //
    testWidgets('and simulate dog screen user flow', (widgetTester) async {
      // Start the app by running main()
      app.main();
      await widgetTester.pumpAndSettle();

      // -------------------------------------------------------
      // | Expect to find all initial state screen elements
      // -------------------------------------------------------

      expect(find.widgetWithText(ElevatedButton, "Get dog breeds"),
          findsOneWidget);

      // -------------------------------------------------------
      // | Click "Get dog breeds" and expect a dog breed list..
      // |   to be displayed
      // -------------------------------------------------------

      // Expect no [ListTile]s on the screen before the button is pressed
      expect(find.byType(ListTile), findsNothing);

      // Click button to fetch list of dog breeds
      await widgetTester
          .tap(find.widgetWithText(ElevatedButton, "Get dog breeds"));
      await widgetTester.pumpAndSettle();

      // If the test is being run using services outside the local environment then:
      // - Give the external services a few seconds to reply.
      if (!ciRun) {
        await Future.delayed(const Duration(seconds: 5));
      }

      // Expect to find [ListTile]s on the screen after pressing the button
      expect(find.byType(ListTile), findsAtLeastNWidgets(1));

      // If the CI flag is set then the app should be fetching data from a..
      // mock api on the localhost. (See lib/app_config.dart for port)
      // In that case we can assume we know the test data.
      // We test under the assumption that the mock api is
      // - the docker image mockdogapi01:1.0
      if (ciRun) {
        for (String dogBreed in [
          "Affenpinscher",
          "Afghan Hound",
          "African Hunting Dog"
        ]) {
          expect(find.widgetWithText(ListTile, dogBreed), findsOneWidget);
        }
      }
    });
  });
}
