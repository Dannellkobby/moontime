import 'dart:io';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:moontime/controllers/navigation_controller.dart';
import 'package:moontime/controllers/theme_controller.dart';
import 'package:moontime/utilities/colours.dart';
import 'package:moontime/utilities/constants.dart';
import 'package:moontime/utilities/widgets.dart';
import 'package:moontime/views/screens/favorites.dart';
import 'package:moontime/views/screens/home.dart';
import 'package:moontime/views/widgets/bottom_nav_bar_menu.dart';
import 'package:moontime/views/widgets/scaffold_gradient.dart';

import 'settings.dart';

class MainLayout extends GetView<NavigationController> {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = (Theme.of(context).brightness == Brightness.dark);
    return WillPopScope(
      onWillPop: () {
        if (controller.tabController.index != NavbarScreens.home.index) {
          controller.tabController.animateTo(NavbarScreens.home.index);
          return Future.value(false);
        }

        if (controller.exitWindowOpen) {
          return Future.value(true);
        } else {
          controller.openExitWindow();
          toastExitApp();
        }

        return Future.value(false);
      },
      child: DefaultTabController(
        length: NavbarScreens.values.length,
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
          child: Stack(
            children: [
              Container(
                height: double.maxFinite,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: Theme.of(context).brightness == Brightness.dark
                      ? [
                          // const Color(0xFF12171A),
                          // const Color(0xFF130C17),
                          const Color(0xFF100417),
                          const Color(0xFF051013),
                        ]
                      : [
                          // Color(0xFF8EC5FC),
                          // Color(0xFFE0C3FC),
                          const Color(0xFFE5EEF8),
                          const Color(0xFFF9F6FC),
                        ],
                )),
              ),
              ScaffoldGradient(
                primary: true,
                bottomNavigationBar: BlurryContainer(
                  blur: 15,
                  elevation: 0,
                  color: isDarkTheme
                      ? const Color(0xFFE5EEF8).withOpacity(0.1)
                      : Colours.white.withOpacity(0.99),
                  padding: const EdgeInsets.all(0),
                  height: kBottomNavBarHeight +
                      MediaQuery.of(context).padding.bottom,
                  borderRadius: BorderRadius.only(
                    topLeft: Platform.isIOS
                        ? const Radius.circular(16)
                        : const Radius.circular(24),
                    topRight: Platform.isIOS
                        ? const Radius.circular(16)
                        : const Radius.circular(24),
                  ),
                  child: Builder(builder: (context) {
                    final glowDecoration = BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: (Theme.of(context).brightness ==
                                    Brightness.dark)
                                ? Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.4)
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.5),
                            blurRadius: 16.0,
                            spreadRadius: 0.0,
                            offset: const Offset(0.0, 0.0),
                          ),
                        ]);
                    return Row(
                      children: [
                        BottomNavBarMenu(
                          iconWidget: const Icon(IconlyBroken.home),
                          iconWidgetPressed: Container(
                              decoration: glowDecoration,
                              child: Icon(
                                IconlyBold.home,
                                color: Theme.of(context).colorScheme.onPrimary,
                              )),
                          index: NavbarScreens.home.index,
                          onPress: () {
                            controller.tabController
                                .animateTo(NavbarScreens.home.index);
                          },
                        ),
                        BottomNavBarMenu(
                          iconWidget: const Icon(IconlyBroken.bookmark),
                          iconWidgetPressed: Container(
                            decoration: glowDecoration,
                            child: Icon(
                              IconlyBold.bookmark,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          index: NavbarScreens.favourites.index,
                          onPress: () {
                            controller.tabController
                                .animateTo(NavbarScreens.favourites.index);
                          },
                        ),
                        BottomNavBarMenu(
                          iconWidget: const Icon(IconlyBroken.setting),
                          iconWidgetPressed: Container(
                            decoration: glowDecoration,
                            child: Icon(
                              IconlyBold.setting,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          onPress: () {
                            controller.tabController
                                .animateTo(NavbarScreens.settings.index);
                          },
                          index: NavbarScreens.settings.index,
                        ),
                        const SizedBox(width: 12)
                      ],
                    );
                  }),
                ),
                body: Obx(
                  () => SizedBox(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: TabBarView(
                      physics: controller.disableSwipe.value
                          ? const NeverScrollableScrollPhysics()
                          : const BouncingScrollPhysics(),
                      controller: controller.tabController,
                      //index: NavigationController.to.currentIndex.value,
                      children: const [
                        Home(),
                        Favorites(),
                        Settings(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
