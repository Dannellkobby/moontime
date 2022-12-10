import 'package:animate_do/animate_do.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:like_button/like_button.dart';
import 'package:moontime/models/show.dart';
import 'package:moontime/utilities/colours.dart';
import 'package:moontime/utilities/constants.dart';
import 'package:moontime/utilities/widgets.dart';
import 'package:moontime/views/screens/home.dart';
import 'package:moontime/views/widgets/scaffold_gradient.dart';

class ShowDetails extends StatelessWidget {
  final Show show;

  const ShowDetails({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradient(
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
                  imageUrl: '${show.image?.original}'),
              BlurryContainer(
                blur: 40,
                elevation: 0,
                height: double.maxFinite,
                width: double.maxFinite,
                color: Colours.darkShade900.withOpacity(0.8),
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
                      (((MediaQuery.of(context).viewPadding.top) * 2)),
                  expandedHeight: ((4 / 6) * context.height),
                  leading: IconButton(
                      onPressed: () => Navigator.maybePop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  actions: [
                    LikeButton(
                        likeBuilder: (bool liked) => liked
                            ? const Icon(
                                IconlyBold.heart,
                                color: Colours.moonOrangeLight,
                              )
                            : const Icon(
                                IconlyBroken.heart,
                                color: Colours.white,
                              )),
                    const SizedBox(
                      width: kFormSpacing,
                    )
                  ],
                  flexibleSpace: Stack(
                    children: [
                      CachedNetworkImage(
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.center,
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
                          imageUrl: '${show.image?.original}'),
                      Container(
                        height: 96,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colours.darkBg
                                .withOpacity(0.35),
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
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 18.0),
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                          .viewPadding
                                          .top,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: kFormSpacing*2,
                                          right: (kFormSpacing*2)),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          show.name,
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
                                                // color: Color.fromARGB(255, 0, 0, 0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (show.genres != null &&
                                        (show.genres?.isNotEmpty ?? false))
                                      Text(
                                        show.genres!
                                            .map((e) => '$e  ')
                                            .toString()
                                            .replaceAll(
                                                RegExp(r'[^\w\s]+'), ''),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
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
                              )),
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
                      ' ${show.premiered?.year ?? 2022}',
                      style: const TextStyle(color: Colours.lightShade500),
                      strutStyle:
                          const StrutStyle(height: 1.2, forceStrutHeight: true),
                    ),
                    getDividerVertical(
                        height: 30, width: 0.51, color: Colours.lightShade500),
                    const Icon(IconlyBold.video, color: Colours.lightShade500),
                    Text(
                      ' ${show.runtime ?? 30}m',
                      style: const TextStyle(color: Colours.lightShade500),
                      strutStyle:
                          const StrutStyle(height: 1.2, forceStrutHeight: true),
                    ),
                    getDividerVertical(
                        height: 30, width: 0.51, color: Colours.lightShade500),
                    const Icon(IconlyBold.time_square,
                        size: 20, color: Colours.lightShade500),
                    Text(
                      ' ${(show.schedule?.time?.isNotEmpty ?? false) ? show.schedule?.time : 'Soon'}',
                      style: const TextStyle(color: Colours.lightShade500),
                      strutStyle:
                          const StrutStyle(height: 1.2, forceStrutHeight: true),
                    ),
                  ],
                ),
                if (show.schedule?.days != null &&
                    (show.schedule?.days?.isNotEmpty ?? false))
                  Padding(
                    padding: const EdgeInsets.only(
                        left: kFormSpacing, right: kFormSpacing, top: 4),
                    child: Text(
                      '${show.network?.name ?? ''}   ${show.schedule!.days!.map((e) => '${e}s  ').toString().replaceAll(RegExp(r'[^\w\s]+'), '')}',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                        color: Colours.lightShade500,
                        fontSize: 12,
                        shadows: <Shadow>[
                          Shadow(
                            offset: const Offset(0.5, 0.5),
                            blurRadius: 1.0,
                            // color: Color.fromARGB(255, 0, 0, 0),
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ],
                        // color: Colors.white
                      ),
                    ),
                  ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: RatingBar(
                      initialRating: show.rating!.average! / 2,
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
                if ((show.summary?.isNotEmpty ?? false))
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kFormSpacing / 2),
                    child: Html(
                      data: show.summary!,
                      shrinkWrap: true,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}