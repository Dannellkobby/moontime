import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moontime/controllers/home_controller.dart';
import 'package:moontime/utilities/colours.dart';
import 'package:moontime/utilities/constants.dart';
import 'package:moontime/views/widgets/card_episode.dart';
import 'package:moontime/views/widgets/card_show.dart';
import 'package:shimmer/shimmer.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: controller.obx(
                (state) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(kFormSpacing),
                      child: Text(
                        'Airing Today',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    CarouselSlider(
                        items: state?.item1?.toList().map((episode) {
                          return CardEpisode(
                            episode: episode,
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 0.4,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval:
                              const Duration(seconds: kDebugMode ? 30 : 30),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        )),
                  ],
                ),
                onLoading: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(kFormSpacing),
                      child: Text(
                        'Welcome',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Shimmer(
                      gradient: LinearGradient(colors: [
                        Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
                        Theme.of(context).colorScheme.background.withOpacity(0.4),
                        Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
                      ]),
                      child: CarouselSlider(
                          items: [1, 2, 3].map((i) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                color: Colors.white,
                              ),
                            );
                          }).toList(),
                          options: CarouselOptions(
                            viewportFraction: 0.4,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: false,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          )),
                    ),
                  ],
                ),
                onError: (error) =>
                    const Center(child: Text('Something went wrong')),
              ),
            ),
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
                child: Text(
                  'Browse All Series',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ),
          ];
        },
        body: controller.obx(
          (state) => Padding(
            padding: const EdgeInsets.only(
                left: kFormSpacing / 2,
                right: kFormSpacing / 2,
                top: kToolbarHeight),
            child: MasonryGridView.builder(
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
              // primary: false,
              // shrinkWrap: true,
              // addAutomaticKeepAlives: true,
              // physics: const AlwaysScrollableScrollPhysics(),
              physics: const BouncingScrollPhysics(),
              mainAxisSpacing: kFormSpacing,
              crossAxisSpacing: 10,
              itemCount: state!.item2?.length,
              itemBuilder: (context, index) {
                return CardShow(show: state.item2!.elementAt(index),);
              },
            ),
          ),
        ),
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
          height: logoSize??32,
          alignment: Alignment.center,
          color: logoColor ?? Colours.moonBlueLight,
        ),
        BlurryContainer(
          blur: blur??4,
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
