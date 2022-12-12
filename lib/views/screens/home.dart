/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:moontime/controllers/home_controller.dart';
import 'package:moontime/controllers/search_controller.dart';
import 'package:moontime/utilities/colours.dart';
import 'package:moontime/utilities/constants.dart';
import 'package:moontime/utilities/strings.dart';
import 'package:moontime/utilities/widgets.dart';
import 'package:moontime/views/screens/error_page.dart';
import 'package:moontime/views/widgets/card_episode.dart';
import 'package:moontime/views/widgets/card_show.dart';
import 'package:shimmer/shimmer.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

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
                SliverToBoxAdapter(
                  child: controller.obx(
                    (state) => Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: (kToolbarHeight / 2) -
                                  (MediaQuery.of(context).viewPadding.top),
                              bottom: kFormSpacing),
                          child: Text(
                            'Airing Today',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        CarouselSlider(
                            items: state?.item1?.toList().map((episode) {
                              return CardEpisode(
                                episode: episode,
                                tapToDetails: false,
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
                          padding: EdgeInsets.only(
                              top: (kToolbarHeight / 2) -
                                  (MediaQuery.of(context).viewPadding.top),
                              bottom: kFormSpacing),
                          child: Text(
                            'Welcome',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        Shimmer(
                          gradient: LinearGradient(colors: [
                            Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.2),
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.4),
                            Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.2),
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
                        ErrorPage(title: 'Something is not right', error: error,),
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
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.fetching.isTrue
                                ? ''
                                : 'Browse All Series ',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          if (controller.fetching.isTrue)
                            getCircularProgressIndicator(height: 32, width: 32)
                        ],
                      ),
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
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification.metrics.pixels ==
                        scrollNotification.metrics.maxScrollExtent) {
                      controller.loadMoreShows();
                      // setState(() {
                      //   items_number += 10 ;
                      // });
                    }
                    return true;
                  },
                  child: MasonryGridView.builder(
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    physics: const BouncingScrollPhysics(),
                    mainAxisSpacing: kFormSpacing,
                    crossAxisSpacing: 10,
                    itemCount: controller.shows?.length,
                    itemBuilder: (context, index) {
                      return CardShow(
                        show: controller.shows!.elementAt(index),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: kFormSpacing,
            top: (MediaQuery.of(context).viewPadding.top) - 4,
            child: SvgPicture.asset(
              'assets/icons/logo_lettermark.svg', height: 24,
              width: 24,
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
