# DoggoDisplay01

## About Project:
This project displays facts about dogs using dog api. It is implemented in Flutter.

Uses data from [TheDogApi.com](https://thedogapi.com/).

## Started On:
:calendar: December 09, 2023 *(AUTO-GENERATED)* :calendar:

## Reflections:
I simply made this project because I was in the mood to write a project where I could exercise my skills.

This ended up being a very simple app but using a lot of the skills I have been practicing lately (see [milestone](#notable-milestone-resources-created) section).

For my next projects I need to add consistent documentation (DartDoc in this case), as well as clean local and remote exception/error logging. Then I will finally be content in the comprehensive-ness of my code quality toolkit.

## Notable (Milestone) Resources Created:
- Flutter app with a:
  - Presentation layer ~ Displays a list of items on command
  - Service layer ~ Fetches list of items from REST api
- Error handling
  - Presentation layer ~ Displays snackbar if Service layer is not successful
  - Service layer ~ Is responsible for the details of data access, abstracts complexity of error handling away from the user facing presentation layer code.
- Unit tests
  - Presentation layer ~ Widget testing using injection of a mock version of the service layer
  - Service layer ~ Unit testing using injection of a mock http client
- Integration tests
  - Presentation and Service layers tested at the same time using either:
    - Production api - if CI flag is false
    - Local mock api - if CI flag is true
- CI/CD script ~ GitHub Actions Script running on ubuntu-latest
  - Sets up flutter and project dependencies
  - Injects secret tokens and keys as needed
  - Runs unit tests
  - Sets up integration test environment
    - Installs chromedriver to enable chrome as a test device
    - Pulls and runs a docker image of a mock version of the external api
      - Image built using the first commit to the [MockDogApi01](https://github.com/mittons/MockDogApi01) repository
      - Utilizes a Python script for managing access and container management
  - Runs integration tests ~ Device: Chrome on Ubuntu
  - Builds application
  - Deploys application to GitHub Pages
- README.me suited for skill consolidation/validation projects
