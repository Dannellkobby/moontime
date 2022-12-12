import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:moontime/controllers/navigation_controller.dart';
import 'package:moontime/controllers/search_controller.dart';
import 'package:moontime/models/cast.dart';
import 'package:moontime/models/person.dart';
import 'package:moontime/models/show.dart';
import 'package:moontime/utilities/colours.dart';
import 'package:moontime/utilities/constants.dart';
import 'package:moontime/utilities/themes.dart';
import 'package:moontime/utilities/widgets.dart';
import 'package:moontime/views/screens/error_page.dart';
import 'package:moontime/views/widgets/back_icon.dart';
import 'package:moontime/views/widgets/card_cast.dart';
import 'package:moontime/views/widgets/card_show.dart';
import 'package:moontime/views/widgets/scaffold_gradient.dart';

class Search extends GetView<SearchController> {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (controller.searchPhrase.isNotEmpty) {
            controller.cancelSearch();
            FocusScope.of(context).unfocus();
            return false;
          }
          if (FocusScope.of(context).hasFocus) {
            FocusScope.of(context).unfocus();
            return false;
          }
          return true;
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Theme.of(context).backgroundColor,
            systemNavigationBarIconBrightness:
                Theme.of(context).brightness == Brightness.light
                    ? Brightness.dark
                    : Brightness.light,
            // For Android (dark icons)
            statusBarIconBrightness:
                Theme.of(context).brightness == Brightness.light
                    ? Brightness.dark
                    : Brightness.light,
            // For Android (dark icons)
            statusBarBrightness:
                Theme.of(context).brightness == Brightness.light
                    ? Brightness.light
                    : Brightness.dark, // For Android (dark icons)
          ),
          child: ScaffoldGradient(
              appBar: AppBar(
                title: Hero(
                  tag: 'search',
                  child: Material(
                    type: MaterialType.transparency,
                    child: SizedBox(
                      height: 48,
                      child: Obx(
                        () => TextField(
                          controller: controller.tecSearch,
                          autofocus: true,
                          style: Theme.of(context).textTheme.bodyText1,
                          strutStyle: const StrutStyle(
                              height: 1.3, forceStrutHeight: true),
                          decoration: Themes.inputDecorationFilled(
                            context: context,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            fillColor: Theme.of(context).colorScheme.surface,
                            hintText:
                                'Search ${controller.searchScope.value.name}',
                            suffixIcon: controller.searchPhrase.isEmpty
                                ? const Padding(
                                    padding:
                                        EdgeInsets.only(left: 12.0, right: 16),
                                    child: Icon(IconlyBroken.search),
                                  )
                                : controller.loading.isTrue
                                    ? SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: getCircularProgressIndicator(
                                            width: 16,
                                            height: 16,
                                            strokeWidth: 1),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          controller.cancelSearch();
                                          FocusScope.of(context).requestFocus();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12.0, right: 16),
                                          child: Icon(Icons.clear,
                                              size: 16,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground),
                                        ),
                                      ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                actions: const [
                  SizedBox(
                    width: kFormSpacing,
                  )
                ],
                backgroundColor: Colors.transparent,
                toolbarHeight: kToolbarHeight * 1.5,
                leading: BackIcon(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 36,
                    width: context.width,
                    child: Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: controller.chipsScrollController,
                        physics: const ClampingScrollPhysics(),
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: SearchScope.values
                                .map((scope) => buildScopeChip(context,
                                    title: (scope.name), scope: scope))
                                .toList()),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        controller: controller.tabController,
                        children: SearchScope.values
                            .map((scope) => SearchResultsPage())
                            .toList()),
                  ),
                ],
              )),
        ));
  }

  Widget buildScopeChip(context,
      {required String title, required SearchScope scope}) {
    return Obx(
      () => Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient:

              (Theme.of(context).brightness ==
                  Brightness.dark)?
              controller.searchScope.value == scope
                  ?  const LinearGradient(colors: [
                   Color(0xFF24152A),
                   Color(0xFF0E2E38),
                    ])
                  : const LinearGradient(colors: [
                Colours.darkBg,
                Colours.darkShade800,
                // Color(0xFF250C34),
              ]):

              controller.searchScope.value == scope
                  ?  const LinearGradient(colors: [
                Color(0xFFE9D5F5),
                Color(0xFFD3E7EF),
              ])
                  : const LinearGradient(colors: [
                Colours.lightBg,
                Colours.lightShade200,
                // Color(0xFF250C34),
              ])
        ),
        height: 32,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 96,
        padding:
              const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
        child: InkWell(
          onTap: () => controller.tabController.animateTo(scope.index),

          child: Text(
              title,
              strutStyle: const StrutStyle(height: 1.2, forceStrutHeight: true),
              style: Theme.of(context).textTheme.button?.copyWith(
                  color: controller.searchScope.value == scope
                      ? null
                      : Theme.of(context).colorScheme.onSurface),
            ),
        ),
      ),
    );
  }
}

class SearchResultsPage extends StatelessWidget {
  SearchResultsPage({Key? key}) : super(key: key);
  final SearchController controller = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.mapOfSearchResults[controller.searchScope.value.name]
                  ?.isEmpty ??
              true)
          ? controller.searchPhrase.isEmpty
              ? buildEmptyPage()
              : controller.loading.isTrue
                  ? getCircularProgressIndicator()
                  : buildNoResult()
          : MasonryGridView.builder(
                  mainAxisSpacing: kFormSpacing,
                  crossAxisSpacing: 10,
              padding: const EdgeInsets.only(
                  left: kFormSpacing / 2,
                  right: kFormSpacing / 2,
                  top: kToolbarHeight/2),
              gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: controller
                      .mapOfSearchResults[controller.searchScope.value.name]
                      ?.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    dynamic item;
                    if (controller.searchScope.value == SearchScope.people) {
                      item = controller
                              .mapOfSearchResults[controller.searchScope.value.name]
                          ?[index] as Person;
                    } else if (controller.searchScope.value == SearchScope.series) {
                      item = controller
                              .mapOfSearchResults[controller.searchScope.value.name]
                          ?[index] as Show;
                    }
                    return (controller.searchScope.value == SearchScope.people)
                        ? SizedBox(
                        width: kCardWidthSmall,
                        height: 192,

                        child: CardCast(cast: Cast(person: item)))
                        : CardShow(show: item);
                  }),
    );
  }

  Widget buildNoResult() {
    return Center(
        child: controller.errorMessage.isNotEmpty
            ? ErrorPage(
                onPressed: () => controller.performSearch(
                    controller.searchScope.value,
                    controller.searchPhrase.value),
                errorText: controller.errorMessage.value,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                      padding: EdgeInsets.all(24),
                      child: Icon(IconlyBroken.search)),
                  Column(
                    children: [
                      Text(
                        controller.searchScope.value == SearchScope.people
                            ? 'No Persons by name "${controller.searchPhrase.value}"'
                            : controller.searchScope.value == SearchScope.series
                                ? 'No Series like "${controller.searchPhrase.value}"'
                                : 'No results',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ));
  }

  Widget buildEmptyPage() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.all(24),
            child: Icon(
              IconlyBroken.search,
              size: 64,
            )),
        Text(controller.searchScope.value == SearchScope.people
            ? 'Search Actors'
            : controller.searchScope.value == SearchScope.series
                ? 'Search Series'
                : ''),
      ],
    ));
  }
}
