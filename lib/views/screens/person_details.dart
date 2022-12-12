/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:like_button/like_button.dart';
import 'package:moontime/controllers/favorites_controller.dart';
import 'package:moontime/controllers/person_details_controller.dart';
import 'package:moontime/models/person.dart';
import 'package:moontime/utilities/colours.dart';
import 'package:moontime/utilities/constants.dart';
import 'package:moontime/views/widgets/back_icon.dart';
import 'package:moontime/views/widgets/card_show.dart';
import 'package:moontime/views/widgets/moontime_placeholder.dart';

class PersonDetails extends GetView<PersonDetailsController> {
  final Person person;

  const PersonDetails({Key? key, required this.person}) : super(key: key);

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
                  imageUrl: '${person.image?.medium}'),
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
                  expandedHeight: ((4 / 6) * context.height),
                  leading: const BackIcon(),
                  actions: [
                    Obx(
                      () => LikeButton(
                          isLiked: (Get.find<FavoritesController>()
                              .favoritePeople
                              .any((e) => e.id == person.id)),
                          onTap: (bool liked) async {
                            Get.find<FavoritesController>()
                                .toggleFavoritePeople(person);
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
                          imageUrl: '${person.image?.original}'),
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
                                        person.name,
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      controller.obx(
                                        onLoading: const SizedBox.shrink(),
                                        onError: (err) =>
                                            const SizedBox.shrink(),
                                        (state) => Row(
                                          children: [
                                            Text(
                                              '${((controller.state?.length ?? 0) < 1) ? 'No' : '${controller.state?.length}'} Show${(controller.state?.length ?? 0) > 1 ? 's' : ''}',
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              strutStyle: const StrutStyle(
                                                  height: 1.2,
                                                  forceStrutHeight: true),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  ?.copyWith(
                                                color: Colors.white,
                                                fontSize: 12,
                                                shadows: <Shadow>[
                                                  Shadow(
                                                    offset:
                                                        const Offset(0.5, 0.5),
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
                                            if (person.birthday != null)
                                              Text(
                                                '    ${DateTime.now().year - person.birthday!.year}yrs',
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                strutStyle: const StrutStyle(
                                                    height: 1.2,
                                                    forceStrutHeight: true),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    ?.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: const Offset(
                                                          0.5, 0.5),
                                                      blurRadius: 1.0,
                                                      // color: Color.fromARGB(255, 0, 0, 0),
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    ],
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
                controller.obx(
                  onEmpty: const SizedBox.shrink(),
                  (state) => (controller.state?.isEmpty ?? true)
                      ? const SizedBox.shrink()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: kFormSpacing,
                                  right: kFormSpacing,
                                  bottom: kFormSpacing / 2),
                              child: Text(
                                'Featured in',
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
                                height: 160,
                                child: (ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kFormSpacing / 2),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.state?.length ?? 0,
                                  itemBuilder:
                                      (BuildContext context, int indexShows) {
                                    return SizedBox(
                                        width: kCardWidthSmall,
                                        child: CardShow(
                                          showBottom: false,
                                          height: 160,
                                          show: controller.state!
                                              .elementAt(indexShows),
                                        ));
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(width: 12),
                                )),
                              ),
                            ),
                          ],
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
