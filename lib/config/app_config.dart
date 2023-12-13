class AppConfig {
  final String baseDogApiUrl;

  AppConfig({required this.baseDogApiUrl});
}

class DefaultConfig extends AppConfig {
  static const String baseDogApiUrlValue = "https://api.thedogapi.com/v1";

  DefaultConfig() : super(baseDogApiUrl: baseDogApiUrlValue);
}

class IntegrationTestConfig extends AppConfig {
  static const String baseMockDogApiUrlValue = "http://localhost:3001";

  IntegrationTestConfig() : super(baseDogApiUrl: baseMockDogApiUrlValue);
}
