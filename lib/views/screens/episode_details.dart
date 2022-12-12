/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:moontime/controllers/episode_details_controller.dart';
import 'package:moontime/controllers/favorites_controller.dart';
import 'package:moontime/controllers/show_details_controller.dart';
import 'package:moontime/models/episode.dart';
import 'package:moontime/utilities/colours.dart';
import 'package:moontime/utilities/constants.dart';
import 'package:moontime/utilities/widgets.dart';
import 'package:moontime/views/widgets/back_icon.dart';
import 'package:moontime/views/widgets/card_cast.dart';
import 'package:moontime/views/widgets/moontime_placeholder.dart';

class EpisodeDetails extends GetView<EpisodeDetailsController> {
  final Episode episode;

  const EpisodeDetails({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                  errorWidget: (c, err, obj) => const MoontimePlaceholder(
                      logoSize: 120,
                      height: double.maxFinite,
                      logoColor: Colours.redError),
                  placeholder: (c, err) => const MoontimePlaceholder(
                        height: double.maxFinite,
                      ),
                  height: double.maxFinite,
                  width: double.maxFinite,
                  imageUrl:
                      '${episode.image?.medium ?? episode.show?.image?.medium}'),
              BlurryContainer(
                blur: 40,
                elevation: 0,
                height: double.maxFinite,
                width: double.maxFinite,
                color: Colours.darkShade900.withOpacity(0.5),
                padding: const EdgeInsets.all(0),
                borderRadius: const BorderRadius.all(Radius.circular(0)),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 18.0),
                    child: Container()),
              ),
            ],
          ),
          NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  stretch: true,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarBrightness: Brightness.light,
                      statusBarIconBrightness: Brightness.light),
                  collapsedHeight: (kToolbarHeight * 2) -
                      MediaQuery.of(context).viewPadding.top,
                  expandedHeight:
                      (episode.image != null || episode.show?.image == null)
                          ? ((9 / 16) * context.width) +
                              ((kToolbarHeight * 2) -
                                  MediaQuery.of(context).viewPadding.top)
                          : (((4 / 6) * context.height)),
                  leading: const BackIcon(),
                  actions: [
                    Obx(
                      () => LikeButton(
                          isLiked: (Get.find<FavoritesController>()
                              .favoriteEpisodes
                              .any((e) => e.id == episode.id)),
                          onTap: (bool liked) async {
                            Get.find<FavoritesController>()
                                .toggleFavoriteEpisode(episode);
                            return Future.value(true);
                          },
                          likeBuilder: (bool liked) => liked
                              ? const Icon(
                                  IconlyBold.heart,
                                  color: Colours.moonOrangeLight,
                                )
                              : const Icon(
                                  IconlyBroken.heart,
                                  color: Colours.white,
                                )),
                    ),
                    const SizedBox(
                      width: kFormSpacing,
                    )
                  ],
                  flexibleSpace: Stack(
                    children: [
                      CachedNetworkImage(
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                          errorWidget: (c, err, obj) =>
                              const MoontimePlaceholder(
                                  logoSize: 160,
                                  blur: 12,
                                  height: double.maxFinite,
                                  logoColor: Colours.redError),
                          placeholder: (c, err) => const MoontimePlaceholder(
                                height: double.maxFinite,
                              ),
                          height: double.maxFinite,
                          width: double.maxFinite,
                          imageUrl:
                              '${episode.image?.original ?? episode.show?.image?.original}'),
                      Container(
                        height: 96,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colours.darkBg.withOpacity(0.35),
                            const Color(0x00000000),
                          ],
                        )),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: BlurryContainer(
                          blur: 16,
                          elevation: 0,
                          height: (kToolbarHeight * 2),
                          // + ((MediaQuery.of(context).viewPadding.top) * 2),
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.1),
                          padding: const EdgeInsets.all(0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                          child: Center(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: kFormSpacing * 2,
                                        right: (kFormSpacing * 2)),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        episode.name,
                                        // strutStyle: const StrutStyle(
                                        //     height: 1.2, forceStrutHeight: true),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            ?.copyWith(
                                          color: Colors.white,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: const Offset(0.5, 0.5),
                                              blurRadius: 2.0,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'S${episode.season}    E${episode.season}',
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    strutStyle: const StrutStyle(
                                        height: 1.2, forceStrutHeight: true),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                      color: Colors.white,
                                      fontSize: 12,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: const Offset(0.5, 0.5),
                                          blurRadius: 1.0,
                                          // color: Color.fromARGB(255, 0, 0, 0),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                        ),
                                      ],
                                      // color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                ),
              ];
            },
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(IconlyBold.calendar,
                        color: Colours.lightShade500),
                    Text(
                      ' ${DateFormat.yMMMd().format(episode.airdate ?? DateTime.now())}',
                      style: const TextStyle(color: Colours.lightShade500),
                      strutStyle:
                          const StrutStyle(height: 1.2, forceStrutHeight: true),
                    ),
                    getDividerVertical(
                        height: 20, width: 0.51, color: Colours.lightShade500),
                    const Icon(IconlyBold.video, color: Colours.lightShade500),
                    Text(
                      ' ${episode.runtime ?? 30}m',
                      style: const TextStyle(color: Colours.lightShade500),
                      strutStyle:
                          const StrutStyle(height: 1.2, forceStrutHeight: true),
                    ),
                    getDividerVertical(
                        height: 20, width: 0.51, color: Colours.lightShade500),
                    const Icon(IconlyBold.time_square,
                        size: 20, color: Colours.lightShade500),
                    Text(
                      ' ${(episode.airtime?.isEmpty ?? true) ? 'Soon' : episode.airtime}',
                      style: const TextStyle(color: Colours.lightShade500),
                      strutStyle:
                          const StrutStyle(height: 1.2, forceStrutHeight: true),
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: RatingBar(
                      initialRating: episode.rating!.average! / 2,
                      maxRating: 10,
                      minRating: 0,
                      glow: true,
                      glowColor: Colors.white,
                      glowRadius: 100,
                      ignoreGestures: true,
                      itemSize: 12,
                      wrapAlignment: WrapAlignment.center,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      ratingWidget: RatingWidget(
                        full: const Icon(
                          IconlyBold.star,
                          color: Colors.amber,
                        ),
                        half: const Icon(
                          IconlyBroken.star,
                          color: Colors.amber,
                        ),
                        empty: const Icon(
                          IconlyBroken.star,
                          color: Colours.lightShade500,
                        ),
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                  ),
                ),
                if ((episode.summary?.isNotEmpty ?? false))
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kFormSpacing / 2),
                    child: Theme(
                      data: ThemeData(
                          primaryColor: Colors.white,
                          textTheme: TextTheme(
                              bodyText2: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: Colours.lightShade500))),
                      child: Html(
                        data: episode.summary!,
                        shrinkWrap: true,
                      ),
                    ),
                  ),
                if (Get.find<ShowDetailsController>().castInShow?.isNotEmpty ??
                    false)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: kFormSpacing,
                            right: kFormSpacing,
                            bottom: kFormSpacing / 2),
                        child: Text(
                          'Cast',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kFormSpacing / 2),
                        child: SizedBox(
                          height: 192,
                          child: (ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                                horizontal: kFormSpacing / 2),
                            scrollDirection: Axis.horizontal,
                            itemCount: Get.find<ShowDetailsController>()
                                    .castInShow
                                    ?.length ??
                                0,
                            itemBuilder:
                                (BuildContext context, int indexEpisode) {
                              return SizedBox(
                                  width: kCardWidthSmall,
                                  child: CardCast(
                                      cast: Get.find<ShowDetailsController>()
                                          .castInShow!
                                          .elementAt(indexEpisode)));
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(width: 12),
                          )),
                        ),
                      ),
                    ],
                  ),
                controller.obx(
                    onLoading: const SizedBox.shrink(),
                    (state) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: kFormSpacing),
                            if ((controller.state?.isNotEmpty ?? false))
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: kFormSpacing,
                                    right: kFormSpacing,
                                    bottom: kFormSpacing / 2),
                                child: Text(
                                  'Guest Cast',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kFormSpacing / 2),
                              child: SizedBox(
                                height: 192,
                                child: (ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kFormSpacing / 2),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.state?.length ?? 0,
                                  itemBuilder:
                                      (BuildContext context, int indexEpisode) {
                                    return SizedBox(
                                        width: 112,
                                        child: CardCast(
                                            cast: controller.state!
                                                .elementAt(indexEpisode)));
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(width: 12),
                                )),
                              ),
                            ),
                          ],
                        )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
