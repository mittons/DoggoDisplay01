import 'package:solid_doggo_display_01/models/dog_service/dog_breed.dart';
import 'package:solid_doggo_display_01/services/dog_service/dog_service.dart';
import 'package:solid_doggo_display_01/services/service_result.dart';

class MockDogService extends DogService {
  Function(ServiceResult res)? onGetDogBreeds;

  MockDogService() : super(baseApiUrl: "");

  @override
  Future<ServiceResult<List<DogBreed>?>> getDogBreeds() async {
    List<DogBreed> breeds = [1, 2, 3, 4, 5]
        .map((idx) => DogBreed(
            id: idx,
            name: "Breed $idx",
            weight: "10 - 2$idx",
            height: "1 - 1$idx",
            lifeSpan: "10 - 1$idx",
            referenceImageId: "placeholder$idx"))
        .toList();

    ServiceResult<List<DogBreed>?> result =
        ServiceResult(data: breeds, success: true);

    if (onGetDogBreeds != null) {
      result = onGetDogBreeds!(result);
    }
    return result;
  }
}
