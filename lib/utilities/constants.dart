const double kBottomNavBarHeight = 64.0;
const double kBottomNavBarMargin = 16.0;
const double kBottomNavBarBorderRadius = 100.0;
const double kMaxBorderRadius = 999.0;
const int kBottomNavBarItems = 4;
const double kCardWidthSmall = 112.0;
const double kCardWidthMedium = 128.0;
const double kCardWidthLarge = 192.0;
const double kFormSpacing = 32.0;
const double kEdgePadding = 24.0;
const double kRadiusLarge = 32.0;
const double kRadiusMedium = 24.0;
const double kRadiusSmall = 8.0;
const int kVerticalListPageSize = 10;
const int kVerticalStaggeredPageSize = 6;
const int kHorizontalChipPageSize = 6;
const String kAppName = 'Moontime';
const String kFontIsidora = 'Isidora';
const String kFontIsidoraSans = 'IsidoraSans';
const String kNa = 'n/a';
const String kTVMazeBaseUrl = 'https://api.tvmaze.com';
const String kTVMazeAuthority = 'api.tvmaze.com';
enum SearchStatus {
  idle,
  connecting,
  searching,
  error,
  available,
  unavailable
}