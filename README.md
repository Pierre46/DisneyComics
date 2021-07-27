
# Disney app


## General info

This project target iPhone and iPad devices only and was created for the Disney interview process. The requirements were: 
- [x] Use Marvel’s Developer API <developer.marvel.com>
- [x] Take one comic ID and display: comic book title, description and cover image
- [x] Implement at least one UI and unit test
- [x] Upload code to GitHub/Gitlab or something equivalent and provide link and README file
- [x] Specify which libraries you have used
- [x] Specify how to add your developer keys


## Get started

This project was kept as simple as possible so it can be easy for the reviewer(s) to compile and review the code without having to setup anything. Therefore there is no external library used. All you need to do is open the project on Xcode and change the Team in the Signing and Capabilities in each target. This project was created with Xcode 12.5.1.


## Discussion

The project uses a simple MVVM architecture along with Combine framework (This is my first time using Combine for this purpose).
* `Constants.swift` file allows you to modify the comic Id that is displayed on screen and the Marvel API public/private keys. 
* `MarvelService.swift` is a generic class that allow the application to make API calls with Marvel API using URLSession.
* `ComicsManager.swift` utilize MarvelService class to retrieve a comic given a comic Id.
* `Comic.swift` represent a comic. To prevent nested data and to show that I’m familiar with Decodable, I customized the parsing process.
* `MarvelError.swift` is a very basic way to retrieve and display the errors from the API calls.
* `MainStoryboard` was used because the UI was simple and therefore it was convenient to use Storyboard. Content is inside a scrollview in case the texts are too long to fit in the screen.

If you want me to make any changes to this project (use different libraries, architecture, design pattern etc) please let me know and I will make the changes.


## Unit / UI testing

Base on the requirements, I created couple Unit tests but also Integration and UI testing. 
* `MarvelServiceTests.swift` contains a simple unit test.
* `ComicsManagerTests.swift` contains an integration test (load the comic from backend).
* `ComicsManagerTests.swift` contain tests for the viewModel state mocking the API response.
* `DisneyUITests.swift` contains a very simple UI testing just to check the comic title and description (It does not mock the API response and if the comicId change in the constant file, it will fails the testing).
