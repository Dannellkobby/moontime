
# Moontime

This is an open source Flutter project for listing tv series from the tvmaze.com/api.

## Installation

- Must have Flutter SDK installed on machine
- Download or Pull or Fetch from https://github.com/Dannellkobby/moontime.
- Open in Android studio or VSCode as Flutter project
- To use your own Firebase project
  - Replace /android/app/google-services.json with yours
  - Replace /ios/Runner/GoogleService-Info.plist with yours
  - Run <flutterfire configure>
- Open terminal in project root directory and run <flutter pub get>
```bash
flutter pub get
```
- Run <flutter build>
```bash
flutter build
```

### App features
- List all series in the tvMaze Api
- List all episodes airing today
- Search for series by name
- Search for people by name
- Click series to see casts, and episodes
- Click episode to see details and guest casts
- Click cast to see see details and and series featured in
- Save show, episode, cast to favourites
- Remove show, episode, cast from favourites
- Switch theme modes: Light, Dark System
- At the core
  - MVC Architecture design
  - Getx for state management
  - Ios and Android build tested
  - VCS enabled

### TODOs
- Add pin and biometric authentication
- Show Favourite episodes and favourite casts
- Comment code
- Do Unit, Widget and Integration testing
- Do Performance testing
- Create CI/CD pipelines for app signing


## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to test updates as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)