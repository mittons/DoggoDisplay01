import 'dart:convert';

import 'package:solid_doggo_display_01/config/config.dart' as cfg;
import 'package:http/http.dart' as http;
import 'package:solid_doggo_display_01/models/dog_service/dog_breed.dart';
import 'package:solid_doggo_display_01/services/service_result.dart';
import 'package:solid_doggo_display_01/utils/service_locator.dart';

class DogService {
  final String baseApiUrl;

  DogService({required this.baseApiUrl});

  String _generateRequestURL(String route) {
    // ignore: unnecessary_brace_in_string_interps
    return "${baseApiUrl}${route}?key=${cfg.dogApiKey}";
  }

  http.Client _getHttpClient() {
    return serviceLocator<http.Client>();
  }

  Future<ServiceResult<List<DogBreed>?>> getDogBreeds() async {
    late final http.Response response;
    try {
      response =
          await _getHttpClient().get(Uri.parse(_generateRequestURL("/breeds")));
    } catch (e) {
      print("Error fetching data from external server: $e");
      return ServiceResult(data: null, success: false);
    }

    if (response.statusCode != 200) {
      print("Invalid http response status code: ${response.statusCode}");
      return (ServiceResult(data: null, success: false));
    }

    try {
      final parsedJson = jsonDecode(response.body);

      List<DogBreed> resultList = (parsedJson as List)
          .map((breedJson) => DogBreed.fromJson(breedJson))
          .toList();

      return ServiceResult(data: resultList, success: true);
    } catch (e) {
      print("Error parsing json response from service: $e");
      return (ServiceResult(data: null, success: false));
    }
  }
}
