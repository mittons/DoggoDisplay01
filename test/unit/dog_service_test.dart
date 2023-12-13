import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:solid_doggo_display_01/services/dog_service/dog_service.dart';
import 'package:solid_doggo_display_01/services/service_result.dart';
import 'package:solid_doggo_display_01/utils/service_locator.dart';

import '../mock/mock_http_client_factory.dart';

void main() {
  tearDown(() {
    serviceLocator.unregister<http.Client>();
  });

  group("Dog Service (happy paths)", () {
    test('getData should return success on 200 response', () async {
      _testValidClient(MockClientFactory.get200Client(_getValidDogBreedJson()));
    });
  });

  group("Dog Service (Invalid Json in response body)", () {
    //
    test("Returns no success on invalid json form for 200 response", () async {
      _testErrorClient(
          MockClientFactory.get200Client(_getInvalidDogBreedJson()));
    });
  });

  group("Dog Service (Http Exceptinos and Errors)", () {
    //
    test("returns no success on 404 response", () async {
      _testErrorClient(MockClientFactory.get404Client());
    });

    test("returns no success on SockeException", () async {
      _testErrorClient(MockClientFactory.getSocketExceptionClient());
    });

    test("returns no success on TimeoutException", () async {
      _testErrorClient(MockClientFactory.getTimeoutExceptionClient());
    });

    test("returns no success on HttpException", () async {
      _testErrorClient(MockClientFactory.getHttpExceptionClient());
    });
  });
}

Future<void> _testValidClient(http.Client mockClient) async {
  // Register valid response http client (prepare the environment of the service being tested)
  serviceLocator.registerSingleton<http.Client>(mockClient);

  // Init service to test
  //   We can use "" as baseApiUrl since we are using a mock http.Client
  DogService dogService = DogService(baseApiUrl: "");

  // Perform the intended test
  ServiceResult methodResult = await dogService.getDogBreeds();

  // Expect success result (success response should be expected if the client has a valid response)
  expect(methodResult.success, true);
}

Future<void> _testErrorClient(http.Client mockClient) async {
  // Register error response http client (prepare the environment of the service being tested)
  serviceLocator.registerSingleton<http.Client>(mockClient);

  // Init service to test
  //   We can use "" as baseApiUrl since we are using a mock http.Client
  DogService dogService = DogService(baseApiUrl: "");

  // Perform the intended test
  ServiceResult methodResult = await dogService.getDogBreeds();

  // Expect non success result (success response should be impossible with a bad response from http client)
  expect(methodResult.success, false);
}

String _getValidDogBreedJson() {
  return """[{"weight":{"imperial":"6 - 13","metric":"3 - 6"},"height":{"imperial":"9 - 11.5","metric":"23 - 29"},"id":1,"name":"Affenpinscher","bred_for":"Small rodent hunting, lapdog","breed_group":"Toy","life_span":"10 - 12 years","temperament":"Stubborn, Curious, Playful, Adventurous, Active, Fun-loving","origin":"Germany, France","reference_image_id":"BJa4kxc4X"},{"weight":{"imperial":"50 - 60","metric":"23 - 27"},"height":{"imperial":"25 - 27","metric":"64 - 69"},"id":2,"name":"Afghan Hound","country_code":"AG","bred_for":"Coursing and hunting","breed_group":"Hound","life_span":"10 - 13 years","temperament":"Aloof, Clownish, Dignified, Independent, Happy","origin":"Afghanistan, Iran, Pakistan","reference_image_id":"hMyT4CDXR"},{"weight":{"imperial":"44 - 66","metric":"20 - 30"},"height":{"imperial":"30","metric":"76"},"id":3,"name":"African Hunting Dog","bred_for":"A wild pack animal","life_span":"11 years","temperament":"Wild, Hardworking, Dutiful","reference_image_id":"rkiByec47"}]
  """;
}

String _getInvalidDogBreedJson() {
  return "!@#asdlkfj";
}
