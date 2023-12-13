import 'package:flutter/material.dart';
import 'package:solid_doggo_display_01/helpers/ui_helper.dart';
import 'package:solid_doggo_display_01/models/dog_service/dog_breed.dart';
import 'package:solid_doggo_display_01/services/dog_service/dog_service.dart';
import 'package:solid_doggo_display_01/services/service_result.dart';

class DogScreen extends StatefulWidget {
  final DogService dogService;

  const DogScreen({super.key, required this.dogService});

  @override
  State<StatefulWidget> createState() => _DogScreenState();
}

class _DogScreenState extends State<DogScreen> {
  bool dogsLoaded = false;
  late List<DogBreed> dogBreeds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dog Breed List"),
        backgroundColor: Colors.deepPurpleAccent.shade100,
      ),
      body: Column(
        children: [
          // Display a button that enables the user to fetch and display a list of dog breeds
          _buildButtonContainer(),
          // If the dog breeds list has been fetched and loaded, then display it.
          if (dogsLoaded) Expanded(child: _buildDogBreedList())
        ],
      ),
    );
  }

  //------------------------------------------
  //| "Fetch list of dog breeds" Button code
  //------------------------------------------

  Widget _buildButtonContainer() {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 9, bottom: 10),
      child: ElevatedButton(
        onPressed: _handlePress,
        child: const Text("Get dog breeds"),
      ),
    );
  }

  Future<void> _handlePress() async {
    ServiceResult dogBreedResult = await widget.dogService.getDogBreeds();

    if (!context.mounted) return;

    if (dogBreedResult.success != true) {
      UiHelper.displaySnackbar(context,
          "Unable to aquire dog breed list from web service. Try again later.");
      return;
    }

    setState(() {
      dogBreeds = dogBreedResult.data!;
      dogsLoaded = true;
    });
  }

  //------------------------------------------
  //| Dog Breeds List code
  //------------------------------------------

  Widget _buildDogBreedList() {
    return ListView.builder(
      itemBuilder: _dogBreedBuilder,
      itemCount: dogBreeds.length,
    );
  }

  Widget _dogBreedBuilder(context, index) {
    return Card(
      child: ListTile(
        title: Text(dogBreeds[index].name),
        subtitle: (dogBreeds[index].temperament == null)
            ? null
            : Text(dogBreeds[index].temperament!),
      ),
    );
  }
}
