import 'dart:math';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:moontime/models/show.dart';
import 'package:moontime/utilities/colours.dart';
import 'package:moontime/utilities/strings.dart';
import 'package:moontime/views/screens/home.dart';

class CardShow extends StatelessWidget {
  final Show show;

  const CardShow({
    Key? key,
    required this.show,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bRadii = BorderRadius.circular(6);
    return ClipRRect(
      borderRadius: bRadii,
      child: InkWell(
        onTap: () => Get.toNamed(Strings.routeShowDetails, arguments: {Strings.keyShow: show}),
        borderRadius: bRadii,
        child: Column(
          children: [
            CachedNetworkImage(
                fit: BoxFit.cover,
                errorWidget: (c, err, obj) =>
                    const MoontimePlaceholder(logoColor: Colours.redError),
                placeholder: (c, err) => const MoontimePlaceholder(),
                alignment: Alignment.topCenter,
                // height: 100,
                // width: 82,
                imageUrl: '${show.image?.medium}'),
            BlurryContainer(
              blur: 16,
              elevation: 0,
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
              padding: const EdgeInsets.all(0),
              borderRadius: const BorderRadius.all(Radius.circular(0)),
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        show.name,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          fontSize: 12,
                          // color: Colors.white,
                          shadows: <Shadow>[
                            Shadow(
                              offset: const Offset(0.5, 0.5),
                              blurRadius: 2.0,
                              color: Theme.of(context).colorScheme.background,
                              // color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                      // if ((show.rating?.average!=null))
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 8),
                          RatingBar(
                            initialRating: show.rating!.average! / 2,
                            maxRating: 10,
                            minRating: 0,
                            glow: true,
                            glowColor: Colors.white,
                            glowRadius: 100,
                            ignoreGestures: true,
                            itemSize: 10,
                            wrapAlignment: WrapAlignment.center,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 1.0),
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
                              ),
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        ],
                      ),

                      if (show.genres != null &&
                          (show.genres?.isNotEmpty ?? false))
                        Column(
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              show.genres
                                  .toString()
                                  .replaceAll(RegExp(r'[^\w\s]+'), ''),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                fontSize: 10,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: const Offset(0.5, 0.5),
                                    blurRadius: 2.0,
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
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
