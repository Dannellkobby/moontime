import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moontime/controllers/favorites_controller.dart';
import 'package:moontime/controllers/navigation_controller.dart';
import 'package:moontime/controllers/theme_controller.dart';
import 'package:moontime/utilities/constants.dart';
import 'package:moontime/utilities/widgets.dart';
import 'package:moontime/views/widgets/back_icon.dart';
import 'package:moontime/views/widgets/scaffold_gradient.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Settings extends GetView<FavoritesController> {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ScaffoldGradient(
        appBar: AppBar(
          centerTitle: true,
          leading: BackIcon(
            onPressed: () => Get.find<NavigationController>().tabController.animateTo(NavbarScreens.favourites.index),
          ),
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.all(kFormSpacing),
            child: Text(
              'Settings',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
        body: Column(
          children: [
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      horizontal: kFormSpacing * 2, vertical: kFormSpacing))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Theme'),
                  PopupMenuButton(
                    child: Text(('${ThemeController.get.theme.value}'
                        .replaceFirst('ThemeEnums.', ''))
                        .toUpperCase()),
                    onSelected: (value) {
                      ThemeController.get.setThemeMode(value);
                    },

                    itemBuilder: (BuildContext bc) {
                      return  [
                        const PopupMenuItem(
                          value: ThemeEnums.system,
                          child: Text("System"),
                        ),
                        const PopupMenuItem(
                          value: ThemeEnums.dark,
                          child: Text("Dark"),
                        ),
                        const PopupMenuItem(
                          value: ThemeEnums.light,
                          child: Text("Light"),
                        )
                      ];
                    },

                  ),



                ],
              ),
            ),
            FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, result) {
                  return (result.connectionState == ConnectionState.waiting)
                      ? getCircularProgressIndicator()
                      : TextButton(
                          onPressed: () {
                            showLicensePage(
                              context: context,
                              applicationName: '',
                              useRootNavigator: false,
                              applicationIcon: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0,
                                        top: 8.0,
                                        bottom: 8.0,
                                        right: 2),
                                    child: SvgPicture.asset(
                                      'assets/icons/logo_lettermark.svg',
                                      height: 24,
                                      width: 24,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      allowDrawingOutsideViewBox: true,
                                      clipBehavior: Clip.none,
                                    ),
                                  ),
                                  Text('oontime',
                                      style:
                                          Theme.of(context).textTheme.headline5)
                                ],
                              ),
                              applicationVersion: result.data?.version ?? '',
                            );
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: kFormSpacing * 2,
                                      vertical: kFormSpacing))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Licenses'),
                              Text(result.data?.version ?? '')
                            ],
                          ),
                        );
                }),
          ],
        ),
      ),
    );
  }
}
