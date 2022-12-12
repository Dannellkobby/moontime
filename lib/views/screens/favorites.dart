import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:moontime/controllers/favorites_controller.dart';
import 'package:moontime/controllers/search_controller.dart';
import 'package:moontime/utilities/colours.dart';
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
            child: SvgPicture.asset(
              'assets/icons/logo_lettermark.svg',height: 24,width: 24,
              color: Theme.of(context).colorScheme.onPrimary,
              allowDrawingOutsideViewBox: true,
              clipBehavior: Clip.none,
              // height: 16,
              // width: 16,
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

class MoontimePlaceholder extends StatelessWidget {
  final Color? logoColor;
  final double? height;
  final double? blur;
  final double? logoSize;

  const MoontimePlaceholder({
    Key? key,
    this.logoColor,
    this.height,
    this.blur,
    this.logoSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/logo_lettermark.svg',
          height: logoSize ?? 32,
          alignment: Alignment.center,
          color: logoColor ?? Colours.moonBlueLight,
        ),
        BlurryContainer(
          blur: blur ?? 4,
          height: height ?? 100,
          width: double.maxFinite,
          elevation: 0,
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
          padding: const EdgeInsets.all(0),
          borderRadius: const BorderRadius.all(Radius.circular(0)),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                const Color(0xFF8EC5FC).withOpacity(0.1),
                const Color(0xFFE0C3FC).withOpacity(0.1),
              ],
            )),
          ),
        ),
      ],
    );
  }
}
