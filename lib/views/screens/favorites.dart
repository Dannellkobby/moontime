import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:moontime/controllers/favorites_controller.dart';
import 'package:moontime/controllers/navigation_controller.dart';
import 'package:moontime/controllers/search_controller.dart';
import 'package:moontime/utilities/constants.dart';
import 'package:moontime/utilities/strings.dart';
import 'package:moontime/views/widgets/card_show.dart';

class Favorites extends GetView<FavoritesController> {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: kToolbarHeight,
                  ),
                ),
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  title: Padding(
                    padding: const EdgeInsets.all(kFormSpacing),
                    child:  Text(
                        'Favorites',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                ),
              ];
            },
            body: Obx(
              () => Padding(
                padding: const EdgeInsets.only(
                    left: kFormSpacing / 2,
                    right: kFormSpacing / 2,
                    top: kToolbarHeight),
                child: MasonryGridView.builder(
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                  physics: const BouncingScrollPhysics(),
                  mainAxisSpacing: kFormSpacing,
                  crossAxisSpacing: 10,
                  itemCount: controller.favoriteShows.length,
                  itemBuilder: (context, index) {
                    return CardShow(
                      show: controller.favoriteShows.elementAt(index),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            left: kFormSpacing,
            top: (MediaQuery.of(context).viewPadding.top)-4,
            child: InkWell(
              onTap: () => Get.find<NavigationController>().tabController.animateTo(NavbarScreens.home.index),
              child: SvgPicture.asset(
                'assets/icons/logo_lettermark.svg',height: 24,width: 24,
                color: Theme.of(context).colorScheme.onPrimary,
                allowDrawingOutsideViewBox: true,
                clipBehavior: Clip.none,
                // height: 16,
                // width: 16,
              ),
            ),
          ),
          Positioned(
            right: kFormSpacing,
            top: 8,
            child: Hero(
              tag: 'search',
              child: Material(
                type: MaterialType.transparency,
                shape: const CircleBorder(),
                color: Colors.transparent,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      IconlyBroken.search,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  onTap: () => Get.toNamed(Strings.routeSearch,
                      arguments: SearchScope.series.index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

