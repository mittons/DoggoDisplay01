class AppConfig {
  final String baseDogApiUrl;

  AppConfig({required this.baseDogApiUrl});
}

// This app uses thedogapi.com as a data source, but the http requests are routed through a backend to manage secrets.
// Its possible to replace this url with a direct reference to thedogapi.com but it requires user access to the api from the person
//   who is responsible for the requests.
class DefaultConfig extends AppConfig {
  static const String baseDogApiUrlValue =
      "https://nodedogroute-38a170d08520.herokuapp.com";

  DefaultConfig() : super(baseDogApiUrl: baseDogApiUrlValue);
}

class IntegrationTestConfig extends AppConfig {
  static const String baseMockDogApiUrlValue = "http://localhost:3001";

  IntegrationTestConfig() : super(baseDogApiUrl: baseMockDogApiUrlValue);
}
